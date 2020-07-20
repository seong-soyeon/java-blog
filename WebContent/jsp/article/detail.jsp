<%@ page import="java.util.List"%>
<%@ page import="com.sbs.java.blog.dto.Article"%>
<%@ page import="com.sbs.java.blog.dto.ArticleReply"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>
<%
	Article article = (Article) request.getAttribute("article");
	String cateItemName = (String)request.getAttribute("cateItemName");
	List<ArticleReply> articleReplies = (List<ArticleReply>) request.getAttribute("articleReplies");
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
	right:120px;
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
.all-label {
	margin:10px;
	padding: 5px 25px;
	height: 27px;
	text-align: center;
	background-color: #dbdbdb;
	color: navy;
	border-radius: 0.5em;
}

.form1 {
	display: block;
	width: 100%;
}

.form1 .form-row {
	align-items: center;
	display: flex;
	margin-top: 20px;
}

.form1 .form-row>.label {
	width: 130px;
	text-align: center;
	font-size: 1.5rem;
}

.form1 .form-row>.input {
	flex-grow: 1;
}
.form1 .form-row>.input>input {
	display: block;
	width: 100%;
	box-sizing: border-box;
	padding: 10px;
}


.reply-button {
	margin-bottom: 50px;
}

.reply-button> .reply1{
	width: 300px;
}

.replyList> .label{
	font-size: 1.5rem;
	margin-bottom: 30px;
	margin-left: 30px;
}

.border {
	border: 1px solid #dfdfdf;
	border-top: 0;
	border-left: 0;
	border-right: 0;
	margin-top: 10px;
	margin-bottom: 20px;
}

.td-body {
    padding: 20px !important;
}
</style>

<script>
var replyFormSubmitted = false;
<!-- 제출 두번되지 않도록 맨윗줄에서 false해놓는다. 다입력했다면 마지막 코드에 도달해서 true로 바꿈 -->
<!-- true라면 아래 함수 실행 해서 중복제출 막음-->
function submitReplyForm(form) {
  if ( replyFormSubmitted ) {
    alert('처리 중입니다.');
    return;
  }
  <!-- 공백ㄴㄴ > 알림창 뜨도록 -->
  form.body.value = form.body.value.trim();
  if ( form.body.value.length == 0 ) {
    alert('댓글을 입력해주세요.');
    form.body.focus(); <!-- loginId에서 커서 깜박이도록 -->
    <!-- 알림창 뜨고 더이상 진행 안되도록 return-->
    return;
  
  <!-- 여기까지 왔따면 다 입력됬다는거. form속성인 onsubmit에서 return false 해놓았기 때문에 강제로 제출하기-->
  form.submit();
  replyFormSubmitted = true;
}
</script>

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
				<td colspan="2" class="td-body"><script type="text/x-template" id="origin1" style="display:none;"><%=article.getBodyForXTemplate()%></script>
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
			
			<tr>
				<td colspan="2">
					<div class="reply-form-box form1 flex">
						<form action="doReply" method="POST" class="form1 flex" onsubmit="submitReplyForm(this); return false;">
						<!-- form으로 바꾸기 / 댓글 총 갯수 / 네모박스 회색 #ccc / for문으로 댓글 나열 -->
							<div class="form-row">
								<div class="label navy">댓글</div>
								<div class="input">
									<input type="hidden" name="articleId" value="${param.id}"/>
									<input name="body" type="text" placeholder="댓글을 입력해주세요." />
								</div>
							</div>
							
							<div class="form-row reply-button text-align-right">
								<div class="input">
									<input type="submit" value="작성" />
								</div>
							</div>
						</form>
					
						<div class="replyList">
							<div class="label navy">댓글리스트</div>
							<%
								for (ArticleReply articleReply : articleReplies) {
							%>  
							
							<div class="reply1">
								<div class="writer-data">
									<div class="writer1">
										작성자 :
										<%=articleReply.getExtra().get("writer")%></div>
									<div class="regDate1">
										작성일 :
										<%=articleReply.getRegDate()%>
									</div>
									<input type="hidden" value="${param.id}" />
								</div>
								<div class="body"><%=articleReply.getBody()%></div>
							</div>
							<div class="button">
									<input type="button" onclick="location.href='replyModify?id=<%=articleReply.getId()%>'" name="body" value="수정" /> 
									<button type="submit"
									onclick="location.href='doReplyDelete?replyId=<%=articleReply.getId()%>&id=${param.id}'">삭제</button>
							</div>
							
							<div class="border"></div>
							<%
								}
							%>
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="btn-box">
		<div class="con relative">
			<a class="absolute-left all-label" href="./list">전체목록</a>
			<!-- <a class="detail-modify" href="${pageContext.request.contextPath}/s/article/modify?id=<%=article.getId()%>">수정하기</a> -->
			<!-- <a class="detail-modify" href="modify?id=<%=article.getId()%>">수정하기</a> -->
			<!-- <a class="absolute-right" href="delete?id=${param.id}">삭제하기</a> -->
					
			<a class="detail-modify all-label" href="modify?id=<%=article.getId()%>">수정하기</a>
			<a class="absolute-right all-label" href="delete?id=<%=article.getId()%>">삭제하기</a>
		</div>
		
		<div class="con detail_a relative">
			<a class="detail_b" href="#"> < 이전글</a>
			
			<a class="detail_c" href="#">다음글 > </a>
		</div>
	</div>
	
	
	
</div>


<%@ include file="/jsp/part/foot.jspf"%> 