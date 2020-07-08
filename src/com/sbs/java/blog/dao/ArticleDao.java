package com.sbs.java.blog.dao;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sbs.java.blog.dto.Article;
import com.sbs.java.blog.dto.CateItem;
import com.sbs.java.blog.util.DBUtil;

public class ArticleDao extends Dao {
	private Connection dbConn;

	public ArticleDao(Connection dbConn) {
		this.dbConn = dbConn;
	}
	
	public List<Article> getForPrintListArticles(int page, int itemsInAPage, int cateItemId, String searchKeywordType,
			String searchKeyword) {
		String sql = "";

		int limitFrom = (page - 1) * itemsInAPage;

		sql += String.format("SELECT * ");
		sql += String.format("FROM article ");
		sql += String.format("WHERE displayStatus = 1 ");
		if (cateItemId != 0) {
			sql += String.format("AND cateItemId = %d ", cateItemId);
		}
		if (searchKeywordType.equals("title") && searchKeyword.length() > 0) {
			sql += String.format("AND title LIKE CONCAT('%%', '%s', '%%')", searchKeyword);
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

	public int getForPrintListArticlesCount(int cateItemId, String searchKeywordType, String searchKeyword) {
		String sql = "";

		sql += String.format("SELECT COUNT(*) AS cnt ");
		sql += String.format("FROM article ");
		sql += String.format("WHERE displayStatus = 1 ");

		if (cateItemId != 0) {
			sql += String.format("AND cateItemId = %d ", cateItemId);
		}

		if (searchKeywordType.equals("title") && searchKeyword.length() > 0) {
			sql += String.format("AND title LIKE CONCAT('%%', '%s', '%%')", searchKeyword);
		}

		int count = DBUtil.selectRowIntValue(dbConn, sql);
		return count;
	}

	public Article getForPrintArticle(int id) {
		String sql = "";
//extra 추가로 받음
		sql += String.format("SELECT *, '성소연' AS extra__writer ");
		sql += String.format("FROM article ");
		sql += String.format("WHERE 1 ");
		sql += String.format("AND id = %d ", id);
		sql += String.format("AND displayStatus = 1 ");

		return new Article(DBUtil.selectRow(dbConn, sql));
	}
	
	public List<CateItem> getForPrintCateItems() {
		String sql = "";

		sql += String.format("SELECT * ");
		sql += String.format("FROM cateItem ");
		sql += String.format("WHERE 1 ");
		sql += String.format("ORDER BY id ASC ");

		List<Map<String, Object>> rows = DBUtil.selectRows(dbConn, sql);
		List<CateItem> cateItems = new ArrayList<>();

		for (Map<String, Object> row : rows) {
			cateItems.add(new CateItem(row));
		}

		return cateItems;
	}

	public CateItem getCateItem(int cateItemId) {
		String sql = "";

		sql += String.format("SELECT * ");
		sql += String.format("FROM cateItem ");
		sql += String.format("WHERE 1 ");
		sql += String.format("AND id = %d ", cateItemId);

		return new CateItem(DBUtil.selectRow(dbConn, sql));
	}

	public int write(int cateItemId, String title, String body) {
		String sql = "";
		
		sql += String.format("INSERT INTO article ");
		sql += String.format("SET regDate = NOW()");
		sql += String.format(", updateDate = NOW()");
		sql += String.format(", displayStatus = 1");
		sql += String.format(", cateItemId = %d", cateItemId);
		sql += String.format(", title = '%s'", title);
		sql += String.format(", body = '%s'", body);
		
		return DBUtil.insert(dbConn, sql);
	}
}