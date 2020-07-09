<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>

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

@media ( max-width : 700px ) {
	.form1 .form-row {
		display: block;
	}
}

.join-button {
	padding: 15px;
}

/* cus */
.write-form-box {
	margin-top: 30px;
	max-width: 500px;
	border: 5px solid navy;
    padding:0 20px;
}
</style>

<div class="title-box">
	<h1 class="con title">⭐Member Join</h1>
</div>


<div class="write-form-box margin-0-auto border-navy">
	<form action="doJoin" method="POST" class="join-form form1">
		<div class="form-row">
			<div class="label">Id</div>
			<div class="input">
				<input name="loginId" type="text" placeholder="ID를 입력해주세요." />
			</div>
		</div>
		<div class="form-row">
			<div class="label">name</div>
			<div class="input">
				<input name="name" type="text" placeholder="이름을 입력해주세요." />
			</div>
		</div>
		<div class="form-row">
			<div class="label">nickname</div>
			<div class="input">
				<input name="nickname" type="text" placeholder="닉네임을 입력해주세요." />
			</div>
		</div>
		<div class="form-row">
			<div class="label">PW</div>
			<div class="input">
				<input name="loginPw" type="password" placeholder="PW를 입력해주세요." />
			</div>
		</div>
		<div class="form-row">
			<div class="label">PW 확인</div>
			<div class="input">
				<input name="loginPw" type="password" placeholder="PW를 입력해주세요." />
			</div>
		</div>
		
		
		
		<div class="join-button text-align-center">
			<input type="submit" value="join" /> 
		</div>
	</form>
</div>

<%@ include file="/jsp/part/foot.jspf"%>
