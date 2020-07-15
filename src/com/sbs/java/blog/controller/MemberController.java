  
package com.sbs.java.blog.controller;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberController extends Controller {
	public MemberController(Connection dbConn, String actionMethodName, HttpServletRequest req,
			HttpServletResponse resp) {
		super(dbConn, actionMethodName, req, resp);
	}
	// 게시물 컨트롤러의 모든 액션이 실행되기 전에 실행됨
	public void beforeAction() {
		super.beforeAction();
	}

	@Override
	public String doAction() {
		switch (actionMethodName) {
		case "join":
			return doActionJoin(req, resp);
		case "doJoin":
			return doActionDoJoin(req, resp);
		case "login":
			return doActionLogin(req, resp);
		case "doLogin":
			return doActionDoLogin(req, resp);
		case "logout":
			return doActionLogin(req, resp);
	}
		return "";
	}

	private String doActionDoLogin(HttpServletRequest req, HttpServletResponse resp) {
		String loginId = req.getParameter("loginId");
		String loginPw = req.getParameter("loginPw");
		
		return "html:<script> alert('" + loginId + "님 로그인에 성공하였습니다.'); location.replace('.././home/main'); </script>";
	}

	private String doActionLogin(HttpServletRequest req, HttpServletResponse resp) {
		return "member/login.jsp";
	}

	private String doActionDoJoin(HttpServletRequest req, HttpServletResponse resp) {
		String loginId = req.getParameter("loginId");
		String loginPw = req.getParameter("loginPwReal");
		String name = req.getParameter("name");
		String nickname = req.getParameter("nickname");
		String email = req.getParameter("email");
		
		//아이디 중복체크
		boolean isJoinableLoginId = memberService.isJoinableLoginId(loginId);

		if ( isJoinableLoginId == false ) {
			return String.format("html:<script> alert('%s(은)는 이미 사용중인 아이디 입니다.'); history.back(); </script>", loginId);
		}
		
		//닉네임 중복체크
		boolean isJoinableNickname = memberService.isJoinableNickname(nickname);
		
		if ( isJoinableNickname == false ) {
			return String.format("html:<script> alert('%s(은)는 이미 사용중인 닉네임 입니다.'); history.back(); </script>", nickname);
		}
		
		//이메일 중복체크
		boolean isJoinableEmail = memberService.isJoinableEmail(email);
		
		if ( isJoinableEmail == false ) {
			return String.format("html:<script> alert('%s(은)는 이미 사용중인 이메일 입니다.'); history.back(); </script>", email);
		}

		memberService.join(loginId, loginPw, name, nickname, email);

		return String.format("html:<script> alert('짝짝짝 %s님 환영합니다.'); location.replace('login'); </script>", name);	
	}

	private String doActionJoin(HttpServletRequest req, HttpServletResponse resp) {
		return "member/join.jsp";
	}
}