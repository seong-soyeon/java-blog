package com.sbs.java.blog.controller;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.java.blog.dto.Article;
import com.sbs.java.blog.dto.ArticleReply;
import com.sbs.java.blog.dto.CateItem;
import com.sbs.java.blog.util.Util;

public class ArticleController extends Controller {
	public ArticleController(Connection dbConn, String actionMethodName, HttpServletRequest req,
			HttpServletResponse resp) {
		super(dbConn, actionMethodName, req, resp);
	}

	public void beforeAction() {
		super.beforeAction();
		// 이 메서드는 게시물 컨트롤러의 모든 액션이 실행되기 전에 실행된다.
		// 필요없다면 지워도 된다.
	}

	public String doAction() {
		switch (actionMethodName) {
		case "list":
			return doActionList();
		case "detail":
			return doActionDetail();
		case "write":
			return doActionWrite();
		case "doWrite":
			return doActionDoWrite();
		case "delete":
			return doActionDoDelete();
		case "modify":
			return doActionModify();
		case "doModify":
			return doActionDoModify();
		case "doWriteReply":
			return doActionDoWriteReply();
		case "replyModify":
			return doActionReplyModify();
		case "doReplyModify":
			return doActionDoReplyModify();
		case "doDeleteReply":
			return doActionDoDeleteReply();
		}
		return "";
	}

	private String doActionDoDeleteReply() {
		// TODO Auto-generated method stub
		if (Util.empty(req, "id")) {
			return "html:id를 입력해주세요.";
		}
		if (Util.isNum(req, "id") == false) {
			return "html:id를 정수로 입력해주세요.";
		}
		int id = Util.getInt(req, "id");

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		// 삭제 전 삭제가능여부 체크
		Map<String, Object> getReplyCheckRsDeleteAvailableRs = articleService.getReplyCheckRsDeleteAvailable(id, loginedMemberId);

		// false이면 getCheckRsDeleteAvailable에서 맞는 msg나오고 히스토리백
		if (Util.isSuccess(getReplyCheckRsDeleteAvailableRs) == false) {
			return "html:<script> alert('" + getReplyCheckRsDeleteAvailableRs.get("msg") + "'); history.back(); </script>";
		}

		articleService.deleteArticleReply(id);
		
		String redirectUrl = Util.getString(req, "redirectUrl", "list");
		
		return "html:<script> alert('" + id + "번 댓글이 삭제되었습니다.'); location.replace('" + redirectUrl + "'); </script>";
	}

	private String doActionReplyModify() {
		// TODO
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		int id = 0;
		if (!Util.empty(req, "id") && Util.isNum(req, "id")) {
			id = Util.getInt(req, "id");
		}

		// ArticleReply articleReply = articleService.getForPrintArticleReplyModify(id);
		// req.setAttribute("articleReply", articleReply);

		return "article/replymodify.jsp";
	}

	private String doActionDoReplyModify() {
		// TODO Auto-generated method stub
		int id = 0;
		if (!Util.empty(req, "id") && Util.isNum(req, "id")) {
			id = Util.getInt(req, "id");
		}

		String body = req.getParameter("body");

		// articleService.doActionDoModify(id, body);

		System.out.println("lololol");
		return "html:<script> alert('" + id + "번 게시물이 수정되었습니다.'); location.replace('list'); </script>";
	}

	private String doActionDoWriteReply() {
		// article Id가져오기
		int articleId = 0;
		if (!Util.empty(req, "articleId") && Util.isNum(req, "articleId")) {
			articleId = Util.getInt(req, "articleId");
		}

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		String body = req.getParameter("body");
		String redirectUrl = Util.getString(req, "redirectUrl");

		int id = articleService.writeArticleReply(articleId, loginedMemberId, body);

		//새로 만들어진 아티클댓글id을 redirectUrl 뒤에 붙임 (redirectUrl&generatedArticleReplyId=id)
		redirectUrl = Util.adParamFrom(redirectUrl, "generatedArticleReplyId", id);

		return "html:<script> alert('" + id + "번 댓글이 작성되었습니다.'); location.replace('" + redirectUrl + "'); </script>";
	}

	private String doActionDoModify() {
		int id = 0;
		if (!Util.empty(req, "id") && Util.isNum(req, "id")) {
			id = Util.getInt(req, "id");
		}

		int cateItemId = 0;
		if (!Util.empty(req, "cateItemId") && Util.isNum(req, "cateItemId")) {
			cateItemId = Util.getInt(req, "cateItemId");
		}

		String title = req.getParameter("title");
		String body = req.getParameter("body");

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		Map<String, Object> getCheckRsModifyAvailableRs = articleService.getCheckRsModifyAvailable(id, loginedMemberId);

		if (Util.isSuccess(getCheckRsModifyAvailableRs) == false) {
			return "html:<script> alert('" + getCheckRsModifyAvailableRs.get("msg") + "'); history.back(); </script>";
		}

		articleService.modifyArticle(id, cateItemId, title, body);

		return "html:<script> alert('" + id + "번 게시물이 수정되었습니다.'); location.replace('detail?id=" + id + "'); </script>";
	}

	private String doActionModify() {
		if (Util.empty(req, "id")) {
			return "html:id를 입력해주세요.";
		}

		if (Util.isNum(req, "id") == false) {
			return "html:id를 정수로 입력해주세요.";
		}

		int id = Util.getInt(req, "id");

		// cateItemName가져오기
		int cateItemId = 0;

		if (!Util.empty(req, "cateItemId") && Util.isNum(req, "cateItemId")) {
			cateItemId = Util.getInt(req, "cateItemId");
		}

		String cateItemName = "전체";

		if (cateItemId != 0) {
			CateItem cateItem = articleService.getCateItem(cateItemId);
			cateItemName = cateItem.getName();
		}
		req.setAttribute("cateItemName", cateItemName);
		// cateItemName가져오기 끝

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		// articleService.increaseHit(id);
		Article article = articleService.getForPrintArticle(id, loginedMemberId);
		req.setAttribute("article", article);

		return "article/modify.jsp";
	}

	private String doActionWrite() {
		return "article/write.jsp";
	}

	private String doActionDoWrite() {
		// displayStatus는 Dao에서 1로 임의로 지정
		String title = req.getParameter("title");
		String body = req.getParameter("body");
		int cateItemId = Util.getInt(req, "cateItemId");

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		int id = articleService.write(cateItemId, title, body, loginedMemberId);

		// 꼭 자바스크립트 명령어인 location.replace로 이동하기 (기존페이지를 새로운 페이지로 변경시킨다)(location.href과 다름)
		// 주소히스토리를 남기지 않는다 >> 이전페이지로 접근이 필요없는경우 보안상 좋다
		// 히스토리가 남을경우 뒤로가기 눌렀을때 다시 같은자리로와서 글 중복 생성될 수 있다.
		return "html:<script> alert('" + id + "번 게시물이 생성되었습니다.'); location.replace('list'); </script>";
	}

	private String doActionDoDelete() {
		if (Util.empty(req, "id")) {
			return "html:id를 입력해주세요.";
		}

		if (Util.isNum(req, "id") == false) {
			return "html:id를 정수로 입력해주세요.";
		}
		int id = Util.getInt(req, "id");

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		System.out.println(loginedMemberId);

		// 삭제 전 삭제가능여부 체크
		Map<String, Object> getCheckRsDeleteAvailableRs = articleService.getCheckRsDeleteAvailable(id, loginedMemberId);

		// false이면 getCheckRsDeleteAvailable에서 맞는 msg나오고 히스토리백
		if (Util.isSuccess(getCheckRsDeleteAvailableRs) == false) {
			return "html:<script> alert('" + getCheckRsDeleteAvailableRs.get("msg") + "'); history.back(); </script>";
		}

		articleService.deleteArticle(id);

		return "html:<script> alert('" + id + "번 게시물이 삭제되었습니다.'); location.replace('list'); </script>";
	}

	private String doActionDetail() {
		if (Util.empty(req, "id")) {
			return "html:id를 입력해주세요.";
		}

		if (Util.isNum(req, "id") == false) {
			return "html:id를 정수로 입력해주세요.";
		}

		int id = Util.getInt(req, "id");

		// cateItemName가져오기
		int cateItemId = 0;
		if (!Util.empty(req, "cateItemId") && Util.isNum(req, "cateItemId")) {
			cateItemId = Util.getInt(req, "cateItemId");
		}

		String cateItemName = "전체";

		if (cateItemId != 0) {
			CateItem cateItem = articleService.getCateItem(cateItemId);
			cateItemName = cateItem.getName();
		}
		req.setAttribute("cateItemName", cateItemName);
		// cateItemName가져오기 끝
		req.setAttribute("cateItemId", cateItemId);

		articleService.increaseHit(id);

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		Article article = articleService.getForPrintArticle(id, loginedMemberId);
		req.setAttribute("article", article);

		List<ArticleReply> articleReplies = articleService.getForPrintListArticleReplies(id, loginedMemberId);
		req.setAttribute("articleReplies", articleReplies);

		return "article/detail.jsp";
	}

	private String doActionList() {
		// list 시간측정
		long startTime = System.nanoTime();

		int page = 1;

		if (!Util.empty(req, "page") && Util.isNum(req, "page")) {
			page = Util.getInt(req, "page");
		}

		int cateItemId = 0;

		if (!Util.empty(req, "cateItemId") && Util.isNum(req, "cateItemId")) {
			cateItemId = Util.getInt(req, "cateItemId");
		}

		String cateItemName = "전체";

		if (cateItemId != 0) {
			CateItem cateItem = articleService.getCateItem(cateItemId);
			cateItemName = cateItem.getName();
		}
		req.setAttribute("cateItemName", cateItemName);

		String searchKeywordType = "";

		if (!Util.empty(req, "searchKeywordType")) {
			searchKeywordType = Util.getString(req, "searchKeywordType");
		}

		String searchKeyword = "";

		if (!Util.empty(req, "searchKeyword")) {
			searchKeyword = Util.getString(req, "searchKeyword");
		}

		int itemsInAPage = 10;
		int totalCount = articleService.getForPrintListArticlesCount(cateItemId, searchKeywordType, searchKeyword);
		int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);

		req.setAttribute("totalCount", totalCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("page", page);

		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		List<Article> articles = articleService.getForPrintListArticles(loginedMemberId, page, itemsInAPage, cateItemId,
				searchKeywordType, searchKeyword);
		// service에서 받아온 articles를 req에 담음>담은 정보를 App에서 jsp로 넘김
		req.setAttribute("articles", articles);

		// list 시간측정
		long endTime = System.nanoTime();
		long estimatedTime = endTime - startTime;
		// nano seconds to seconds
		double seconds = estimatedTime / 1000000000.0;
		System.out.println("seconds : " + seconds);

		return "article/list.jsp";
	}

	@Override
	public String getControllerName() {
		return "article";
	}
}
/*
 * int itemsInAPage = 5; //한 페이지에 나오는 게시물 수 int limitFrom = (page - 1) *
 * itemsInAPage;
 * 
 * 
 * int totalCount = 0; // Math.ceil() 소수점 이하를 올림한다. int totalPage = (int)
 * Math.ceil((double)totalCount/itemsInAPage);
 */