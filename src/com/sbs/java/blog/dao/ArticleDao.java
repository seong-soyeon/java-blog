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
		SecSql sql = new SecSql();

		int limitFrom = (page - 1) * itemsInAPage;

		sql.append("SELECT *");
		sql.append("FROM article");
		sql.append("WHERE displayStatus = 1");
		if (cateItemId != 0) {
			sql.append("AND cateItemId = ?", cateItemId);
		}
		if (searchKeywordType.equals("title") && searchKeyword.length() > 0) {
			sql.append("AND title LIKE CONCAT('%', ?, '%')", searchKeyword);
		}
		sql.append("ORDER BY id DESC");
		sql.append("LIMIT ?, ? ", limitFrom, itemsInAPage);

		//Map이 테이블에 들어가는 아티클 하나 라고 보면 됨 //selectRows로 map에 넣어줌
		List<Map<String, Object>> rows = DBUtil.selectRows(dbConn, sql);
		//담을 변수를 만듬
		List<Article> articles = new ArrayList<>();
		//map으로 구성 된 리스트를 받아서 아티클 객체로 만듬
		for (Map<String, Object> row : rows) {
			articles.add(new Article(row));
		}

		return articles;
	}


	public int getForPrintListArticlesCount(int cateItemId, String searchKeywordType, String searchKeyword) {
		SecSql sql = new SecSql();

		sql.append("SELECT COUNT(*) AS cnt");
		sql.append("FROM article");
		sql.append("WHERE displayStatus = 1");

		if (cateItemId != 0) {
			sql.append("AND cateItemId = ?", cateItemId);
		}

		if (searchKeywordType.equals("title") && searchKeyword.length() > 0) {
			sql.append("AND title LIKE CONCAT('%', ?, '%')", searchKeyword);
		}

		int count = DBUtil.selectRowIntValue(dbConn, sql);
		return count;
	}

	public Article getForPrintArticle(int id) {
		SecSql sql = new SecSql();
		//extra 추가로 받음
		sql.append("SELECT *, '성소연' AS extra__writer");
		sql.append("FROM article");
		sql.append("WHERE 1");
		sql.append("AND id = ? ", id);
		sql.append("AND displayStatus = 1");

		return new Article(DBUtil.selectRow(dbConn, sql));
	}
	
	public List<CateItem> getForPrintCateItems() {
		SecSql sql = new SecSql();

		sql.append("SELECT *");
		sql.append("FROM cateItem");
		sql.append("WHERE 1");
		sql.append("ORDER BY id ASC");

		List<Map<String, Object>> rows = DBUtil.selectRows(dbConn, sql);
		List<CateItem> cateItems = new ArrayList<>();

		for (Map<String, Object> row : rows) {
			cateItems.add(new CateItem(row));
		}

		return cateItems;
	}

	public CateItem getCateItem(int cateItemId) {
		SecSql sql = new SecSql();

		sql.append("SELECT *");
		sql.append("FROM cateItem");
		sql.append("WHERE 1");
		sql.append("AND id = ?", cateItemId);

		return new CateItem(DBUtil.selectRow(dbConn, sql));
	}

	public int write(int cateItemId, String title, String body, int memberId) {
		// 띄어쓰기 틀리거나 %s를 ? 쳐도 오류안나도록 바꿈
		SecSql sql = new SecSql();

		sql.append("INSERT INTO article");
		sql.append("SET regDate = NOW()");
		sql.append(", updateDate = NOW()");
		sql.append(", displayStatus = '1'");
		sql.append(", cateItemId = ?", cateItemId);
		sql.append(", title = ?", title);
		sql.append(", body = ?", body);
		sql.append(", hit = '0'");
		sql.append(", memberId = ?", memberId);
		
		return DBUtil.insert(dbConn, sql);
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
	}

	public int increaseHit(int id) {
		SecSql sql = SecSql.from("UPDATE article");
		
		sql.append("SET hit = hit + 1");
		sql.append("WHERE id = ?", id);

		return DBUtil.update(dbConn, sql);
	}

	public int deleteArticle(int id) {
		SecSql sql = SecSql.from("DELETE FROM article ");
		sql.append("WHERE id = ? ", id);

		return DBUtil.delete(dbConn, sql);
	}

	public int modifyArticle(int id, int cateItemId, String title, String body) {
		SecSql sql = new SecSql();

		sql.append("UPDATE article");
		sql.append("SET updateDate = NOW()");
		sql.append(", displayStatus = '1'");
		sql.append(", cateItemId = ?", cateItemId);
		sql.append(", title = ?", title);
		sql.append(", body = ?", body);
		sql.append("WHERE id = ?", id);
		
		return DBUtil.update(dbConn, sql);
	}
	
	public int writeArticleReply(int articleId, int memberId, String body) {
		SecSql sql = SecSql.from("INSERT INTO articleReply");
		
		sql.append("SET regDate = NOW()");
		sql.append(", updateDate = NOW()");
		sql.append(", articleId = ?", articleId);
		sql.append(", `body` = ?", body);
		sql.append(", memberId = ?", memberId);

		return DBUtil.insert(dbConn, sql);
	}

	public List<ArticleReply> getForPrintListArticleReplies(int articleId, int actorId) {
		SecSql sql = SecSql.from("SELECT *");
		
		sql.append("FROM articleReply AS A");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON A.memberId = M.id");
		sql.append("WHERE articleId = ?", articleId);
		sql.append("ORDER BY A.id DESC");

		List<Map<String, Object>> rows = DBUtil.selectRows(dbConn, sql);
		List<ArticleReply> articleReplies = new ArrayList<>();

		for (Map<String, Object> row : rows) {
			articleReplies.add(new ArticleReply(row));
		}
		return articleReplies;
	}

	public int deleteArticleReply(int id) {
		SecSql sql = new SecSql();

		sql.append("DELETE FROM articleReply");
		sql.append("WHERE id = ? ", id);
		
		return DBUtil.update(dbConn, sql);
	}

	public ArticleReply getArticleReply(int id) {
		SecSql sql = new SecSql();

		sql.append("SELECT *");
		sql.append("FROM articleReply");
		sql.append("WHERE id = ?", id);

		Map<String, Object> row = DBUtil.selectRow(dbConn, sql);

		if ( row.isEmpty() ) {
			return null;
		}

		return new ArticleReply(row);
	}
}