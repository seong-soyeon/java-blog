package com.sbs.java.blog.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.java.blog.dto.Article;
import com.sbs.java.blog.util.DBUtil;

@WebServlet("/s/article/list")
public class ArticleListServlet extends HttpServlet {
	private List<Article> getArticles() {
		String url = "jdbc:mysql://site25.iu.gy:3306/site25?serverTimezone=Asia/Seoul&useOldAliasMetadataBehavior=true";
		String user = "site25";
		String password = "sbs123414";
		String driverName = "com.mysql.cj.jdbc.Driver";

		String sql = "";

		sql += String.format("SELECT * ");
		sql += String.format("FROM article ");
		sql += String.format("ORDER BY id DESC ");

		List<Article> articles = new ArrayList<>();

		Connection conn = null; 

		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);

			List<Map<String, Object>> rows = DBUtil.selectRows(conn, sql);

			for (Map<String, Object> row : rows) {
				articles.add(new Article(row));
			}

		} catch (ClassNotFoundException e) {
			System.err.println("[ClassNotFoundException 예외]");
			System.err.println("msg : " + e.getMessage());
		} catch (SQLException e) {
			System.err.println("[SQLException 예외]");
			System.err.println("msg : " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.err.println("[SQLException 예외]");
					System.err.println("msg : " + e.getMessage());
				}
			}
		}

		return articles;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");

		List<Article> articles = getArticles();

		req.setAttribute("articles", articles);
		req.getRequestDispatcher("/jsp/article/list.jsp").forward(req, resp);
	}
}
