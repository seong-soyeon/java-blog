package com.sbs.java.blog.service;

import java.sql.Connection;

import com.sbs.java.blog.dao.MemberDao;

public class MemberService extends Service {
	
	private MemberDao memberDao;
	
	public MemberService(Connection dbConn) {
		memberDao = new MemberDao(dbConn);
	}
	
	public int doJoin(String loginId, String name, String nickname, String loginPw) {
		return memberDao.doJoin(loginId, name, nickname, loginPw);
	}

}
