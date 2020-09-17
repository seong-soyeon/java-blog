<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<style>
/* lib */
.form1 {
	display: block;
	width: 100%;
}

.form1 .form-row {
	align-items: center;
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
	padding-bottom: 20px;
}

/* 탭메뉴 */
button {
	background: none;
	border: 0;
	outline: 0;
	cursor: pointer;	/*버튼에 커서 올리면 손가락모양 나오도록 */
	font-size: 1.5rem;
}

.tab_menu_container {
	display: flex;
}

.tab_menu_btn {
	width: 50%;
	height: 70px;
	transition: 0.3s all;
}

.tab_menu_btn.on {
	border-bottom: 2px solid navy;
	font-weight: 1000;
	color: navy;
}

.tab_menu_btn:hover {
	color: navy;
}

.tab_box {
  display:none;
  padding:10px;
}

.tab_box.on {
  display:block;
}

</style>


<div class="title-box">
	<h1 class="con title">⭐Id / Pw 찾기</h1>
</div>


<div class="join-form-box margin-0-auto border-navy">
	<div class="tab_wrap">
		<div class="tab_menu_container">
			<button class="tab_menu_btn on tab_menu_btn1" type="button">ID 찾기</button>
			<button class="tab_menu_btn tab_menu_btn2" type="button">PW 찾기</button>
		</div>
	
		<div class="tab_box_container form1">
			<form action="doFindId" method="POST" class="join-form form1" onsubmit="submitJoinForm(this); return false">
				<div class="tab_box1 tab_box on form-row">
					<div class="label">name</div>
					<div class="input">
						<input name="name" type="text" placeholder="이름을 입력해주세요." />
					</div>
				</div>
				<div class="tab_box1 tab_box on form-row">
					<div class="label">email</div>
					<div class="input">
						<input name="email" type="email" placeholder="이메일를 입력해주세요." />
					</div>
				</div>
				
				<div class="join-button on tab_box1 tab_box text-align-center">
					<div class="input ">
						<input type="submit" value="확인" />
						<input type="button" onclick="location.href='login'" value="취소" />
					</div>
				</div>
			</form>
	
			<form action="doFindPw" method="POST" class="join-form form1" onsubmit="submitJoinForm(this); return false">	
				<div class="tab_box2 tab_box form-row">
					<div class="label">ID</div>
					<div class="input">
						<!-- name 중요 js, url 등에서 사용하는 명칭 -->
						<input name="loginId" type="text" placeholder="ID를 입력해주세요." />
					</div>
				</div>
				<div class="tab_box2 tab_box form-row">
					<div class="label">email</div>
					<div class="input">
						<input name="email" type="email" placeholder="이메일를 입력해주세요." />
					</div>
				</div>
				
				<div class="join-button tab_box tab_box2 text-align-center">
					<div class="input">
						<input type="submit" value="확인" />
						<input type="button" onclick="location.href='login'" value="취소" />
					</div>
				</div>
			</form>
		</div>
	</div>
</div>


<script>
//버튼 색 제거,추가
$('.tab_menu_btn').on('click',function(){
  $('.tab_menu_btn').removeClass('on');
  $(this).addClass('on')
});
//1번 컨텐츠
$('.tab_menu_btn1').on('click',function(){
  $('.tab_box').hide();
  $('.tab_box1').show();
});

//2번 컨텐츠
$('.tab_menu_btn2').on('click',function(){
  $('.tab_box').hide();
  $('.tab_box2').show();
});





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

  form.email.value = form.email.value.trim();
  if ( form.email.value.length == 0 ) {
    alert('이메일을 입력해주세요.');
    form.email.focus();
    
    return;
  }
  
  form.loginId.value = form.loginId.value.trim();
  if ( form.loginId.value.length == 0 ) {
    alert('아이디를 입력해주세요.');
    form.loginId.focus();

    return;
  }
  
  <!-- 여기까지 왔따면 다 입력됬다는거. form속성인 onsubmit에서 return false 해놓았기 때문에 강제로 제출하기-->
  form.submit();
  joinFormSubmitted = true;
} 
</script>

<%@ include file="/jsp/part/foot.jspf"%>
