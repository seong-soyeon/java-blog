package com.sbs.java.blog.service;

import java.sql.Connection;
import java.util.List;

import com.sbs.java.blog.dao.ArticleDao;
import com.sbs.java.blog.dto.Article;

public class ArticleService {

	private ArticleDao articleDao;
	
	public ArticleService(Connection dbConn) {
		articleDao = new ArticleDao(dbConn);
	}


	public List<Article> getForPrintListArticles(int page, int itemsInAPage, int cateItemId) {
		return articleDao.getForPrintListArticles(page, itemsInAPage, cateItemId);
	}

	public Article getForPrintDetailArticle(int id) {
		return articleDao.getForPrintDetailArticle(id);
	}

	public void doWriteArticle(int cateItemId, String title, String body) {
		articleDao.doWriteArticle(cateItemId, title, body);
	}


	public int getForPrintListArticlesCount(int cateItemId) {
		return articleDao.getForPrintListArticlesCount(cateItemId);
	}
}
