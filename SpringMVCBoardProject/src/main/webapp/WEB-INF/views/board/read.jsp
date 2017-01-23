<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="../include/header.jsp" %>


<section class="content">
	<!-- image view popup -->
	<div class="popup back" style="display:none;"></div>
	<div id="popup_front" class="popup front" style="display:none;">
		<img id="popup_img">
	</div>

	<div class="row">
		<div class="col-md-12">
			<div class="box">
				
				<div class="box-header with-border">
					
					<h3 class="box-title">READ BOARD</h3>
					
					<form role="form" method="post">
						<input type="hidden" name="bno" value="${boardVO.bno}">
						<input type="hidden" name="page" value="${cri.page}">
						<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
						<input type="hidden" name="searchType" value="${cri.searchType}">
						<input type="hidden" name="keyword" value="${cri.keyword}">
					</form>
					
				</div>
					
					
				<div class="box-body">
					<div class="form-group">
						<label for="exampleInputEmail1">Title</label>
						<input type="text" name="title" class="form-control" value="${boardVO.title}" readonly style="cursor:default">
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">Content</label>
						<textarea name="content" rows="3" class="form-control" readonly style="cursor:default">${boardVO.content}</textarea>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">Writer</label>
						<input type="text" name="writer" class="form-control" value="${boardVO.writer}" readonly style="cursor:default">
					</div>
				</div>
					
					
				<div class="box-footer">
					<div>
						<hr>
					</div>
					
					<ul class="mailbox-attachments clearfix uploadedList">
					</ul>
							
					<button type="submit" class="btn btn-warning">Modify</button>
					<button type="submit" class="btn btn-danger" id="readPageDelBtn">Remove</button>
					<button type="submit" class="btn btn-primary" id="listPageBtn">List Page</button>
				</div>
					
				
			</div>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col-md-12">
			<div class="box box-success">
				
				<div class="box-header">
					<h3 class="box-title">Add New Reply</h3>
				</div>
				
				<div class="box-body">
					<label for="newReplyWriter">Writer</label>
					<input type="text" class="form-control" placeholder="User ID" id="newReplyWriter">
					<label for="newReplyText">ReplyText</label>
					<input type="text" class="form-control" placeholder="Reply Text" id="newReplyText">
				</div>
				
				<div class="box-footer">
					<button type="submit" class="btn btn-primary" id="replyAddBtn">Add Reply</button>
				</div>
				
			</div>
			
			<ul class="timeline">
				<li class="time-label" id="repliesDiv"><span class="bg-green"><i class="fa fa-comment-o"></i>&nbsp;Replies List
					<small id="replycntSmall">[${boardVO.replycnt}]</small></span></li>
			</ul>
			
			<div class="text-center">
				<ul id="pagination" class="pagination pagination-sm no-margin">
				
				</ul>
			</div>
			
		</div>
	</div>
	
	
	<!-- modal -->
	<div id="modifyModal" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="close">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				
				<div class="modal-body" data-rno>
					<p><input type="text" id="replytext" class="form-control"></p>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
					<button type="button" class="btn btn-danger" id="replyDelBtn">Remove</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				</div>
				
			</div>
		</div>
	</div>
	
	
	
	
</section>


<%@ include file="../include/footer.jsp" %>

<script>
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
</script>

<!-- font awesome -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- handlebars.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.6/handlebars.min.js"></script>
<!-- handlebars template -->
<script id="template" type="text/x-handlebars-template">
	{{#each .}}
	<li class="replyLi" data-rno={{rno}}>
		<i class="fa fa-comment-o bg-green"></i>
		<div class="timeline-item">
			<span class="time"><i class="fa fa-clock-o"></i>{{prettifyDate regdate}}</span>
			<h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
			<div class="timeline-body">{{replytext}}</div>
			<div class="timeline-footer">
				<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
			</div>
		</div>
	</li>
	{{/each}}
</script>

<!-- reply list -->
<script>
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
	
	
	var bno = ${boardVO.bno};
	var replyPage = 1;
	
	function getPage(pageInfo) {
		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $("#template"));
			printPaging(data.pageMaker, $(".pagination"));
			
			$("#modifyModal").modal("hide");
			$("#replycntSmall").html("[" + dta.pageMaker.totalCount + "]");
		});
	}
	
	$("#repliesDiv").on("click", function() {
		if($(".timeline li").length > 1) {
			return;
		}

		getPage("/replies/" + bno + "/1");
	});
	
</script>

<!-- reply paging -->
<script>
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
</script>

<!-- add reply -->
<script>
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
					replyerObj.val("");
					replytextObj.val("");
				}
			}
		});
	});
</script>

<!-- modal 창 이벤트 처리 -->
<script>
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
</script>

<!-- 첨부파일 화면 처리 -->
<script src="/resources/js/upload.js"></script>
<script id="templateAttach" type="text/x-handlebars-template">
	<li data-src="{{fullName}}">
		<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
		<div class="mailbox-attachment-info">
			<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
		</div>
	</li>
</script>
<script>
	var template = Handlebars.compile($("#templateAttach").html());
	
	$.getJSON("/board/getAttach/" + bno, function(list) {
		$(list).each(function() {
			var fileInfo = getFileInfo(this);
			var html = template(fileInfo);
			$(".uploadedList").append(html);
		});
	});
</script>

<style type="text/css">
	.popup {position : absolute;}
	.back {
		background-color : gray;
		opacity : 0.5;
		width : 100%;
		height : 300%;
		overflow : hidden;
		z-index : 1101;
	}
	.front {
		z-index : 1110;
		opacity : 1;
		border : 1px;
		margin : auto;
	}
	.show {
		position : replative;
		max-width : 1200px;
		max-height : 800px;
		overflow : auto;
	}
</style>

<script>
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
</script>