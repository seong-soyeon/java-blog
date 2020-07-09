package com.sbs.java.blog.controller;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TestController extends Controller {
	public TestController(Connection dbConn, String actionMethodName, HttpServletRequest req,
			HttpServletResponse resp) {
		super(dbConn, actionMethodName, req, resp);
	}

	@Override
	public String doAction() {
		switch (actionMethodName) {
		case "dbInsert":
			return doActionDbInsert();
		case "dbSelect":
			return doActionDbSelect();
		}

		return "";
	}

	private String doActionDbSelect() {
		return "html:doActionDbSelect";
	}

	private String doActionDbInsert() {
		return "html:doActionDbInsert";
	}
}
