<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="⭐Article List"></c:set>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>

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
.doWrite-button {
	padding-top: 10px;
}
.article-list-box-1 tr> .godetail {
	opacity: 0.8;
}
.article-list-box-1 tr> .godetail:hover {
	opacity: 1;
	text-decoration: underline;
}
</style>


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
		# ${cateItemName}
	</h2>
	
	<div class="search flex flex-jc-sb">
		<div>총 게시물 수 : ${totalCount}</div>
		<div class="search-box flex flex-jc-e">
			<form action="${pageContext.request.contextPath}/s/article/list">
				<input type="hidden" name="page" value="1" /> 
				<input type="hidden" name="cateItemId" value="${param.cateItemId}" /> 
				<input type="hidden" name="searchKeywordType" value="title" /> 
				<input type="text" name="searchKeyword" value="${param.searchKeyword}" />
				<button type="submit">검색</button>
			</form>
		</div>
		
	</div>
	
	<table class="border-navy">
		<colgroup>
			<col width="100">
			<col width="100">
			<col width="200">
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
			<c:forEach items="${articles}" var="article">
			<tr>
				<td>${article.id}</td>
				<td>${article.cateItemId}</td>
				<td>${article.regDate}</td>
				<td class="godetail"><a href="./detail?id=${article.id}&cateItemId=${article.cateItemId}">${article.title}</a></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="doWrite-button text-align-right ">
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/s/article/write' ">글쓰기</button>
	</div>
</div>

<div class="con page-box">
	<ul class="flex flex-jc-c">
		<c:forEach var="i" begin="1" end="${totalPage}" step="1">
		<!-- 삼항연산자 i == paramPage 가 참이면 "current"  거짓이면 ""  -->
		<li class="${i == cPage ? 'current' : ''}"><a
			href="?cateItemId=${param.cateItemId}&searchKeywordType=${param.searchKeywordType}&searchKeyword=${param.searchKeyword}&page=${i}" class="block">${i}</a></li>
		</c:forEach>
	</ul>
</div>

<%@ include file="/jsp/part/foot.jspf"%>
