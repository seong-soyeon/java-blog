package com.sbs.java.blog.dto;

import java.util.Map;

import lombok.Data;

@Data
public class Member extends Dto {
	private String updateDate;
	private String loginId;
	private String loginPw;
	private String name;
	private String nickname;
	private String email;
	private String mailAuthCode;
	private int mailAuthStatus;

	public Member(Map<String, Object> row) {
		super(row);

		this.updateDate = (String) row.get("updateDate");
		this.loginId = (String) row.get("loginId");
		this.loginPw = (String) row.get("loginPw");
		this.name = (String) row.get("name");
		this.nickname = (String) row.get("nickname");
		this.email = (String) row.get("email");
		this.mailAuthCode = (String) row.get("mailAuthCode");
		this.mailAuthStatus = (int) row.get("mailAuthStatus");
	}

	@Override
	public String toString() {
		return "Member [updateDate=" + updateDate + ", loginId=" + loginId + ", loginPw=" + loginPw + ", name=" + name
				+ ", nickname=" + nickname + ", email=" + email + ", mailAuthCode=" + mailAuthCode + ", mailAuthStatus="
				+ mailAuthStatus + ", getId()=" + getId() + ", getRegDate()=" + getRegDate() + ", getExtra()="
				+ getExtra() + ", dto=" + super.toString() + "]";

	}
}