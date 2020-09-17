<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="⭐Article Detail⭐"></c:set>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/jsp/part/head.jspf"%>
<%@ include file="/jsp/part/toastUiEditor.jspf"%>

<div class="article-detail con table-box">
	<h3 class="con hit">조회수 : ${article.hit}</h3>
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
				<td colspan="2" class="detail-body"><script
						type="text/x-template">${article.bodyForXTemplate}</script>
					<div class="toast-editor toast-editor-viewer"></div></td>
			</tr>

			<tr>
				<td colspan="2" class="border-navy">
					<div class="reply-form-box form1 flex">
						<form name="form" action="doWriteReply" method="POST" class="write-reply-form form1 flex"
							onsubmit="WriteReplyForm__submit(this); return false;">
							<div class="form-row">
								<div class="label navy">댓글</div>

								<c:if test="${isLogined == false}">
									<div class="con">
										<!-- 아래 링크로 로그인 후 다시 돌아와 댓글에 포커스 주기 위한 코드 -->
										<!-- /s/member/login 뒤에 물음표 붙이고 아래 afterLoginRedirectUrl=value값 붙여줌 -->
										<c:url var="loginUrl" value="/s/member/login">
											<c:param name="afterLoginRedirectUrl"
												value="${currentUrl}&jsAction=WriteReplyForm__focus" />
										</c:url>
										<!-- 완성된 url여기 들어감 -->
										<a class="goLogin" href="${loginUrl}">로그인 후 이용해주세요.</a>
									</div>
								</c:if>

								<c:if test="${isLogined}">
									<script>
										var WriteReplyForm__submitDone = false;
										
										function WriteReplyForm__focus() {
											form.body.focus();
										}
										
										function WriteReplyForm__submit(form) {
											if (WriteReplyForm__submitDone) {
												alert('처리중입니다.');
												return;
											}

											form.body.value = form.body.value.trim();
											if (form.body.value.length == 0) {
												alert('내용을 입력해주세요.');
												form.body.focus();
												return;
											}
											form.body.value = body;
											form.submit();
											WriteReplyForm__submitDone = true;
										}
										
									</script>
									
									<!-- redirectUrl에는 WriteReplyForm__focus같은거 있으면 안됨(돌아와서 실행했으니까 또 댓글포커스할 필요없음) -->
									<!-- noBaseCurrentUri는 /s/article/detail정도만 담은 uri (base는 blog임) -->
									<!-- c:choose,when >> if/else같은거 : p.key가 jsAction이면 아무것도 안할거임(noBaseCurrentUri뒤에 안붙임) -->
									<!-- c:otherwise >> 나머지 p.key값은 들어감 -->
									<c:url value="${noBaseCurrentUri}" var="redirectUrl">
										<c:forEach items="${paramValues}" var="p">
											<c:choose>
												<c:when test="${p.key == 'jsAction'}">
												</c:when>
												<c:otherwise>
													<c:forEach items="${p.value}" var="val">
														<c:param name="${p.key}" value="${val}" />
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										
										<c:param name="jsAction" value="WriteReplyList__showDetail" /><!-- 반복문 끝나고 jsAction에 새로운 value넣음 -->
									</c:url>
									
									<div class="input">
										<input type="hidden" name="redirectUrl" value="${redirectUrl}">
										<input type="hidden" name="articleId" value="${article.id}" />
										<input class="replyBody" name="body" type="text" placeholder="댓글을 입력해주세요." />
									</div>
									<div class="flex-ai-e replyWrite-btn text-align-right">
										<input class="replyWrite-btn2" type="submit" value="작성" />
										<input class="replyWrite-btn2" type="reset" value="취소" />
									</div>
								</c:if>
							</div>
						</form>
						
						
						<div class="border"></div>
						<div class="border"></div>


						<!-- 댓글창으로 스크롤이동 --><!-- 첫번째 댓글 하이라이트 -->
						<script>
						function WriteReplyList__showDetail() {
							var top = $('.replyList').offset().top;
							$(window).scrollTop(top);

							// '.replyList> .label .reply1:first-child' 원래 소연 코드 
							var $reply = $('.reply1[data-id="' + param.generatedArticleReplyId + '"]');    
							$reply.addClass('high');
							setTimeout(function() {
								$reply.removeClass('high');
							}, 1000);
						}
						</script>
												
						<style>
						/* .replyList > .label .reply1.high {  원래 소연 코드 */
						.reply1.high {
							background-color: gold;
						}
						
						/* .replyList > .label .reply1 {      원래 소연 코드 */
						.reply1 {
							transition: background-color 1s;
						} 
						</style>
						
						<div class="replyList">
							<div class="label navy">댓글리스트</div>
							<c:forEach items="${articleReplies}" var="articleReply">
								<div class="reply1" data-id="${articleReply.id}">
									<div class="reply2">
										<div class="reply-head">작성자 :
											${articleReply.extra.writer} &emsp;작성날짜 :
											${articleReply.regDate}</div>
										<input type="hidden" value="${param.id}" />
									</div>
									<div class="reply-body">${articleReply.body}</div>
								</div>
								<div class="button text-align-right">
									<c:if test="${articleReply.extra.modifyAvailable}">
										<input type="button" value="수정" name="body"
											onclick="location.href='replyModify?id=${articleReply.id}'" />
									</c:if>
									<c:if test="${articleReply.extra.deleteAvailable}">
										<input type="button" value="삭제"
											onclick="if( confirm('삭제하시겠습니까?') == false ) return false;" location.href="doDeleteReply?id=${articleReply.id}&redirectUrl=${afterDeleteReplyRedirectUrl}" />
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
				<a onclick="if( confirm('수정하시겠습니까?') == false ) return false;"
					class="detail-modify all-label" href="modify?id=${article.id}">수정하기</a>
			</c:if>
			<c:if test="${article.extra.deleteAvailable}">
				<a onclick="if( confirm('삭제하시겠습니까?') == false ) return false;"
					class="absolute-right all-label" href="delete?id=${article.id}">삭제하기</a>
			</c:if>
		</div>

		<div class="con detail_a relative">
			<a class="detail_b" href="#"> < 이전글</a> <a class="detail_c" href="#">다음글
				> </a>
		</div>
	</div>
</div>

<%@ include file="/jsp/part/foot.jspf"%>
