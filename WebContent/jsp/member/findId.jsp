<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

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
	padding: 10px;
}

/* cus */
.join-form-box {
	margin-top: 30px;
	max-width: 500px;
	border: 5px solid navy;
	padding: 0 20px;
}
</style>


<script>
var joinFormSubmitted = false;
<!-- 제출 두번되지 않도록 맨윗줄에서 false해놓는다. 다입력했다면 마지막 코드에 도달해서 true로 바꿈 -->
<!-- true라면 아래 함수 실행 해서 중복제출 막음-->
function submitJoinForm(form) {
  if ( joinFormSubmitted ) {
    alert('처리 중입니다.');
    return;
  }

  form.name.value = form.name.value.trim();
  if ( form.name.value.length == 0 ) {
    alert('이름을 입력해주세요.');
    form.name.focus();
    
    return;
  }

  form.nickname.value = form.nickname.value.trim();
  if ( form.nickname.value.length == 0 ) {
    alert('닉네임을 입력해주세요.');
    form.nickname.focus();
    
    return;
  }

  form.email.value = form.email.value.trim();
  if ( form.email.value.length == 0 ) {
    alert('이메일을 입력해주세요.');
    form.email.focus();
    
    return;
  }
  
  <!-- 비밀번호 보안을 위해, 해시 함수 중 sha256사용 -->
  <!-- loginPw를 암호화 하여 loginPwReal에 넣고 loginPw는 보안을 위해 빈칸처리 -->
 	form.loginPwReal.value = sha256(form.loginPw.value);
	form.loginPw.value = '';
	form.loginPwConfirm.value = '';
  
  <!-- 여기까지 왔따면 다 입력됬다는거. form속성인 onsubmit에서 return false 해놓았기 때문에 강제로 제출하기-->
  form.submit();
  joinFormSubmitted = true;
} 

</script>


<div class="title-box">
	<h1 class="con title">⭐Id 찾기</h1>
</div>


<div class="join-form-box margin-0-auto border-navy">
	<form action="doFindId" method="POST" class="join-form form1"
		onsubmit="submitJoinForm(this); return false">
		<input type="hidden" name="loginPwReal" />
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
			<div class="label">email</div>
			<div class="input">
				<input name="email" type="email" placeholder="이메일를 입력해주세요." />
			</div>
		</div>

		<div class="join-button text-align-center">
			<div class="input">
				<input type="submit" value="확인" />
				<input type="button" onclick="location.href='../home/main'" value="취소"/>
			</div>
		</div>
	</form>
</div>

<%@ include file="/jsp/part/foot.jspf"%>
