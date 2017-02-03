/**
 * modify.jsp
 */


// 페이지 내 버튼 이벤트 처리
$(document).ready(function() {
	var formObj = $("form[role='form']");
			
	$(".btn-primary").on("click", function() {
		formObj.submit();
	});
	
	$(".btn-warning").on("click", function() {
		self.location = "/board/list?page=" + page + "&perPageNum=" + perPageNum
							+ "&searchType=" + searchType + "&keyword=" + keyword;
	});
});
