<%@ page import="java.util.List"%>
<%@ page import="com.sbs.java.blog.dto.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>
<%
	List<Article> articles = (List<Article>) request.getAttribute("articles");
	int totalPage = (int) request.getAttribute("totalPage");
	int paramPage = (int) request.getAttribute("page");
%>
<style>
.article-list-box-1 td {
	text-align: center;
}
.page-box>ul>li>a {
	padding: 0 10px;
	text-decoration: underline;
	color: #787878;
}
.page-box>ul>li:hover>a {
	color: black;
}
.page-box>ul>li.current>a {
	color: red;
}
.flex-jc-c {
    justify-content: center;
}//나중에 지우기
</style>



<div class="title-box">
	<h1 class="con title">게시물 리스트😀</h1>
</div>

<div class="article-list-box-1 con table-box">
	<div class="con">
		총 게시물 수 : ${totalCount}
	</div>
	<table>
		<colgroup>
			<col width="100">
			<col width="100">
			<col width="220">
			<col width="220">
		</colgroup>
		<thead>
			<tr>
				<th>게시물번호</th>
				<th>카테고리</th>
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
				<td><%=article.getCateItemId()%></td>
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

<div class="con page-box">
	<ul class="flex flex-jc-c">
		<%
			for (int i = 1; i <= totalPage; i++) {
		%>
		<!-- 삼항연산자 i == paramPage 가 참이면 "current"  거짓이면 ""  -->
		<li class="<%=i == paramPage ? "current" : ""%>"><a href="?cateItemId=${param.cateItemId}&page=<%=i%>" class="block"><%=i%></a></li>
		<%
			}
		%>
	</ul>
</div>

<%@ include file="/jsp/part/foot.jspf"%>
