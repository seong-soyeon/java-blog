<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.sbs.java.blog.dto.Article"%>
<%@ include file="/jsp/part/head.jspf"%>
<%
	Article article = (Article) request.getAttribute("article");
	String cateItemName = (String) request.getAttribute("cateItemName");
%>


<meta name="viewport" content="width=device-width, initial-scale=1">

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
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<!-- 토스트 UI 에디터, 신택스 하이라이트 플러그인 추가 -->
<script
	src="https://uicdn.toast.com/editor-plugin-code-syntax-highlight/latest/toastui-editor-plugin-code-syntax-highlight-all.min.js"></script>

<!-- 토스트 UI 에디터, CSS 코어 -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

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
	<form action="doModify" method="POST" name="update"	class="write-form form1" onsubmit="submitWriteForm(this); return false;">
		<input type="hidden" name="id" value="<%=article.getId()%>" />
		<input type="hidden" name="body" />
		<div class="form-row">
			<div class="label">카테고리</div>
			<div class="input">
				<select name="cateItemId">
					<%
						for (CateItem cateItem : cateItems) {
					%>
					<option value="<%=cateItem.getId()%>"><%=cateItem.getName()%></option>
					<%
						}
					%>
				</select>
			</div>
		</div>
	
		<div class="form-row">
			<div class="label">제목</div>
			<div class="input">
				<!-- name="" : URL에서 getparameter로 받아오는 내용이므로 꼭 정하기-->
				<input name="title" type="text" value="<%=article.getTitle()%>"/>
			</div>
		</div>
		<div class="form-row">
			<div class="label">내용</div>
			<div class="input">
				<script type="text/x-template" id="origin1" ><%=article.getBodyForXTemplate()%></script>
				<div id="editor1"></div>
			</div>
		</div>

		<div class="modify-button text-align-right">
			<input type="submit" value="수정" />
			<a href="list">취소</a>
		</div>
	</form>
</div>

<script>
	var writeFormSubmitted = false;
	function submitWriteForm(form) {
		if (writeFormSubmitted) {
			alert('처리 중입니다.');
			return;
		}
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();
			return;
		}

		//editor 입력
		var body = editor1.getMarkdown().trim();
		
		if (body.length == 0) {
			alert('내용을 입력해주세요.');
			editor1.focus();
			return;
		}

		form.body.value = body;

		form.submit();
		writeFormSubmitted = true;
	}

	var editor1 = new toastui.Editor({
		el : document.querySelector("#editor1"),
		height : "600px",
		initialEditType : "markdown",
		initialValue : getForEditorBody('#origin1'),
		previewStyle : "vertical",
		//initialValue : "# 내용을 입력해 주세요.",
		plugins : [ toastui.Editor.plugin.codeSyntaxHighlight, youtubePlugin,
				replPlugin, codepenPlugin ]
	});

</script>
<%@ include file="/jsp/part/foot.jspf"%>