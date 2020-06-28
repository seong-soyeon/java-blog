package com.sbs.java.blog.servlet;
/*
 * http://localhost:8081/java-blog/home/main
 * http://localhost:8081/java-blog/jsp/home/main.jsp
 */

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/home/main") /*브라우저에서 실행하기위한 주소 */
public class HomeMainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		response.setContentType("text/html; charset=utf-8");

		request.getRequestDispatcher("/jsp/home/main.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}

}
