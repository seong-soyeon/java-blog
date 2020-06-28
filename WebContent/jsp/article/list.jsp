<%@ page import="java.util.List"%>
<%@ page import="com.sbs.java.blog.dto.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>
<%
	List<Article> articles = (List<Article>) request.getAttribute("articles");
%>
<style>
.article-list-box-1 td {
	text-align: center;
}
</style>
<h1 class="con">게시물 리스트</h1>

<div class="article-list-box-1 con table-box">
	<table>
		<colgroup>
			<col width="50">
			<col width="150">
			<col width="150">
		</colgroup>
		<thead>
			<tr>
				<th>게시물번호</th>
				<th>등록날짜</th>
				<th>수정날짜</th>
				<th>제목</th>
			</tr>
		</thead>
		<tbody>
			<%
				for (Article article : articles) {
			%>
			<tr>
				<td><%=article.getId()%></td>
				<td><%=article.getRegDate()%></td>
				<td><%=article.getUpdateDate()%></td>
				<td class="text-align-left"><a href="./detail?id=<%=article.getId()%>"><%=article.getTitle()%></a></td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
</div>
<%@ include file="/jsp/part/foot.jspf"%>