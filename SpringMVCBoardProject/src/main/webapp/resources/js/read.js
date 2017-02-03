/**
 *	read.jsp 
 */


// 페이지 내 버튼 이벤트 처리
$(document).ready(function() {
	var formObj = $("form[role='form']");
	
	$(".btn-warning").on("click", function() {
		formObj.attr("action", "/board/modify");
		formObj.attr("method", "get");
		formObj.submit();
	});
	
	$("#readPageDelBtn").on("click", function() {
		var replyCnt = $("#replycntSmall").html().replace(/[^0-9]/g, "");
		if(replyCnt > 0) {
			alert("댓글이 달린 게시물을 삭제할 수 없습니다.");
			return;
		}
		
		var arr = [];
		$(".uploadedList li").each(function(index) {
			arr.push($(this).attr("data-src"));
		});
		if(arr.length > 0) {
			$.post("/upload/deleteAllFiles", {files : arr}, function() {
				
			});
		}
		
		formObj.attr("action", "/board/delete");
		formObj.submit();
	});
	
	$("#listPageBtn").on("click", function() {
		formObj.attr("method", "get");
		formObj.attr("action", "/board/list");
		formObj.submit();
	});
});


// reply list 처리
Handlebars.registerHelper("prettifyDate", function(timeValue) {
	var dateObj = new Date(timeValue);
	var year = dateObj.getFullYear();
	var month = dateObj.getMonth() + 1;
	var date = dateObj.getDate();
	var hours = dateObj.getHours();
	var minutes = dateObj.getMinutes();
	return year + "/" + month + "/" + date + " " + hours + ":" + minutes;
});

function printData(replyArr, target, templateObject) {
	var template = Handlebars.compile(templateObject.html());
	var html = template(replyArr);
	$(".replyLi").remove();
	target.after(html);
}

function getPage(pageInfo) {
	$.getJSON(pageInfo, function(data) {
		printData(data.list, $("#repliesDiv"), $("#template"));
		printPaging(data.pageMaker, $(".pagination"));
		
		$("#modifyModal").modal("hide");
		$("#replycntSmall").html("[" + data.pageMaker.totalCount + "]");
	});
}

$("#repliesDiv").on("click", function() {
	if($(".timeline li").length > 1) {
		return;
	}

	getPage("/replies/" + bno + "/1");
});

Handlebars.registerHelper("eqReplyer", function(replyer, block) {
	var accum = "";
	if(replyer == userName) {
		accum += block.fn();
	}
	
	return accum;
});



// reply paging 처리
function printPaging(pageMaker, target) {
	var str = "";
	
	if(pageMaker.prev) {
		str += "<li><a href='" + (pageMaker.startPage - 1) + "'>&laquo;</a></li>";
	}
	
	for(var i = pageMaker.startPage; i <= pageMaker.endPage; i++) {
		var strClass = pageMaker.cri.page == i? 'class=active' : '';
		str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
	}
	
	if(pageMaker.next) {
		str += "<li><a href='" + (pageMaker.endPage + 1) + "'>&raquo;</a></li>";
	}
	
	target.html(str);
}

$(".pagination").on("click", "li a", function(event) {
	event.preventDefault();
	
	replyPage = $(this).attr("href");
	
	getPage("/replies/" + bno + "/" + replyPage);
});



// add reply 처리
$("#replyAddBtn").on("click", function() {
	var replyerObj = $("#newReplyWriter");
	var replytextObj = $("#newReplyText");
	
	var replyer = replyerObj.val();
	var replytext = replytextObj.val();
	
	$.ajax({
		type : "post",
		url : "/replies/",
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dataType : "text",
		data : JSON.stringify({
			bno : bno,
			replyer : replyer,
			replytext : replytext
		}),
		success : function(result) {
			if(result == "success") {
				alert("등록 되었습니다.");
				getPage("/replies/" + bno + "/1");
				// replyerObj.val("");
				replytextObj.val("");
			}
		}
	});
});



// modal 창 이벤트 처리
$(".timeline").on("click", ".replyLi", function() {
	var reply = $(this);
	
	$("#replytext").val(reply.find(".timeline-body").text());
	$(".modal-title").html(reply.attr("data-rno"));
});

$("#replyModBtn").on("click", function() {
	var rno = $(".modal-title").html();
	var replytext = $("#replytext").val();
	
	$.ajax({
		type : "put",
		url : "/replies/" + rno,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "put"
		},
		data : JSON.stringify({
			replytext : replytext
		}),
		dataType : "text",
		success : function(result) {
			if(result == "success") {
				alert("수정 되었습니다.");
				getPage("/replies/" + bno + "/" + replyPage);
			}
		}
	});
});

$("#replyDelBtn").on("click", function() {
	var rno = $(".modal-title").html();
	
	$.ajax({
		type : "delete",
		url : "/replies/" + rno,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "delete"
		},
		dataType : "text",
		success : function(result) {
			if(result == "success") {
				alert("삭제 되었습니다.");
				getPage("/replies/" + bno + "/" + replyPage);
			}
		}
	});
});



// 첨부파일 화면 처리
var template = Handlebars.compile($("#templateAttach").html());

$.getJSON("/board/getAttach/" + bno, function(list) {
	$(list).each(function() {
		var fileInfo = getFileInfo(this);
		var html = template(fileInfo);
		$(".uploadedList").append(html);
	});
});



// 이미지 팝업 창 처리
$(".uploadedList").on("click", ".mailbox-attachment-info a", function(event) {
	var fileLink = $(this).attr("href");
	
	if(checkImageType(fileLink)) {
		event.preventDefault();
		var imgTag = $("#popup_img");
		imgTag.attr("src", fileLink);
		
		$(".popup").show("slow");
		imgTag.addClass("show");
	}
});

$("#popup_img").on("click", function() {
	$(".popup").hide("slow");
});


function goLogin() {
	self.location = "/user/login";
}
