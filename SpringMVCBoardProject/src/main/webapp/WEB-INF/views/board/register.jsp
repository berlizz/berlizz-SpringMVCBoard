<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="../include/header.jsp" %>


<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					
					<h3 class="box-title">REGISTER BOARD</h3>
					
					
					<form role="form" id="registerForm" method="post">
						<div class="box-body">
							<div class="form-group">
								<label for="exampleInputEmail1">Title</label>
								<input type="text" name="title" class="form-control" placeholder="Enter Title">
							</div>
							<div class="form-gorup">
								<label for="exampleInputEmail1">Content</label>
								<textarea class="form-control" name="content" rows="3" placeholder="Enter Content"></textarea>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Writer</label>
								<input type="text" name="writer" class="form-control" value="${login.username}" readonly style="cursor:default">
							</div>
							
							<div class="form-group">
								<label for="exampleInputEmail1">File Drop Here</label>
								<div class="fileDrop"></div>
							</div>
						</div>	
						
						<div class="box-footer">
							<div>
								<hr>
							</div>
							
							<ul class="mailbox-attachments clearfix uploadedList">
							</ul>
						
							<button type="submit" class="btn btn-primary">Submit</button>
						</div>
					</form>
					
					
				</div>
			</div>
		</div>
	</div>
</section>


<%@ include file="../include/footer.jsp" %>


<style>
	.fileDrop {
		width : 80%;
		height : 100px;
		border : 1px dotted gray;
		background-color : lightslategrey;
		margin : auto;
	}
</style>

<!-- font awesome -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- handlebars.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.6/handlebars.min.js"></script>
<!-- handlebars template -->
<script id="template" type="text/x-handlebars-template">
<li>
	<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
	<div class="mailbox-attachment-info">
		<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
		<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
	</div>
</li>
</script>

<!-- 파일 업로드 화면처리 -->
<script src="/resources/js/upload.js"></script>
<script>
	var template = Handlebars.compile($("#template").html());
	
	$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop", function(event) {
		event.preventDefault();
		
		var files = event.originalEvent.dataTransfer.files;
		
		var file = files[0];
		
		var formData = new FormData();
		formData.append("file", file);
		
		$.ajax({
			url : "/upload/uploadAjax",
			data : formData,
			dataType : "text",
			processData : false,
			contentType : false,
			type : "post",
			success : function(data) {
				var fileInfo = getFileInfo(data);
				var html = template(fileInfo);
				
				$(".uploadedList").append(html);
			}
		});
	});
	
	$(".uploadedList").on("click", ".delbtn", function(event) {
		event.preventDefault();

		var that = $(this)
		
		$.ajax({
			url : "/upload/deleteFile",
			data : {
				fileName : that.attr("href")
			},
			dataType : "text",
			type : "post",
			success : function(data) {
				if(data == "deleted") {
					that.closest("li").remove();
					alert("첨부파일이 삭제 되었습니다.");
				}
			}
		});
	});
	
</script>

<!-- form 태그 submit 처리 -->
<script>
	$("#registerForm").submit(function(event) {
		event.preventDefault();
		
		var that = $(this);
		var str = "";
		
		$(".uploadedList .delbtn").each(function(index) {
			str += "<input type='hidden' name='files[" + index + "]' value='" + $(this).attr("href") + "'>";
		});
		
		that.append(str);
		that.get(0).submit();
	});
</script>
