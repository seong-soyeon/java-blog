package com.sbs.java.blog.dao;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sbs.java.blog.dto.Article;
import com.sbs.java.blog.dto.ArticleReply;
import com.sbs.java.blog.dto.CateItem;
import com.sbs.java.blog.util.DBUtil;
import com.sbs.java.blog.util.SecSql;

public class ArticleDao extends Dao {
	private Connection dbConn;

	public ArticleDao(Connection dbConn) {
		this.dbConn = dbConn;
	}
	
	public List<Article> getForPrintListArticles(int page, int itemsInAPage, int cateItemId, String searchKeywordType, String searchKeyword) {
		SecSql secSql = new SecSql();

		int limitFrom = (page - 1) * itemsInAPage;

		secSql.append("SELECT *");
		secSql.append("FROM article");
		secSql.append("WHERE displayStatus = 1");
		if (cateItemId != 0) {
			secSql.append("AND cateItemId = ?", cateItemId);
		}
		if (searchKeywordType.equals("title") && searchKeyword.length() > 0) {
			secSql.append("AND title LIKE CONCAT('%', ?, '%')", searchKeyword);
		}
		secSql.append("ORDER BY id DESC");
		secSql.append("LIMIT ?, ? ", limitFrom, itemsInAPage);

		//Map이 테이블에 들어가는 아티클 하나 라고 보면 됨 //selectRows로 map에 넣어줌
		List<Map<String, Object>> rows = DBUtil.selectRows(dbConn, secSql);
		//담을 변수를 만듬
		List<Article> articles = new ArrayList<>();
		//map으로 구성 된 리스트를 받아서 아티클 객체로 만듬
		for (Map<String, Object> row : rows) {
			articles.add(new Article(row));
		}

		return articles;
	}


	public int getForPrintListArticlesCount(int cateItemId, String searchKeywordType, String searchKeyword) {
		SecSql secSql = new SecSql();

		secSql.append("SELECT COUNT(*) AS cnt");
		secSql.append("FROM article");
		secSql.append("WHERE displayStatus = 1");

		if (cateItemId != 0) {
			secSql.append("AND cateItemId = ?", cateItemId);
		}

		if (searchKeywordType.equals("title") && searchKeyword.length() > 0) {
			secSql.append("AND title LIKE CONCAT('%', ?, '%')", searchKeyword);
		}

		int count = DBUtil.selectRowIntValue(dbConn, secSql);
		return count;
	}

	public Article getForPrintArticle(int id) {
		SecSql secSql = new SecSql();
		//extra 추가로 받음
		secSql.append("SELECT *, '성소연' AS extra__writer");
		secSql.append("FROM article");
		secSql.append("WHERE 1");
		secSql.append("AND id = ? ", id);
		secSql.append("AND displayStatus = 1");

		return new Article(DBUtil.selectRow(dbConn, secSql));
	}
	
	public List<CateItem> getForPrintCateItems() {
		SecSql secSql = new SecSql();

		secSql.append("SELECT *");
		secSql.append("FROM cateItem");
		secSql.append("WHERE 1");
		secSql.append("ORDER BY id ASC");

		List<Map<String, Object>> rows = DBUtil.selectRows(dbConn, secSql);
		List<CateItem> cateItems = new ArrayList<>();

		for (Map<String, Object> row : rows) {
			cateItems.add(new CateItem(row));
		}

		return cateItems;
	}

	public CateItem getCateItem(int cateItemId) {
		SecSql secSql = new SecSql();

		secSql.append("SELECT *");
		secSql.append("FROM cateItem");
		secSql.append("WHERE 1");
		secSql.append("AND id = ?", cateItemId);

		return new CateItem(DBUtil.selectRow(dbConn, secSql));
	}

	public int write(int cateItemId, String title, String body, int memberId) {
		// 띄어쓰기 틀리거나 %s를 ? 쳐도 오류안나도록 바꿈
		SecSql secSql = new SecSql();

		secSql.append("INSERT INTO article");
		secSql.append("SET regDate = NOW()");
		secSql.append(", updateDate = NOW()");
		secSql.append(", displayStatus = '1'");
		secSql.append(", cateItemId = ?", cateItemId);
		secSql.append(", title = ?", title);
		secSql.append(", body = ?", body);
		secSql.append(", hit = '0'");
		secSql.append(", memberId = ?", memberId);
		
		/*
		String sql = "";
		
		sql += String.format("INSERT INTO article ");
		sql += String.format("SET regDate = NOW()");
		sql += String.format(", updateDate = NOW()");
		sql += String.format(", displayStatus = 1");
		sql += String.format(", cateItemId = %d", cateItemId);
		sql += String.format(", title = '%s'", title);
		sql += String.format(", body = '%s'", body);
		
		return DBUtil.insert(dbConn, sql);
		*/
		return DBUtil.insert(dbConn, secSql);
	}

	public int increaseHit(int id) {
		SecSql sql = SecSql.from("UPDATE article");
		sql.append("SET hit = hit + 1");
		sql.append("WHERE id = ?", id);

		return DBUtil.update(dbConn, sql);
	}

	public int doActionDelete(int id) {
		SecSql secSql = new SecSql();
		
		secSql.append("DELETE FROM article ");
		secSql.append("WHERE id = ? ", id);

		return DBUtil.update(dbConn, secSql);
	}

	public int doActionDoModify(int id, int cateItemId, String title, String body) {
		SecSql secSql = new SecSql();

		secSql.append("UPDATE article");
		secSql.append("SET updateDate = NOW()");
		secSql.append(", displayStatus = '1'");
		secSql.append(", cateItemId = ?", cateItemId);
		secSql.append(", title = ?", title);
		secSql.append(", body = ?", body);
		secSql.append("WHERE id = ?", id);
		
		return DBUtil.update(dbConn, secSql);
	}
	
	public int getArticleReply(String body, int articleId, int memberId) {
		SecSql sql = SecSql.from("INSERT INTO articleReply");
		sql.append("SET regDate = NOW()");
		sql.append(", updateDate = NOW()");
		sql.append(", articleId = ?", articleId);
		sql.append(", `body` = ?", body);
		sql.append(", memberId = ?", memberId);

		return DBUtil.insert(dbConn, sql);
	}

	public List<ArticleReply> getForPrintListArticleReplies(int id) {
		// TODO Auto-generated method stub
		
		SecSql sql = SecSql.from("SELECT *");
		sql.append("FROM articleReply AS A");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON A.memberId = M.id");
		sql.append("WHERE articleId = ?", id);
		sql.append("ORDER BY A.id DESC");

		List<Map<String, Object>> rows = DBUtil.selectRows(dbConn, sql);
		List<ArticleReply> articleReplies = new ArrayList<>();

		for (Map<String, Object> row : rows) {
			articleReplies.add(new ArticleReply(row));
		}
		return articleReplies;
	}
}