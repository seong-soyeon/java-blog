package com.sbs.java.blog.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class HomeController extends Controller {

	public String doAction(String actionMethodName, HttpServletRequest req, HttpServletResponse resp) {
		switch (actionMethodName) {
		case "main":
			return "home/main.jsp";
		case "aboutMe":
			return "home/aboutMe.jsp";
		}
		return "";
	}
}