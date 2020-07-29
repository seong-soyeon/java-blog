<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="⭐Member login"></c:set>
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

@media ( max-width : 700px ) {
	.form1 .form-row {
		display: block;	
	}
}

/* cus */
.login-form-box {
	margin-top: 30px;
	max-width: 500px;
	border: 5px solid navy;
	padding: 20px;
}
</style>
<script>
var loginFormSubmitted = false;
<!-- 제출 두번되지 않도록 맨윗줄에서 false해놓는다. 다입력했다면 마지막 코드에 도달해서 true로 바꿈 -->
<!-- true라면 아래 함수 실행 해서 중복제출 막음-->
function submitLoginForm(form) {
  if ( loginFormSubmitted ) {
    alert('처리 중입니다.');
    return;
  }
  <!-- 공백ㄴㄴ > 알림창 뜨도록 -->
  form.loginId.value = form.loginId.value.trim();
  if ( form.loginId.value.length == 0 ) {
    alert('아이디를 입력해주세요.');
    form.loginId.focus(); <!-- loginId에서 커서 깜박이도록 -->
    <!-- 알림창 뜨고 더이상 진행 안되도록 return-->
    return;
  }

  <!-- indexOf(' ') != -1 // id중간에 띄워쓰기 있다면-->
  if ( form.loginId.value.indexOf(' ') != -1 ) {
    alert('아이디를 영문소문자와 숫자의 조합으로 입력해주세요.')
    form.loginId.focus();
    
    return;
  }
  
  form.loginPw.value = form.loginPw.value.trim();
  if ( form.loginPw.value.length == 0 ) {
    alert('비밀번호를 입력해주세요.');
    form.loginPw.focus();
    
    return;
  }
  if ( form.loginPw.value.indexOf(' ') != -1 ) {
	alert('비밀번호를 영문소문자와 숫자의 조합으로 입력해주세요.')
    form.loginPw.focus();
	    
    return;
  }

  <!-- 비밀번호 보안을 위해, 해시 함수 중 sha256사용 -->
  <!-- loginPw를 암호화 하여 loginPwReal에 넣고 loginPw는 보안을 위해 빈칸처리 -->
  form.loginPwReal.value = sha256(form.loginPw.value);
  form.loginPw.value = '';
  
  <!-- 여기까지 왔따면 다 입력됬다는거. 쩌~아래 form에 onsubmit에서 return false 해놓았기 때문에 강제로 제출-->
  form.submit();
  loginFormSubmitted = true;
}
</script>

<div class="login-form-box margin-0-auto border-navy">
	<!-- 로그인 폼은 POST로 하라고 하심 (멱등성이 보장이 안되는 일은 POST-ex.회원가입,게시물등록) -->
	<form action="doLogin" method="POST" class="join-form form1"
		onsubmit="submitLoginForm(this); return false;">
		<!-- 빈칸ㄴㄴ -->
		<!-- js에서 보안작업 하기위해 hidden으로 몰래 loginPwReal 만들어 놈 -->
		<input type="hidden" name="redirectUrl" value="${param.afterLoginRedirectUrl}" />
		<input type="hidden" name="loginPwReal" />
		<div class="form-row">
			<div class="label">ID</div>
			<div class="input">
				<!-- name 중요 js, url 등에서 사용하는 명칭 -->
				<input name="loginId" type="text" placeholder="ID를 입력해주세요." />
			</div>
		</div>
		<div class="form-row">
			<div class="label">PW</div>
			<div class="input">
				<input name="loginPw" type="password" placeholder="PW를 입력해주세요." />
			</div>
		</div>
		
		<div class="form-row">
			<div class="input">
				<!-- 버튼 이미지 원하면 input type="image" -->
				<input type="submit" value="로그인" style="margin-top: 10px;"/>
				
			</div>
		</div>
		<div class="form-row">
			<div class="input">
				<input type="button" value="회원가입" onclick="location.href='join'" />
			</div>
		</div>
		<div class="form-row">
			<div class="input flex">
				<input type="button" value="ID/PW찾기" onclick="location.href='findIdPw'" />
			</div>
		</div>
	</form>
</div>

<%@ include file="/jsp/part/foot.jspf"%>
