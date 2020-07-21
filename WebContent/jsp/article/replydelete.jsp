<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>

<div class="title-box">
	<h1 class="con title">⭐Article Write</h1>
</div>


<div class="write-form-box con border-navy">
	<form action="doWrite" method="POST" class="write-form form1" onsubmit="submitWriteForm(this); return false">
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
				<input name="title" type="text" placeholder="제목을 입력해주세요." />
			</div>
		</div>
		<div class="form-row">
			<div class="label">내용</div>
			<div class="input">
				<!-- textarea : 긴텍스트 넣을때 -->
				<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
			</div>
		</div>
		
		
		
		<div class="write-button text-align-right">
			<input type="submit" value="작성" /> 
			<!-- <a href="list">취소</a> -->
		</div>
	</form>
</div>

<%@ include file="/jsp/part/foot.jspf"%>
