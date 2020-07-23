<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>

<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 하이라이트 라이브러리 추가, 토스트 UI 에디터에서 사용됨 (//하이라이트를 켜는 것) -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/highlight.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.1.1/styles/default.min.css">

<!-- 하이라이트 라이브러리, 언어 (cdnjs.com>highlight.js에서 필요한 언어 찾아서 더 추가 가능) -->
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

<!-- 토스트 UI 에디터, 신택스 하이라이트 플러그인 추가 (//하이라이트 받아서 적용하려면 필요) -->
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

.write-button {
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
</script>



<div class="title-box">
	<h1 class="con title">⭐Article Write</h1>
</div>


<div class="write-form-box con border-navy">
	<form action="doWrite" method="POST" class="write-form form1"
		onsubmit="submitWriteForm(this); return false">
		<div class="form-row">
			<div class="label">카테고리</div>
			<div class="input">
				<select name="cateItemId">
					<c:forEach items="${cateItems}" var="cateItem">
						<option value="${cateItem.id}">${cateItem.name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="form-row">
			<div class="label">제목</div>
			<div class="input">
				<!-- name="" : URL에서 getparameter로 받아오는 내용이므로 꼭 정하기-->
				<input name="title" type="text" placeholder="제목을 입력해주세요." />
			</div>
		</div>
		<div class="form-row">
			<div class="label">내용</div>
			<div class="input">
				<input type="hidden" name="body">
				<div id="editor1"></div>
			</div>
		</div>

		<div class="write-button text-align-right">
			<div class="input">
				<input type="submit" value="작성" />
				<input type="button" onclick="location.href='list'" value="취소"/>
			</div>
		</div>
	</form>
</div>


<script>
	var editor1 = new toastui.Editor({
		el : document.querySelector("#editor1"),
		height : "600px",
		initialEditType : "markdown",
		previewStyle : "vertical",		//프리뷰모드가 옅에 보이도록(markdown모드 일때만 가능)
		initialValue : "# 내용을 입력해 주세요.",
		plugins : [ toastui.Editor.plugin.codeSyntaxHighlight, youtubePlugin,
				replPlugin, codepenPlugin ]
	});
</script>

<%@ include file="/jsp/part/foot.jspf"%>
