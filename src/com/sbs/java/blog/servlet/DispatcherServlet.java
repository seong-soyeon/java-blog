package com.sbs.java.blog.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.java.blog.app.App;
// /s/article/list 가 만약 없다!!이런 갈 곳 없는 애들 여기서 가져옴  >> 리퀘스트
//리퀘스트req : (주소창에 적는 - 예:doWrite?title=aa) 요청에 관련된 모든정보 들어있음
//		ex)
//		RequestDispatcher rd = request.getRequestDispatcher("/jsp/home/dan.jsp") //home/dan.jsp한테 모든걸 위임(토스)
//		int dan = Integer.parseInt(request.getParameter("dan")); //url에 dan값을 int로 받겠다.(기본string으로 받음)
//		request.setAttribute("name", dan + "단"); ///jsp/home/dan.jsp에서 ${name}라고 치면 dan+"단"이 치환되어 들어감(setAttribute는 메모라고 보면됨.request를 넘겨받는 애들은 다 이 메모를 볼수 있음)
//		rd.forward(request, reponse);
import com.sbs.java.blog.service.MailService;

//리스폰스resp : 응답
//		ex-reponse.getWriter().append("")-writer를 리턴받을 수 있다.append("여기")내용 하나하나 고객한테 전달(출력)

//http://localhost:8081/blog/s/*가 실행됨
//web.xml에서 실행함
//@WebServlet("/s/*")
public class DispatcherServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// request 에서 입력받은 데이터 UTF 인코딩(들어오는데이터 한글처리)

		req.setCharacterEncoding("UTF-8");
		String gmailId = getServletConfig().getInitParameter("gmailId");
		String gmailPw = getServletConfig().getInitParameter("gmailPw");
		new App(req, resp, gmailId, gmailPw).start();

		/*
		 * 메일발송되는지 확인한 코드 // 보안을 위해 내 아이디랑 비번 이곳에 입력하지 않고 web.xml에서 받아옴 String gmailId =
		 * getServletConfig().getInitParameter("gmailId"); String gmailPw =
		 * getServletConfig().getInitParameter("gmailPw"); MailService mailService = new
		 * MailService(gmailId, gmailPw, gmailId, "관리자"); boolean sendMailDone =
		 * mailService.send("받는사람 메일@gmail.com", "안녕하세요.", "반갑습니다.!!") == 1;
		 * resp.getWriter().append(String.format("발송성공 : %b", sendMailDone));
		 */
		/*
		 * MailService mailService = new MailService(gmailId, gmailPw, gmailId, "관리자");
		 * 
		 * String emailTitle = "castle blog 회원가입을 축하드립니다!"; String emailBody = gmailId +
		 * "님 회원가입을 환영합니다!!!\n"; emailBody += "이메일 인증 후 활동을 시작해 주세요.\n"; emailBody +=
		 * "<html><body>< a href=\"https://castle.my.iu.gy/blog/s/member/doAuthMail?code=인증코드\">인증하기</a></body></html>"
		 * ; emailBody += "감사합니다.";
		 * 
		 * boolean sendMailDone = mailService.send("yesican951011@gmail.com",
		 * emailTitle, emailBody) == 1;
		 */

	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}