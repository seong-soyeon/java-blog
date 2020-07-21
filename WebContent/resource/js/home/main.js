var replyFormSubmitted = false;
var onBeforeUnloadSetted = false;
var onBeforeUnload = function(e) {
  	return '떠나시겠습니까?';
};

function applyOnBeforeUnload() {
	if ( onBeforeUnloadSetted ) return;
	$(window).bind('beforeunload', onBeforeUnload);
	onBeforeUnloadSetted = true;
}

function removeOnBeforeUnload() {
	$(window).unbind('beforeunload', onBeforeUnload);
	onBeforeUnloadSetted = false;
}
	
function submitReplyForm(form) {
	if ( replyFormSubmitted ) {
		alert('처리 중입니다.');
		return;
  	}

	form.body.value = form.body.value.trim();
  	if (form.body.value.length == 0) {
    	alert('댓글을 입력해주세요.');
    	form.body.focus();
    	return;
  	}
  	removeOnBeforeUnload();
  	form.submit();
  	replyFormSubmitted = true;
}

$('form.write-form input, form.write-form textarea').keyup(function() {
	applyOnBeforeUnload();
})