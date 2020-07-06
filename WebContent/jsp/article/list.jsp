<%@ page import="java.util.List"%>
<%@ page import="com.sbs.java.blog.dto.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>
<%
	List<Article> articles = (List<Article>) request.getAttribute("articles");
	int totalPage = (int) request.getAttribute("totalPage");
	int paramPage = (int) request.getAttribute("page");
	String cateItemName = (String)request.getAttribute("cateItemName");
%>
<style>
.article-list-box-1 td {
	text-align: center;
}
.page-box {
	margin-top: 10px;
	padding-bottom: 50px;
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

<!-- 카테고리 -->
.cateItem > ul {
    text-align: right;
}
.cateItem>ul>li> {
	flex-direction: row;
}
.cateItem>ul>li>a {
	padding: 20 10px;
	color: #787878;
	letter-spacing: 4px;
}
.cateItem>ul>li:hover>a {
	color: black;
}
.search {
	padding-bottom: 10px;
}
.border-navy {
    border: 5px solid navy;
}
.navy {
	color: navy;
}
.h2 {
	color: #16161d;
}
</style>



<div class="title-box">
	<h1 class="con title"><a href="${pageContext.request.contextPath}/s/article/list">Article List😀</a></h1>
</div>

<div class="con">
	<div class="cateItem text-align-center">
		<ul>
			<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=1&page=1"># IT/자바</a></li>
			<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=2&page=1"># IT/HTML_CSS_JS</a></li>
			<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=3&page=1"># IT/상식</a></li>
			<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=4&page=1"># IT/그외상식</a></li>
			<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=5&page=1"># 공부계획</a></li>
			<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=6&page=1"># 일상</a></li>
		</ul>
	</div>
	
		
</div>


<div class="article-list-box-1 con table-box">

	<h2 class="con cateItem-current">
		# <%=cateItemName%>
	</h2>
	
	<div class="search flex flex-jc-sb">
		<div>총 게시물 수 : ${totalCount}</div>
		<div class="search-box flex flex-jc-e">

			<form action="${pageContext.request.contextPath}/s/article/list">
				<input type="hidden" name="page" value="1" /> <input type="hidden"
					name="cateItemId" value="${param.cateItemId}" /> <input
					type="hidden" name="searchKeywordType" value="title" /> <input
					type="text" name="searchKeyword" value="${param.searchKeyword}" />
				<button type="submit">검색</button>
			</form>
		</div>
		
	</div>
	
	<table class="border-navy">
		<colgroup>
			<col width="100">
			<col width="100">
			<col width="220">
			<col width="220">
		</colgroup>
		<thead class="navy border-navy">
			<tr>
				<th>게시물번호</th>
				<th>카테고리</th>
				<th>작성날짜</th>
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
		<li class="<%=i == paramPage ? "current" : ""%>"><a
			href="?cateItemId=${param.cateItemId}&searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}&page=<%=i%>" class="block"><%=i%></a></li>
		<%
			}
		%>
	</ul>
</div>

<%@ include file="/jsp/part/foot.jspf"%>
