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
		case "detail":
			return doActionDetail(req, resp);
		case "doWrite":
			return doActionDoWrite(req, resp);
		}
		return "";
	}

	private String doActionDoWrite(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub
		return "article/write";
	}

	private String doActionDetail(HttpServletRequest req, HttpServletResponse resp) {
		int id = 0;
		if ( req.getParameter("id") != null ) {
			id = Integer.parseInt(req.getParameter("id"));
		}
		
		Article article = articleService.getForPrintDetailArticle(id);
		req.setAttribute("article", article);
		
		return "article/detail";
	}

	private String doActionList(HttpServletRequest req, HttpServletResponse resp) {
		int cateItemId = 0;
		if (req.getParameter("cateItemId") != null) {
			cateItemId = Integer.parseInt(req.getParameter("cateItemId"));
		}

		int page = 1;
		if (req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
		}

		List<Article> articles = articleService.getForPrintListArticles(page, cateItemId);
		req.setAttribute("articles", articles);
		return "article/list";
	}
}
