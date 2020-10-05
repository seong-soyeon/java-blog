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
import com.sbs.java.blog.controller.TestController;
import com.sbs.java.blog.exception.SQLErrorException;
import com.sbs.java.blog.util.Util;

public class App {
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private String gmailPw;
	private String gmailId;
	private boolean isDevelServer = true;

	public App(HttpServletRequest req, HttpServletResponse resp, String gmailId, String gmailPw) {
		this.req = req;
		this.resp = resp;
		this.gmailId = gmailId;
		this.gmailPw = gmailPw;

		String profilesActive = System.getProperty("spring.profiles.active");

		if (profilesActive != null && profilesActive.equals("production")) {
			isDevelServer = false;
		}
	}

	private void loadDbDriver() throws IOException {
		// DB 커넥터 로딩 시작 //택시운전사
		// //WebContent/WEB-INF/lib/mysql-connector-java-8.0.20.jar안에 있음.
		String driverName = "com.mysql.cj.jdbc.Driver";

		try {
			// 드라이버(바로 윗줄)를 등록하는 행위 //드라이버매니저
			Class.forName(driverName);
		} catch (ClassNotFoundException e) {
			System.err.printf("[ClassNotFoundException 예외, %s]\n", e.getMessage());
			// 웹화면에 표출 syso는 콘솔창에 표출
			resp.getWriter().append("DB 드라이버 클래스 로딩 실패");
			return;
		}
		// DB 커넥터 로딩 성공
	}

	private String getDbUrl() {
		if (isDevelServer) {
			return "jdbc:mysql://localhost:3306/blog?serverTimezone=Asia/Seoul&useOldAliasMetadataBehavior=true";
		}

		return "jdbc:mysql://localhost:3306/blog?serverTimezone=Asia/Seoul&useOldAliasMetadataBehavior=true";
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
		} catch (SQLErrorException e) {
			Util.printEx(e.getMessage(), resp, e.getOrigin());
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
		}
		// 연결한건 다 꺼줘야 함. try에서 연결했다면 finally에서 꺼줘야 함
		// finally에서 DB연결 close하기전에 try에서 할일 다 하기
	}

	private void route(Connection dbConn, HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		resp.setContentType("text/html; charset=UTF-8");
		req.setCharacterEncoding("UTF-8");

		// http://localhost:8080/blog/s/article/listlist 중
		// contextPath : /blog
		// requestURI : /blog/s/article/listlist
		String contextPath = req.getContextPath();
		String requestURI = req.getRequestURI();
		// actionStr : article/listlist
		String actionStr = requestURI.replace(contextPath + "/s/", "");
		// 쪼개면 여러개니까 배열에 담아서 0번째배열은 controllerName에, 1번째배열은 actionMethodName에 담음
		String[] actionStrBits = actionStr.split("/");

		String controllerName = actionStrBits[0];
		String actionMethodName = actionStrBits[1];

		Controller controller = null;

		switch (controllerName) {
		case "article":
			controller = new ArticleController(dbConn, actionMethodName, req, resp);
			break;
		case "member":
			controller = new MemberController(dbConn, actionMethodName, req, resp, gmailId, gmailPw);
			break;
		case "home":
			controller = new HomeController(dbConn, actionMethodName, req, resp);
			break;
		case "test":
			controller = new TestController(dbConn, actionMethodName, req, resp);
			break;
		}

		if (controller != null) {
			String actionResult = controller.executeAction();
			if (actionResult.equals("")) {
				resp.getWriter().append("액션의 결과가 없습니다.");
			} else if (actionResult.endsWith(".jsp")) {
				String viewPath = "/jsp/" + actionResult;
				// jsp한테 req랑 resp를 넘김
				req.getRequestDispatcher(viewPath).forward(req, resp);
			} else if (actionResult.startsWith("html:")) {
				resp.getWriter().append(actionResult.substring(5));
			} else {
				resp.getWriter().append("처리할 수 없는 액션결과입니다.");
			}
		} else {
			resp.getWriter().append("존재하지 않는 페이지 입니다.");
		}
	}

	private String getDbId() {
		if (isDevelServer) {
			return "sbsst";
		}

		return "myflexLocal";
	}

	private String getDbPassword() {
		if (isDevelServer) {
			return "sbs123414";
		}

		return "myflexLocal";
	}

}
