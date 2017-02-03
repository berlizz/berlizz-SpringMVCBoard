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
							<button type="button" class="btn btn-danger">Cancel</button>
						</div>
					</form>
					
					
				</div>
			</div>
		</div>
	</div>
</section>




<!-- 파일업로드 창 처리 -->
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
<!-- 파일 업로드 처리 handlebars template -->
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

<!-- register.js -->
<script src="/resources/js/register.js"></script>

 
 
 <%@ include file="../include/footer.jsp" %>