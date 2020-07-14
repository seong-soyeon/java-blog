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
		
		secSql.append("INSERT INTO `member`");
		secSql.append("SET regDate = NOW()");
		secSql.append(", loginId = ?", loginId);//SET loginId = '${loginId}', loginPw = '${loginPw}'
		secSql.append(", name = ?", name);
		secSql.append(", nickname = ?", nickname);
		secSql.append(", loginPw = ?", loginPw);
		
		return DBUtil.insert(dbConn, secSql);
	}


	public boolean isJoinableLoginId(String loginId) {
		SecSql sql = SecSql.from("SELECT COUNT(*) AS cnt");
		sql.append("FROM `member`");
		sql.append("WHERE loginId = ?", loginId);
		//0 이여야 join 가능
		return DBUtil.selectRowIntValue(dbConn, sql) == 0;
	}


	public int join(String loginId, String loginPw, String name, String nickname, String email) {
		SecSql sql = SecSql.from("INSERT INTO member");
		sql.append("SET regDate = NOW()");
		sql.append(", updateDate = NOW()");
		sql.append(", loginId = ?", loginId);
		sql.append(", loginPw = ?", loginPw);
		sql.append(", name = ?", name);
		sql.append(", nickname = ?", nickname);
		sql.append(", email = ?", email);
		return DBUtil.insert(dbConn, sql);
	}

	

}
