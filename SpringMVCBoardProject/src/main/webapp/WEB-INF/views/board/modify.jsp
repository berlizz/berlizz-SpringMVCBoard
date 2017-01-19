<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="../include/header.jsp" %>


<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					
					<h3 class="box-title">MODIFY BOARD</h3>
					
				</div>
					
					
				<form role="form" method="post">
				
					<input type="hidden" name="page" value="${cri.page}">
					<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
					<%-- <input type="hidden" name="searchType" value="${cri.searchType}">
					<input type="hidden" name="keyword" value="${cri.keyword}"> --%>
					
					<div class="box-body">
						<div class="form-group">
							<label for="exampleInputEmail1">Bno</label>
							<input type="text" name="bno" class="form-control" value="${boardVO.bno}" readonly style="cursor:default">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Title</label>
							<input type="text" name="title" class="form-control" value="${boardVO.title}">
						</div>
						<div class="form-gorup">
							<label for="exampleInputEmail1">Content</label>
							<textarea class="form-control" name="content" rows="3">${boardVO.content}</textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label>
							<input type="text" name="writer" class="form-control" value="${boardVO.writer}">
						</div>
					</div>	
				</form>
					
					
				<div class="box-footer">
					<button type="submit" class="btn btn-primary">Save</button>
					<button type="submit" class="btn btn-warning">Cancel</button>
				</div>
					
					
			</div>
		</div>
	</div>
</section>


<%@ include file="../include/footer.jsp" %>

<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");
				
		$(".btn-primary").on("click", function() {
			formObj.submit();
		});
		
		$(".btn-warning").on("click", function() {
			self.location = "/board/list?page=${cri.page}&perPageNum=${cri.perPageNum}"
								+ "&searchType=${cri.searchType}&keyword=${cri.keyword}";
		});
	});
</script>
