package com.sbs.java.blog.controller;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.java.blog.dto.Article;
import com.sbs.java.blog.service.ArticleService;
import com.sbs.java.blog.util.Util;

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
		// displayStatus는 Dao에서 1로 임의로 지정
		int cateItemId = Integer.parseInt(req.getParameter("cateItemId"));
		String title = req.getParameter("title");
		String body = req.getParameter("body");
		
		articleService.doWriteArticle(cateItemId, title, body);
		
		return "article/doWrite";
	}

	private String doActionDetail(HttpServletRequest req, HttpServletResponse resp) {
		if (Util.empty(req, "id")) {
			return "plain:id를 입력해주세요.";
		}

		if (Util.isNum(req, "id") == false) {
			return "plain:id를 정수로 입력해주세요.";
		}

		int id = Util.getInt(req, "id");
		
		Article article = articleService.getForPrintArticle(id);
		req.setAttribute("article", article);
		
		return "article/detail.jsp";
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
		
		int itemsInAPage = 10;
		int totalCount = articleService.getForPrintListArticlesCount(cateItemId);
		int totalPage = (int) Math.ceil((double)totalCount/itemsInAPage);
		
		req.setAttribute("totalCount", totalCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("page", page);

		List<Article> articles = articleService.getForPrintListArticles(page, itemsInAPage, cateItemId);
		req.setAttribute("articles", articles);
		return "article/list.jsp";
	}
}
/*
 		int itemsInAPage = 5;		//한 페이지에 나오는 게시물 수
		int limitFrom = (page - 1) * itemsInAPage;
		
		
		int totalCount = 0;
		// Math.ceil() 소수점 이하를 올림한다.
		int totalPage = (int) Math.ceil((double)totalCount/itemsInAPage);
 */