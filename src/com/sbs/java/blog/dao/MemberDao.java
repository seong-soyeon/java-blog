package com.sbs.java.blog.dao;

import java.sql.Connection;

import com.sbs.java.blog.util.DBUtil;
import com.sbs.java.blog.util.SecSql;

public class MemberDao extends Dao {
	private Connection dbConn;

	
	public MemberDao(Connection dbConn) {
		this.dbConn = dbConn;
	}


	public int doJoin(String loginId, String name, String nickname, String loginPw) {
		SecSql secSql = new SecSql();
		
		secSql.append("INSERT INTO member ");
		secSql.append("SET regDate = NOW() ");
		secSql.append(", loginId = '%s' ", loginId);//SET loginId = '${loginId}', loginPw = '${loginPw}'
		secSql.append(", name = '%s' ", name);
		secSql.append(", nickname = '%s' ", nickname);
		secSql.append(", loginPw = '%s' ", loginPw);
		
		return DBUtil.insert(dbConn, secSql);
		/*
		String sql = "";
		
		sql += String.format("INSERT INTO member ");
		sql += String.format("SET regDate = NOW() ");
		sql += String.format(", loginId = '%s' ", loginId);//SET loginId = '${loginId}', loginPw = '${loginPw}'
		sql += String.format(", name = '%s' ", name);
		sql += String.format(", nickname = '%s' ", nickname);
		sql += String.format(", loginPw = '%s' ", loginPw);
		
		return DBUtil.insert(dbConn, sql);
		*/
	}

	

}
