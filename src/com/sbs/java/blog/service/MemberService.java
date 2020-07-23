package com.sbs.java.blog.service;

import java.sql.Connection;

import com.sbs.java.blog.dao.MemberDao;
import com.sbs.java.blog.dto.Member;

public class MemberService extends Service {
	
	private MemberDao memberDao;
	
	public MemberService(Connection dbConn) {
		memberDao = new MemberDao(dbConn);
	}

	public boolean isJoinableLoginId(String loginId) {
		return memberDao.isJoinableLoginId(loginId);
	}

	public int join(String loginId, String loginPw, String name, String nickname, String email) {
		return memberDao.join(loginId, loginPw, name, nickname, email);
	}

	public boolean isJoinableNickname(String nickname) {
		return memberDao.isJoinableNickname(nickname);
	}

	public boolean isJoinableName(String name) {
		return memberDao.isJoinableName(name);
	}
	
	public boolean isJoinableEmail(String email) {
		return memberDao.isJoinableEmail(email);
	}

	public int getMemberIdByLoginIdAndLoginPw(String loginId, String loginPw) {
		return memberDao.getMemberIdByLoginIdAndLoginPw(loginId, loginPw);
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	public String getLoginIdByNameAndEmail(String name, String email) {
		return memberDao.getLoginIdByNameAndEmail(name, email);
	}
}
