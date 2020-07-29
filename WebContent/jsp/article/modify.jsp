<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>
<%@ include file="/jsp/part/toastUiEditor.jspf"%>

<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
/* lib */
.form1 {
	display: block;
	width: 100%;
}

.form1 .form-row {
	align-items: center;
	display: flex;
	margin-top: 10px;
}

.form1 .form-row>.label {
	width: 100px;
}

.form1 .form-row>.input {
	flex-grow: 1;
}

.form1 .form-row>.input>input, .form1 .form-row>.input>textarea {
	display: block;
	width: 100%;
	box-sizing: border-box;
	padding: 10px;
}

.form1 .form-row>.input>select {
	padding: 10px;
}

.form1 .form-row>.input>textarea {
	height: 500px;
}

@media ( max-width : 700px ) {
	.form1 .form-row {
		display: block;
	}
}

.modify-button {
	padding: 10px;
}
/* cus */
.write-form-box {
	margin-top: 30px;
}

.border-navy {
	border: 5px solid navy;
	padding: 0 20px;
}
</style>

<div class="title-box">
	<h1 class="con title">⭐Article Modify</h1>
</div>

<div class="write-form-box con border-navy">
	<form action="doModify" method="POST" name="update"	class="write-form form1" onsubmit="submitModifyForm(this); return false;">
		<input type="hidden" name="id" value="${article.id}" />
		<input type="hidden" name="body" />
		<div class="form-row">
			<div class="label">카테고리</div>
			<div class="input">
				<select name="cateItemId">
					<!-- 수정하려는 게시물의 Id와 같은 카네아이템 select -->
					<c:forEach items="${cateItems}" var="cateItem">
						<option ${article.cateItemId == cateItem.id ? 'selected' : ''} value="${cateItem.id}">${cateItem.name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
	
		<div class="form-row">
			<div class="label">제목</div>
			<div class="input">
				<!-- name="" : URL에서 getparameter로 받아오는 내용이므로 꼭 정하기-->
				<input name="title" type="text" value="${article.title}"/>
			</div>
		</div>
		<div class="form-row">
			<div class="label">내용</div>
			<div class="input">
				<script type="text/x-template">${article.bodyForXTemplate}</script>
				<div class="toast-editor"></div>
			</div>
		</div>

		<div class="modify-button text-align-right">
			<input type="submit" value="수정" />
			<input type="button" onclick="location.href='detail?id=${param.id}'" value="취소"/>
		</div>
	</form>
</div>id=${param.id}

<script>
	var modifyFormSubmitted = false;
	function submitModifyForm(form) {
		if (modifyFormSubmitted) {
			alert('처리 중입니다.');
			return;
		}
		
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();
			return;
		}

		var editor = $(form).find('.toast-editor').data('data-toast-editor');
		var body = editor.getMarkdown().trim();
		
		if (body.length == 0) {
			alert('내용을 입력해주세요.');
			editor.focus();
			return;
		}

		form.body.value = body;

		form.submit();
		modifyFormSubmitted = true;
	}
</script>
<%@ include file="/jsp/part/foot.jspf"%>