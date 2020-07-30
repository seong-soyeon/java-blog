package com.sbs.java.blog.controller;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sbs.java.blog.dto.CateItem;
import com.sbs.java.blog.dto.Member;
import com.sbs.java.blog.service.ArticleService;
import com.sbs.java.blog.service.MemberService;
import com.sbs.java.blog.util.Util;

public abstract class Controller {
	// private로하면 상속 안됨
	// protected 는 외부에 노출은 안되는데 상속은 가능
	protected Connection dbConn;
	protected String actionMethodName;
	protected HttpServletRequest req;
	protected HttpServletResponse resp;
	protected HttpSession session;

	protected ArticleService articleService;
	protected MemberService memberService;

	public Controller(Connection dbConn, String actionMethodName, HttpServletRequest req, HttpServletResponse resp) {
		this.dbConn = dbConn;
		this.actionMethodName = actionMethodName;
		this.req = req;
		this.session = req.getSession();
		this.resp = resp;
		articleService = new ArticleService(dbConn);
		memberService = new MemberService(dbConn);
	}
	
	public abstract String getControllerName();

	// 액션 전 실행 - 이 메서드는 모든 컨트롤러의 모든 액션이 실행되기 전에 실행된다.
	// 모든곳에서 사용해야 할 것을 여기 넣어두면 좋음. (ex,모든곳에서 cateItems를 호출 가능)		
	public void beforeAction() {
		// 만인에 관련된 정보를 리퀘스트 객체에 정리해서 넣기
		List<CateItem> cateItems = articleService.getForPrintCateItems();

		req.setAttribute("cateItems", cateItems);
		
		// 사용자 관련 정보를 리퀘스트 객체에 정리해서 넣기
		//-1설정 안해놓고 그냥 받아오면 loginedMemberId이 null 일 경우 int 형변환 안되서 오류남
		int loginedMemberId = -1;
		boolean isLogined = false;
		Member loginedMember = null;
			
		if ( session.getAttribute("loginedMemberId") != null ) {
			loginedMemberId = (int)session.getAttribute("loginedMemberId");
			isLogined = true;
			loginedMember = memberService.getMemberById(loginedMemberId);
		}
		req.setAttribute("loginedMemberId", loginedMemberId);
		req.setAttribute("loginedMember", loginedMember);
		req.setAttribute("isLogined", isLogined);			
		
		// 현재 URL (URI : 포트번호뒤부터 ?앞까지 / QueryString : url중 ?뒷부분)
		String currentUrl = req.getRequestURI();
		
		if (req.getQueryString() != null) {
			currentUrl += "?" + req.getQueryString();
		}

		String urlEncodedCurrentUrl = Util.getUrlEncoded(currentUrl);

		// 현재 접속된 페이지와 관련된 유용한 정보 담기
		req.setAttribute("currentUrl", currentUrl);
		req.setAttribute("urlEncodedCurrentUrl", urlEncodedCurrentUrl);	// urlEncode라는 암호화가 적용된 CurrentUrl
		req.setAttribute("urlEncodedAfterLoginRedirectUrl", urlEncodedCurrentUrl);
		req.setAttribute("noBaseCurrentUri", req.getRequestURI().replace(req.getContextPath(), ""));
		
		// 로그인 페이지에서 로그인 페이지로 이동하는 버튼을 !!또!! 누른 경우
		// Url 계속 길어지지않고 기존 afterLoginRedirectUrl 정보를 유지시키기 위한 로직
		if (currentUrl.contains("/s/member/login")) { //currentUrl에 ()가 포함이 된다면~
			String urlEncodedOldAfterLoginRedirectUrl = Util.getString(req, "afterLoginRedirectUrl", "");
			urlEncodedOldAfterLoginRedirectUrl = Util.getUrlEncoded(urlEncodedOldAfterLoginRedirectUrl);
			req.setAttribute("urlEncodedAfterLoginRedirectUrl", urlEncodedOldAfterLoginRedirectUrl);
		}
	}

	public void afterAction() {
		// 액션 후 실행
	}

	public abstract String doAction();

	public String executeAction() {
		beforeAction();

		String doGuardRs = doGuard();

		if (doGuardRs != null) {
			return doGuardRs;
		}
		
		String rs = doAction();
		afterAction();

		return rs;
	}

	private String doGuard() {
		// 현재 로그인 됬는지 확인
		boolean isLogined = (boolean) req.getAttribute("isLogined");

		// 로그인에 관련된 가드 시작 //로그인 되어야 되는지 확인
		boolean needToLogin = false;

		String controllerName = getControllerName();

		switch (controllerName) {
		case "member":
			switch (actionMethodName) {
			case "doLogout":
				needToLogin = true;
				break;
			}
			break;
		case "article":
			switch (actionMethodName) {
			case "write":
			case "doWrite":
			case "modify":
			case "doModify":
			case "doDelete":
			case "doReply":
			case "replyModify":
			case "doReplyModify":
			case "doReplyDelete":
				needToLogin = true;
				break;
			}
			break;
		}
		
		String urlEncodedAfterLoginRedirectUrl = (String)req.getAttribute("urlEncodedAfterLoginRedirectUrl");
		
		//로그인이 필요하고 로그인을 안했을 때 
		if (needToLogin && isLogined == false) {
			return "html:<script> alert('로그인 후 이용해주세요.'); location.href = '../member/login?afterLoginRedirectUrl=\" + urlEncodedAfterLoginRedirectUrl + \"'; </script>";
		}
		// 로그인에 관련된 가드 끝

		// 로그아웃에 관련된 가드 시작
		// 로아아웃이 되어야만 행 할 수 있는
		boolean needToLogout = false;

		switch (controllerName) {
		case "member":
			switch (actionMethodName) {
			case "login":
			case "join":
				needToLogout = true;
				break;
			}
			break;
		}

		if (needToLogout && isLogined ) {
			return "html:<script> alert('로그아웃 후 이용해주세요.'); history.back(); </script>";
		}
		// 로그아웃에 관련된 가드 끝

		return null;
	}
}