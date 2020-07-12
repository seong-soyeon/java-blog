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


//리스폰스resp : 응답
//		ex-reponse.getWriter().append("")-writer를 리턴받을 수 있다.append("여기")내용 하나하나 고객한테 전달(출력)




//http://localhost:8081/blog/s/*가 실행됨
@WebServlet("/s/*")
public class DispatcherServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//request 에서 입력받은 데이터 UTF 인코딩(들어오는데이터 한글처리)
		req.setCharacterEncoding("UTF-8");
		new App(req, resp).start();
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
 