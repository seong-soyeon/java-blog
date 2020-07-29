  
package com.sbs.java.blog.controller;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.java.blog.service.MailService;
import com.sbs.java.blog.util.Util;

public class MemberController extends Controller {
	private String gmailPw;
	private String gmailId;
	
	public MemberController(Connection dbConn, String actionMethodName, HttpServletRequest req,
			HttpServletResponse resp, String gmailId, String gmailPw) {
		super(dbConn, actionMethodName, req, resp);
		this.gmailId = gmailId;
		this.gmailPw = gmailPw;
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
		case "findIdPw":
			return doActionFindIdPw();
		case "doFindId":
			return doActionDoFindId();
		case "doFindPw":
			return doActionDoFindPw();
	}
		return "";
	}

	private String doActionDoFindPw() {
		// TODO Auto-generated method stub
		String loginId = req.getParameter("loginId");
		String email = req.getParameter("email");
		
		//아이디 중복체크
		boolean isJoinableLoginId = memberService.isJoinableLoginId(loginId);
		if ( isJoinableLoginId == true ) {
			return String.format("html:<script> alert('%s(와)과 일치하는 회원정보가 없습니다.'); history.back(); </script>", loginId);
		}
		
		//이메일로 회원 유무체크		
		boolean isJoinableEmail = memberService.isJoinableEmail(email);
		if ( isJoinableEmail == true ) {
			return String.format("html:<script> alert('%s(와)과 일치하는 회원정보가 없습니다.'); history.back(); </script>", email);
		}
		
		return null;
	}
	private String doActionDoFindId() {
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		/*
		//이름으로 회원 유무체크		
		boolean isJoinableName = memberService.isJoinableName(name);
		if ( isJoinableName == true ) {
			return String.format("html:<script> alert('%s(와)과 일치하는 회원정보가 없습니다.'); history.back(); </script>", name);
		}
		
		//이메일로 회원 유무체크		
		boolean isJoinableEmail = memberService.isJoinableEmail(email);
		if ( isJoinableEmail == true ) {
			return String.format("html:<script> alert('%s(와)과 일치하는 회원정보가 없습니다.'); history.back(); </script>", email);
		}
*/
		// TODO 이름이랑 이메일로 아이디 가져와야해!!!!!!!!!!!!!!!!!!!여기 수정하기!!!!!
		//아이디 찾기 메일 보내기
		MailService mailService = new MailService(gmailId, gmailPw, gmailId, "관리자");

		String loginId = memberService.getLoginIdByNameAndEmail(name, email);

		if( loginId == null) {
			return String.format("html:<script> alert('입력하신 정보와 일치하는 회원정보가 없습니다. 다시 입력해 주세요'); history.back(); </script>");
		}
		
		boolean sendMailDone = mailService.send(email, "아이디 발송메일 입니다.", name + "님의 아이디는 " + loginId + " 입니다.") == 1;
		System.out.println("발송후" + loginId);
			
		return String.format("html:<script> alert('회원님의 메일(%s)로 아이디가 발송되었습니다.'); location.replace('login'); </script>", email);	
	}
	private String doActionFindIdPw() {
		return "member/findIdPw.jsp";
	}
	
	private String doActionDoLogout() {
		session.removeAttribute("loginedMemberId");

		return String.format("html:<script> alert('로그아웃 되었습니다.'); location.replace('../home/main'); </script>");
	}
	
	private String doActionDoLogin() {
		String loginId = req.getParameter("loginId");
		String loginPw = req.getParameter("loginPwReal");
		
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
		
		//redirectUrl이 있다면 그 주소로, 없다면 main으로 저장하는 함수
		String redirectUrl = Util.getString(req, "redirectUrl", "../home/main");
		
		return String.format("html:<script> alert('" + loginId + "님 로그인 되었습니다.'); location.replace('" + redirectUrl + "'); </script>");
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
		
		MailService mailService = new MailService(gmailId, gmailPw, gmailId, "관리자");
		
		System.out.println("발송전");
		
		String emailTitle = "castle blog 회원가입을 축하드립니다!";
		String emailBody = gmailId + "님 회원가입을 환영합니다!!!\n";
		emailBody += "이메일 인증 후 활동을 시작해 주세요.\n";
		emailBody += "<html><body>< a href=\"https://castle.my.iu.gy/blog/s/member/doAuthMail?code=인증코드\">인증하기</a></body></html>";
		emailBody += "감사합니다.";
		
		boolean sendMailDone = mailService.send("yesican951011@gmail.com", emailTitle, emailBody) == 1;
		
		System.out.println("발송후");
		
		return String.format("html:<script> alert('짝짝짝 %s님 환영합니다.'); location.replace('login'); </script>", name);	
	}

	private String doActionJoin() {
		return "member/join.jsp";
	}
	/*private String doActionDoLogout() {
		session.removeAttribute("loginedMemberId");

		return String.format("html:<script> alert('로그아웃 되었습니다.'); location.replace('../home/main'); </script>");
	}*/
	
	@Override
	public String getControllerName() {
		return "member";
	}
}