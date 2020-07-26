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

		for ( Article article : articles ) {
			updateArticleExtraDataForPrint(article, actorId);
		}

		return articles;
	}
	
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

	public void modify(int id, int cateItemId, String title, String body) {
		articleDao.modify(id, cateItemId, title, body);
	}

	public int getReply(String body, int articleId, int memberId) {
		return articleDao.getArticleReply(body, articleId, memberId);
	}

	public List<ArticleReply> getForPrintListArticleReplies(int id) {
		return articleDao.getForPrintListArticleReplies(id);
	}

	public void deleteReply(int replyId) {
		articleDao.deleteReply(replyId);
	}

	private Map<String, Object> getCheckRsModifyAvailable(Article article, int actorId) {
		return getCheckRsDeleteAvailable(article, actorId);
	}
	
	public Map<String, Object> getCheckRsDeleteAvailable(int id, int actorId) {
		Article article = articleDao.getForPrintArticle(id);

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
			rs.put("msg", "권한이 없습니다.");

			return rs;
		}

		rs.put("resultCode", "S-1");//success
		rs.put("msg", "작업이 가능합니다.");

		return rs;
	}
}
