<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>
<%@ include file="/jsp/part/toastUiEditor.jspf" %>
<script
	src="${pageContext.request.contextPath}/resource/js/common.js"></script>

<style>
.border-navy {
	border: 5px solid navy;
}

.navy {
	color: navy;
}

.detail-modify {
	position: absolute;
	right: 120px;
}

.detail_a {
	padding-top: 30px;
	text-align: center;
}

.detail_b {
	position: absolute;
	padding-right: 100px;
}

.detail_c {
	position: absolute;
	padding-left: 100px;
}

.all-label {
	margin: 10px;
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

.detail-body {
	padding: 20px !important;
}

/* 댓글 */
.reply-button {
	margin-bottom: 50px;
}

.reply-button>.reply1 {
	width: 300px;
}

.replyList>.label {
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

.reply-form-box> .replyList> .reply1 {
	min-height: 80px;
}

.reply1>.reply-body {
	font-size: 1.3rem;
}

.reply-form-box> .replyList> .button {
	
}
.table-box .border-navy {
	border: 5px solid navy;
}
</style>


<div class="article-detail con table-box">
	<div class="title-box">
		<h1 class="con title">게시물 디테일😀</h1>
	</div>

	<h3 class="con hit">
		조회수 :
		${article.hit}</h3>
	<table class="border-navy">
		<colgroup>
			<col width="20%">
			<col width="80%">
		</colgroup>
		<tbody>
			<tr>
				<th class="navy">제목</th>
				<td>${article.title}</td>
			</tr>
			<tr>
				<th class="navy">게시물번호</th>
				<td>${article.id}</td>
			</tr>
			<tr>
				<th class="navy">카테고리</th>
				<td>${article.cateItemId}-${cateItemName}</td>
			</tr>
			<tr>
				<th class="navy">작성자</th>
				<td>${article.extra.writer}</td>
			</tr>
			<tr>
				<th class="navy">작성날짜</th>
				<td>${article.regDate}</td>
			</tr>
			<tr>
				<th class="navy">수정날짜</th>
				<td>${article.updateDate}</td>
			</tr>
			<tr>
				<td colspan="2" class="detail-body">
					<script type="text/x-template">${article.bodyForXTemplate}</script>
					<div class="toast-editor toast-editor-viewer"></div>
				</td>
			</tr>

			<tr>
				<td colspan="2" class="border-navy">
					<div class="reply-form-box form1 flex">
						<form name="form" action="doReply" method="POST" class="form1 flex"	onsubmit="submitReplyForm(this); return false;">
							<div class="form-row">
								<div class="label navy">댓글</div>
								<div class="input">
									<input type="hidden" name="articleId" value="${param.id}" /> <input
										name="body" type="text" placeholder="댓글을 입력해주세요." />
								</div>
							</div>

							<div class="form-row reply-button text-align-right">
								<div class="input">
									<input type="submit" value="작성" />
								</div>
							</div>
						</form>
						<div class="border"></div><div class="border"></div>
	
						<div class="replyList">
							<div class="label navy">댓글리스트</div>
							<c:forEach items="${articleReplies}" var="articleReply">
							<div class="reply1">
								<div class="reply2">
									<div class="reply-head">
										작성자 : ${articleReply.extra.writer}
										&emsp;작성날짜 : ${articleReply.regDate}
									</div>
									<input type="hidden" value="${param.id}" />
								</div>
								<div class="reply-body">${articleReply.body}</div>
							</div>
							<div class="button text-align-right">
								<c:if test="${isLogined}">
			                    	<input type="button" value="수정" name="body" onclick="location.href='replyModify?id=${articleReply.id}'" />
			                    	<input type="button" value="삭제" onclick="location.href='doReplyDelete?replyId=${articleReply.id}&id=${param.id}'" />
								</c:if>
							</div>
							<div class="border"></div>
							</c:forEach>
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="btn-box">
		<div class="con relative">
			<a class="absolute-left all-label" href="./list">전체목록</a>
			<c:if test="${article.extra.modifyAvailable}">
				<a onclick="if( confirm('수정하시겠습니까?') == false ) return false;" class="detail-modify all-label" href="modify?id=${article.id}">수정하기</a> 
			</c:if>
			<c:if test="${article.extra.deleteAvailable}">
				<a onclick="if( confirm('삭제하시겠습니까?') == false ) return false;" class="absolute-right all-label" href="delete?id=${article.id}">삭제하기</a>
			</c:if>
		</div>

		<div class="con detail_a relative">
			<a class="detail_b" href="#"> < 이전글</a> 
			<a class="detail_c" href="#">다음글	> </a>
		</div>
	</div>
</div>

<%@ include file="/jsp/part/foot.jspf"%>
