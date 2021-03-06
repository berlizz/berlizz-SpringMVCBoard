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
					
					<c:if test="${login.username == boardVO.writer}">
						<button type="submit" class="btn btn-warning">Modify</button>
						<button type="submit" class="btn btn-danger" id="readPageDelBtn">Remove</button>
					</c:if>
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
				
				<c:if test="${not empty login}">
					<div class="box-body">
						<label for="newReplyWriter">Writer</label>
						<input type="text" class="form-control" id="newReplyWriter" value="${login.username}" readonly style="cursor:default">
						<label for="newReplyText">ReplyText</label>
						<input type="text" class="form-control" placeholder="Reply Text" id="newReplyText">
					</div>
						
					<div class="box-footer">
						<button type="submit" class="btn btn-primary" id="replyAddBtn">Add Reply</button>
					</div>
				</c:if>
				<c:if test="${empty login}">
					<div class="box-body">
						<div><a href="javascript:goLogin();">Sign up</a></div>
					</div>
				</c:if>
				
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


<!-- font awesome -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- handlebars.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.6/handlebars.min.js"></script>

<!-- reply list 처리 handlebars template -->
<script id="template" type="text/x-handlebars-template">
	{{#each .}}
	<li class="replyLi" data-rno={{rno}}>
		<i class="fa fa-comment-o bg-green"></i>
		<div class="timeline-item">
			<span class="time"><i class="fa fa-clock-o"></i>{{prettifyDate regdate}}</span>
			<h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
			<div class="timeline-body">{{replytext}}</div>
			<div class="timeline-footer">
			{{#eqReplyer replyer}}
				<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
			{{/eqReplyer}}
			</div>
		</div>
	</li>
	{{/each}}
</script>

<!-- 첨부파일 화면처리 handlebars template -->
<script id="templateAttach" type="text/x-handlebars-template">
	<li data-src="{{fullName}}">
		<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
		<div class="mailbox-attachment-info">
			<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
		</div>
	</li>
</script>

<!-- upload.js -->
<script src="/resources/js/upload.js"></script>
<script>
var bno = ${boardVO.bno};
var replyPage = 1;
var userName = "${login.username}";
</script>

<!-- read.js -->
<script src="/resources/js/read.js"></script>

<!-- 이미지팝업 css처리 -->
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



<%@ include file="../include/footer.jsp" %>
