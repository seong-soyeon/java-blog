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




<!-- 카테고리 -->
.cateItem {
	position: absolute;
	width: 238px;
	height: 359px;
	left: 1020px;
	top: 314px;
	
	background-color: red;
	border: 1px solid #000000;
	box-sizing: border-box;
	border-radius: 30px;
}

</style>



<div class="title-box">
	<h1 class="con title"><a href="https://www.figma.com/file/Zew7csjRiiauCbrN4hiH1K/Untitled?node-id=0%3A1" class="block">게시물 리스트😀</a></h1>
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

<div class="cateItem con">
	<h4>카테고리</h4>
	<ul>
		<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=1&page=1"># IT/자바</a></li>
		<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=2&page=1"># IT/HTML_CSS_JS</a></li>
		<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=3&page=1"># IT/상식</a></li>
		<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=4&page=1"># IT/그외상식</a></li>
		<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=5&page=1"># 공부계획</a></li>
		<li><a href="${pageContext.request.contextPath}/s/article/list?cateItemId=6&page=1"># 일상</a></li>
	</ul>
</div>


<!-- 
/* Rectangle 9 */

position: absolute;
width: 238px;
height: 359px;
left: 1020px;
top: 314px;

background: rgba(255, 255, 255, 0.4);
border: 1px solid #000000;
box-sizing: border-box;
border-radius: 30px;


/* # IT/자바 # IT/HTML_CSS_JS # IT/상식 # IT/그외상식 # 공부계획 # 일상 */

position: absolute;
width: 202px;
height: 245px;
left: 1040px;
top: 399px;

font-family: Roboto;
font-style: normal;
font-weight: normal;
font-size: 22px;
line-height: 26px;

color: #000000;



/* 카테고리 */

position: absolute;
width: 104px;
height: 33px;
left: 1046px;
top: 345px;

font-family: Roboto;
font-style: normal;
font-weight: normal;
font-size: 28px;
line-height: 33px;
/* identical to box height */

color: #000000;



/* Line 1 */

position: absolute;
width: 219px;
height: 0px;
left: 1029px;
top: 381px;

border: 1px solid #000000;
transform: rotate(0.28deg);

 -->





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
