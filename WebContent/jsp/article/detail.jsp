<%@ page import="java.util.List"%>
<%@ page import="com.sbs.java.blog.dto.Article"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>
<%
	Article article = (Article) request.getAttribute("article");
	String cateItemName = (String)request.getAttribute("cateItemName");
%>
<!-- 하이라이트 라이브러리 추가, 토스트 UI 에디터에서 사용됨 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/highlight.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/styles/default.min.css">

<!-- 하이라이트 라이브러리, 언어 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/css.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/javascript.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/xml.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/php.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/php-template.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/languages/sql.min.js"></script>

<!-- 코드 미러 라이브러리 추가, 토스트 UI 에디터에서 사용됨 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css" />

<!-- 토스트 UI 에디터, 자바스크립트 코어 -->
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-viewer.min.js"></script>

<!-- 토스트 UI 에디터, 신택스 하이라이트 플러그인 추가 -->
<script
	src="https://uicdn.toast.com/editor-plugin-code-syntax-highlight/latest/toastui-editor-plugin-code-syntax-highlight-all.min.js"></script>

<!-- 토스트 UI 에디터, CSS 코어 -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<style>
.border-navy {
    border: 5px solid navy;
}
.navy {
	color: navy;
}
.detail-modify {
	position: absolute;
	right:80px;
}
.detail_a {
	padding-top:30px;
	text-align:center;
}
.detail_b {
	position: absolute;
	padding-right:100px;
}
.detail_c {
	position: absolute;
	padding-left:100px;
}

</style>


<div class="article-detail con table-box">
	<div class="title-box">
		<h1 class="con title">게시물 디테일😀</h1>
	</div>
	
	<h3 class="con hit">조회수 : <%=article.getHit()%></h3>
	<table class="border-navy">
			<colgroup>
			<col width="20%">
			<col width="80%">
		</colgroup>
		<tbody>
			<tr>
				<th class="navy">제목</th>
				<td><%=article.getTitle()%></td>
			</tr>
			<tr>
				<th class="navy">게시물번호</th>
				<td><%=article.getId()%></td>
			</tr>
			<tr>
				<th class="navy">카테고리</th>
				<td><%=article.getCateItemId()%>-<%=cateItemName%></td>
			</tr>
			<tr>
				<th class="navy">작성자</th>
				<td><%=article.getExtra().get("writer")%></td>
			</tr>
			<tr>
				<th class="navy">작성날짜</th>
				<td><%=article.getRegDate()%></td>
			</tr>
			<tr>
				<th class="navy">수정날짜</th>
				<td><%=article.getUpdateDate()%></td>
			</tr>
			<tr>	
				<td colspan="2"><script type="text/x-template" id="origin1" style="display:none;"><%=article.getBodyForXTemplate()%></script>
				<div id="viewer1"></div></td>
				<script src="${pageContext.request.contextPath}/resource/js/common.js"></script>
				<script>
					var editor1__initialValue = getBodyFromXTemplate('#origin1');
					var editor1 = new toastui.Editor({
					  el: document.querySelector("#viewer1"),
					  viewer:true,
					  initialValue : getForEditorBody('#origin1'),
					  initialValue: editor1__initialValue,
					  plugins: [toastui.Editor.plugin.codeSyntaxHighlight, youtubePlugin, replPlugin, codepenPlugin]
					});

					function getForEditorBody(selector) {
						return $(selector).html().trim().replace(/<!--REPLACE:SCRIPT-->/gi,	"script");
					}
				</script>
			</tr>
			
			
		</tbody>
	</table>
	<div class="btn-box">
		<div class="con relative">
			<a class="absolute-left" href="./list">전체목록</a>
			<!-- <a class="detail-modify" href="${pageContext.request.contextPath}/s/article/modify?id=<%=article.getId()%>">수정하기</a> -->
			<!-- <a class="detail-modify" href="modify?id=<%=article.getId()%>">수정하기</a> -->
			<!-- <a class="absolute-right" href="delete?id=${param.id}">삭제하기</a> -->
					
			<a class="detail-modify" href="modify?id=<%=article.getId()%>">수정하기</a>
			<a class="absolute-right" href="delete?id=<%=article.getId()%>">삭제하기</a>
		</div>
		
		<div class="con detail_a ">
			<a class="detail_b" href=""> < 이전글</a>
			
			<a class="detail_c" href="#">다음글 > </a>
		</div>
	</div>
	
	//form으로 바꾸기
	<div class="">
	//가로줄 (한줄 or 2줄)
	//댓글 총 갯수
	//네모박스 회색 #ccc
	//댓글작성버튼
	//for문으로 댓글 나열
	</div>
	
	
	
	
	
	
	
	
</div>








<%@ include file="/jsp/part/foot.jspf"%> 