package com.sbs.java.blog.service;

import java.sql.Connection;
import java.util.List;

import com.sbs.java.blog.dao.ArticleDao;
import com.sbs.java.blog.dto.Article;
import com.sbs.java.blog.dto.CateItem;

public class ArticleService extends Service {

	private ArticleDao articleDao;
	
	public ArticleService(Connection dbConn) {
		articleDao = new ArticleDao(dbConn);
	}

	public List<Article> getForPrintListArticles(int page, int itemsInAPage, int cateItemId, String searchKeywordType, String searchKeyword) {
		return articleDao.getForPrintListArticles(page, itemsInAPage, cateItemId, searchKeywordType, searchKeyword);
	}
	
	public int getForPrintListArticlesCount(int cateItemId, String searchKeywordType, String searchKeyword) {
		return articleDao.getForPrintListArticlesCount(cateItemId, searchKeywordType, searchKeyword);
	}
	
	public Article getForPrintArticle(int id) {
		return articleDao.getForPrintArticle(id);
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

	public int doActionDelete(int id) {
		return articleDao.doActionDelete(id);
	}

	public void doActionDoModify(int id, int cateItemId, String title, String body) {
		articleDao.doActionDoModify(id, cateItemId, title, body);
	}

	public int getReply(String body, int articleId, int memberId) {
		// TODO Auto-generated method stub
		return articleDao.getArticleReply(body, articleId, memberId);
	}
	
}
