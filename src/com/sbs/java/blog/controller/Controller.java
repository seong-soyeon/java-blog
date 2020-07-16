package com.sbs.java.blog.controller;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sbs.java.blog.dto.CateItem;
import com.sbs.java.blog.dto.Member;
import com.sbs.java.blog.service.ArticleService;
import com.sbs.java.blog.service.MemberService;

public abstract class Controller {
	// private로하면 상속 안됨
	// protected 는 외부에 노출은 안되는데 상속은 가능
	protected Connection dbConn;
	protected String actionMethodName;
	protected HttpServletRequest req;
	protected HttpServletResponse resp;
	protected HttpSession session;

	protected ArticleService articleService;
	protected MemberService memberService;

	public Controller(Connection dbConn, String actionMethodName, HttpServletRequest req, HttpServletResponse resp) {
		this.dbConn = dbConn;
		this.actionMethodName = actionMethodName;
		this.req = req;
		this.session = req.getSession();
		this.resp = resp;
		articleService = new ArticleService(dbConn);
		memberService = new MemberService(dbConn);
	}

	// 액션 전 실행
	// 이 메서드는 모든 컨트롤러의 모든 액션이 실행되기 전에 실행된다.
	// 모든곳에서 사용해야 할 것을 여기 넣어두면 좋음. (ex,모든곳에서 cateItems를 호출 가능)		
	public void beforeAction() {
		// 만인에 관련된 정보를 리퀘스트 객체에 정리해서 넣기
		List<CateItem> cateItems = articleService.getForPrintCateItems();

		req.setAttribute("cateItems", cateItems);
		
		// 사용자 관련 정보를 리퀘스트 객체에 정리해서 넣기
		//-1설정 안해놓고 그냥 받아오면 loginedMemberId이 null 일 경우 int형변환 안되서 오류남
		int loginedMemberId = -1;
		boolean isLogined = false;
		Member loginedMember = null;
			
		if ( session.getAttribute("loginedMemberId") != null ) {
			loginedMemberId = (int)session.getAttribute("loginedMemberId");
			isLogined = true;
			loginedMember = memberService.getMemberById(loginedMemberId);
		}
		req.setAttribute("loginedMemberId", loginedMemberId);
		req.setAttribute("loginedMember", loginedMember);
		req.setAttribute("isLogined", isLogined);			
	}

	public void afterAction() {
		// 액션 후 실행
	}

	public abstract String doAction();

	public String executeAction() {
		beforeAction();
		String rs = doAction();
		afterAction();

		return rs;
	}
}