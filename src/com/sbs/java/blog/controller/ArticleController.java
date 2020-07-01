package com.sbs.java.blog.controller;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.java.blog.dto.Article;
import com.sbs.java.blog.service.ArticleService;

public class ArticleController extends Controller {
	private ArticleService articleService;

	public ArticleController(Connection dbConn) {
		articleService = new ArticleService(dbConn);
	}

	public String doAction(String actionMethodName, HttpServletRequest req, HttpServletResponse resp) {
		switch (actionMethodName) {
		case "list":
			return doActionList(req, resp);
		}
		
		return "";
	}

	private String doActionList(HttpServletRequest req, HttpServletResponse resp) {
		int cateItemId = 0;
		// cateItemId이 null이 아닐때만
		if (req.getParameter("cateItemId") != null) {
			cateItemId = Integer.parseInt(req.getParameter("cateItemId"));
		}

		int page = 1;
		if (req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
		}
		
		List<Article> articles = articleService.getForPrintListArticles(page, cateItemId);
		//jsp한테 줄 데이터 이름과 데이터 (req는 jsp도 공유함)
		req.setAttribute("articles", articles);
		
		return "article/list";
	}
}
