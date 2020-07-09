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

@media ( max-width : 700px ) {
	.form1 .form-row {
		display: block;
	}
}

.login-button {
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
	<h1 class="con title">⭐Member login</h1>
</div>


<div class="write-form-box margin-0-auto border-navy">
	<form action="doLogin" method="POST" class="join-form form1">
		<div class="form-row">
			<div class="label">Id</div>
			<div class="input">
				<input name="loginId" type="text" placeholder="ID를 입력해주세요." />
			</div>
		</div>
		<div class="form-row">
			<div class="label">PW</div>
			<div class="input">
				<input name="loginPw" type="text" placeholder="PW를 입력해주세요." />
			</div>
		</div>
		
		
		<div class="login-button text-align-center">
			<input type="submit" value="login" /> 
		</div>
	</form>
</div>

<%@ include file="/jsp/part/foot.jspf"%>
