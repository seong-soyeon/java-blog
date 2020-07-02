package com.sbs.java.blog.dao;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sbs.java.blog.dto.Article;
import com.sbs.java.blog.util.DBUtil;

public class ArticleDao {
	private Connection dbConn;
	
	public ArticleDao(Connection dbConn) {
		this.dbConn = dbConn;
	}
	
	public List<Article> getForPrintListArticles(int page, int itemsInAPage, int cateItemId) {
		String sql = "";

		
		int limitFrom = (page - 1) * itemsInAPage;

		sql += String.format("SELECT * ");
		sql += String.format("FROM article ");
		sql += String.format("WHERE displayStatus = 1 ");
		if (cateItemId != 0) {
			sql += String.format("AND cateItemId = %d ", cateItemId);
		}
		sql += String.format("ORDER BY id DESC ");
		sql += String.format("LIMIT %d, %d ", limitFrom, itemsInAPage);

		List<Map<String, Object>> rows = DBUtil.selectRows(dbConn, sql);
		List<Article> articles = new ArrayList<>();

		for (Map<String, Object> row : rows) {
			articles.add(new Article(row));
		}

		return articles;
	}

	public Article getForPrintDetailArticle(int id) {
		String sql = "";

		sql += String.format("SELECT * ");
		sql += String.format("FROM article ");
		sql += String.format("WHERE id = %d ", id);

		Map<String, Object> row = DBUtil.selectRow(dbConn, sql);

		return new Article(row);
	}

	public void doWriteArticle(int cateItemId, String title, String body) {
		String sql = "";
		sql += String.format("INSERT INTO article ");
		sql += String.format("SET regDate = NOW()");
		sql += String.format(", updateDate = NOW()");
		sql += String.format(", displayStatus = 1");
		sql += String.format(", cateItemId = %d", cateItemId);
		sql += String.format(", title = '%s'", title);
		sql += String.format(", body = '%s'", body);
		
		DBUtil.insert(dbConn, sql);
	}

	public int getForPrintListArticlesCount(int cateItemId) {
		String sql = "";

		sql += String.format("SELECT COUNT(*) AS cnt ");
		sql += String.format("FROM article ");
		sql += String.format("WHERE displayStatus = 1 ");
		if (cateItemId != 0) {
			sql += String.format("AND cateItemId = %d ", cateItemId);
		}

		int count = DBUtil.selectRowIntValue(dbConn, sql);
		return count;
	}

}
