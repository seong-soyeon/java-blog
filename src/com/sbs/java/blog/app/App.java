package com.sbs.java.blog.app;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.java.blog.controller.ArticleController;
import com.sbs.java.blog.controller.Controller;
import com.sbs.java.blog.controller.HomeController;
import com.sbs.java.blog.controller.MemberController;
import com.sbs.java.blog.util.Util;

public class App {
	private HttpServletRequest req;
	private HttpServletResponse resp;

	public App(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}
	
	private void loadDbDriver() throws IOException {
		// DB 커넥터 로딩 시작
		String driverName = "com.mysql.cj.jdbc.Driver";

		try {
			Class.forName(driverName);
		} catch (ClassNotFoundException e) {
			System.err.printf("[ClassNotFoundException 예외, %s]\n", e.getMessage());
			resp.getWriter().append("DB 드라이버 클래스 로딩 실패");
			return;
		}
		// DB 커넥터 로딩 성공
	}
	
	private String getDbUrl() {
		return "jdbc:mysql://site25.iu.gy:3306/site25?serverTimezone=Asia/Seoul&useOldAliasMetadataBehavior=true";
	}
				
	public void start() throws ServletException, IOException {
		// DB 드라이버 로딩
		loadDbDriver();

		// DB 접속정보 세팅
		String url = getDbUrl();
		String user = getDbId();
		String password = getDbPassword();

		Connection dbConn = null;
		
		try {
			// DB 접속 성공
			dbConn = DriverManager.getConnection(url, user, password);

			// 올바른 컨트롤러로 라우팅-인도한다
			route(dbConn, req, resp);
		} catch (SQLException e) {
			Util.printEx("SQL 예외(커넥션 열기)", resp, e);
		} catch (Exception e) {
			Util.printEx("기타 예외", resp, e);
		} finally {
			if (dbConn != null) {
				try {
					dbConn.close();
				} catch (SQLException e) {
					Util.printEx("SQL 예외(커넥션 닫기)", resp, e);
				}
			}
		}//finally에서 DB연결 close하기전에 try에서 할일 다 하기
		
	}
	
	private void route(Connection dbConn, HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		resp.setContentType("text/html; charset=UTF-8");

		//http://localhost:8080/blog/s/article/listlist 중
		//contextPath : /blog
		//requestURI : /blog/s/article/listlist
		String contextPath = req.getContextPath();
		String requestURI = req.getRequestURI();
		//actionStr : article/listlist
		String actionStr = requestURI.replace(contextPath + "/s/", "");
		//쪼개면 여러개니까 배열에 담아서 0번째배열은 controllerName에, 1번째배열은 actionMethodName에 담음
		String[] actionStrBits = actionStr.split("/");
		
		String controllerName = actionStrBits[0];
		String actionMethodName = actionStrBits[1];
		
		Controller controller = null;		
		
		switch (controllerName) {
		case "article":
			controller = new ArticleController(dbConn, actionMethodName, req, resp);
			break;
		case "member":
			controller = new MemberController(dbConn, actionMethodName, req, resp);
			break;
		case "home":
			controller = new HomeController(dbConn, actionMethodName, req, resp);
			break;
		}

		if (controller != null) {
			String actionResult = controller.executeAction();
			if (actionResult.equals("")) {
				resp.getWriter().append("액션의 결과가 없습니다.");
			} else if (actionResult.endsWith(".jsp")) {
				String viewPath = "/jsp/" + actionResult;
				req.getRequestDispatcher(viewPath).forward(req, resp);
			} else if (actionResult.startsWith("html:")) {
				resp.getWriter().append(actionResult.substring(6));
			} else {
				resp.getWriter().append("처리할 수 없는 액션결과입니다.");
			}
		} else {
			resp.getWriter().append("존재하지 않는 페이지 입니다.");
		}
	}

	private String getDbId() {
		return "site25";
	}

	private String getDbPassword() {
		return "sbs123414";
	}

}