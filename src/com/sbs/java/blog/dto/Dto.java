package com.sbs.java.blog.dto;

import java.util.Map;

public class Dto {
	private int id;
	private String regDate;
	/*
	private int totalPage;
	private int totalCount;
	
	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	*/
	public Dto() {
		
	}
	
	public Dto(Map<String, Object> row) {
		this.id = (int)row.get("id");
		this.regDate = (String)row.get("regDate");
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
}
