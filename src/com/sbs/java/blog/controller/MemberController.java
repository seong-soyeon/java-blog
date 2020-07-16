  
package com.sbs.java.blog.controller;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
			return doActionJoin();
		case "doJoin":
			return doActionDoJoin();
		case "login":
			return doActionLogin();
		case "doLogin":
			return doActionDoLogin();
		case "doLogout":
			return doActionDoLogout();
	}
		return "";
	}

	private String doActionDoLogout() {
		session.removeAttribute("loginedMemberId");

		return String.format("html:<script> alert('로그아웃 되었습니다.'); location.replace('../home/main'); </script>");
	}
	
	private String doActionDoLogin() {
		String loginId = req.getParameter("loginId");
		String loginPw = req.getParameter("loginPw");
		
		int loginedMemberId = memberService.getMemberIdByLoginIdAndLoginPw(loginId, loginPw);

		if (loginedMemberId == -1) {
			return String.format("html:<script> alert('일치하는 정보가 없습니다.'); history.back(); </script>");
		}

		//리퀘스트객체(구글이 만듬)는 F5키 누를때 잠깐 생겨남(ex-헬스장 내 락커키)
		//F12>Application>Cookies에 value값이생겨남>그 value 값이 req에 저장>getSession()을 하면 value값과 관련된 개인 저장소 하나 줌.
		//브라우저 끌때 까지 저장
		//***로그인 할때 loginedMemberId만 세션에 굽는다.>>controller의 beforeAction()에서 사용자관련정보 굽는다.>>모든 jsp에서 쓸 수 있도록 head.jsp에서 풀어놈.>>추가로 자바스크립트에서도 쓸 수 있도록 풀어놈.
		//HttpSession session = req.getSession();
		session.setAttribute("loginedMemberId", loginedMemberId);
		
		return String.format("html:<script> alert('" + loginId + "님 로그인 되었습니다.'); location.replace('.././home/main'); </script>");
	}

	private String doActionLogin() {
		return "member/login.jsp";
	}

	private String doActionDoJoin() {
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

	private String doActionJoin() {
		return "member/join.jsp";
	}
	/*private String doActionDoLogout() {
		session.removeAttribute("loginedMemberId");

		return String.format("html:<script> alert('로그아웃 되었습니다.'); location.replace('../home/main'); </script>");
	}*/
}