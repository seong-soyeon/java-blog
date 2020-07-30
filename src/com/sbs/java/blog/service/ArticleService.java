package com.sbs.java.blog.service;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sbs.java.blog.dao.ArticleDao;
import com.sbs.java.blog.dto.Article;
import com.sbs.java.blog.dto.ArticleReply;
import com.sbs.java.blog.dto.CateItem;
import com.sbs.java.blog.util.Util;

public class ArticleService extends Service {

	private ArticleDao articleDao;
	
	public ArticleService(Connection dbConn) {
		articleDao = new ArticleDao(dbConn);
	}

	public List<Article> getForPrintListArticles(int actorId, int page, int itemsInAPage, int cateItemId, String searchKeywordType, String searchKeyword) {
		List<Article> articles = articleDao.getForPrintListArticles(page, itemsInAPage, cateItemId, searchKeywordType, searchKeyword);
		
		//actorId가 article을 삭제 할 수 있는지 여부 필터링
		for ( Article article : articles ) {
			updateArticleExtraDataForPrint(article, actorId);
		}

		return articles;
	}
	
	//actorId가 article을 삭제 할 수 있는지 여부
	private void updateArticleExtraDataForPrint(Article article, int actorId) {
		boolean deleteAvailable = Util.isSuccess(getCheckRsDeleteAvailable(article, actorId));
		article.getExtra().put("deleteAvailable", deleteAvailable);

		boolean modifyAvailable = Util.isSuccess(getCheckRsModifyAvailable(article, actorId));
		article.getExtra().put("modifyAvailable", modifyAvailable);
		
	}

	public int getForPrintListArticlesCount(int cateItemId, String searchKeywordType, String searchKeyword) {
		return articleDao.getForPrintListArticlesCount(cateItemId, searchKeywordType, searchKeyword);
	}
	
	public Article getForPrintArticle(int id, int actorId) {
		Article article = articleDao.getForPrintArticle(id);

		updateArticleExtraDataForPrint(article, actorId);

		return article;
	}
	
	public List<CateItem> getForPrintCateItems() {
		return articleDao.getForPrintCateItems();
	}

	public CateItem getCateItem(int cateItemId) {
		return articleDao.getCateItem(cateItemId);
	}

	public int write(int cateItemId, String title, String body, int memberId) {
		return articleDao.write(cateItemId, title, body, memberId);
	}

	public void increaseHit(int id) {
		articleDao.increaseHit(id);
	}

	public void deleteArticle(int id) {
		articleDao.deleteArticle(id);
	}

	public void modifyArticle(int id, int cateItemId, String title, String body) {
		articleDao.modifyArticle(id, cateItemId, title, body);
	}

	public int writeArticleReply(int articleId, int memberId, String body) {
		return articleDao.writeArticleReply(articleId, memberId, body);
	}

	public List<ArticleReply> getForPrintListArticleReplies(int articleId, int actorId) {
		List<ArticleReply> articleReplise = articleDao.getForPrintListArticleReplies(articleId, actorId);
		
		//actorId가 article을 삭제 할 수 있는지 여부 필터링
		for ( ArticleReply articleReply : articleReplise ) {
			updateArticleReplyExtraDataForPrint(articleReply, actorId);
		}

		return articleReplise;
	}

	private void updateArticleReplyExtraDataForPrint(ArticleReply articleReply, int actorId) {
		// TODO Auto-generated method stub
		
	}

	public void deleteReply(int replyId) {
		articleDao.deleteReply(replyId);
	}

	//delete와 modify의 접근 권한이 같으므로 일 떠넘기기
	private Map<String, Object> getCheckRsModifyAvailable(Article article, int actorId) {
		return getCheckRsDeleteAvailable(article, actorId);
	}

	private Map<String, Object> getCheckRsDeleteAvailable(Article article, int actorId) {
		Map<String, Object> rs = new HashMap<>();
		
		if ( article == null ) {
			rs.put("resultCode", "F-1"); //fail 1
			rs.put("msg", "존재하지 않는 게시물 입니다.");

			return rs;
		}

		if ( article.getMemberId() != actorId ) {
			rs.put("resultCode", "F-2");
			rs.put("msg", "권한이 없습니다.(작성자만 가능)");

			return rs;
		}

		rs.put("resultCode", "S-1");//success
		rs.put("msg", "작업이 가능합니다.");

		return rs;
	}
	
	//id를 아티클로 바꿔 위 함수로 보내기
	public Map<String, Object> getCheckRsDeleteAvailable(int id, int actorId) {
		Article article = articleDao.getForPrintArticle(id);

		return getCheckRsDeleteAvailable(article, actorId);
	}

	public Map<String, Object> getCheckRsModifyAvailable(int id, int actorId) {
		return getCheckRsDeleteAvailable(id, actorId);
	}
}
