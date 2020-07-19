package com.sbs.java.blog.dto;

import java.util.Map;

public class ArticleReply extends Dto {
	private String updateDate;
	private int articleId;
	private String body;
	private int memberId;
	
	public ArticleReply() {

	}
	
	public ArticleReply(Map<String, Object> row) {
		super(row);
		this.updateDate = (String)row.get("updateDate");
		this.articleId = (int)row.get("articleId");
		this.body = (String)row.get("body");
		this.memberId = (int)row.get("memberId");
		
	}

	@Override
	public String toString() {
		return "articleReply [updateDate=" + updateDate + ", articleId=" + articleId + ", body=" + body + ", memberId="
				+ memberId + ", dto=" + super.toString() + "]";
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public int getArticleId() {
		return articleId;
	}

	public void setArticleId(int articleId) {
		this.articleId = articleId;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	
	
	
	
}
