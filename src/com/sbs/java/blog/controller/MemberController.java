package com.sbs.java.blog.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberController extends Controller {

	@Override
	public String doAction(String actionMethodName, HttpServletRequest req, HttpServletResponse resp) {
		System.out.printf("나는 member 컨트롤러. %s 요청을 받았다.\n", actionMethodName);
		return "";
	}

}
