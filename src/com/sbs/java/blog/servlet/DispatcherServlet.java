package com.sbs.java.blog.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.java.blog.app.App;
// /s/article/list 가 만약 없다!!이런 갈 곳 없는 애들 여기서 가져옴  >> 리퀘스트
//리퀘스트 : (주소창에 적는 - 예:doWrite?title=aa) 요청에 관련된 모든정보 들어있음
@WebServlet("/s/*")
public class DispatcherServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		new App(req, resp).start();
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
