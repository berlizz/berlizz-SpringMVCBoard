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
							<input type="text" name="writer" class="form-control" value="${boardVO.writer}" readonly style="cursor:default">
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


<!-- modify.js -->
<script src="/resources/js/modify.js"></script>
<script>
	var page = ${cri.page};
	var perPageNum = ${cri.perPageNum};
	var searchType = "${cri.searchType}";
	var keyword = "${cri.keyword}";
</script>


<%@ include file="../include/footer.jsp" %>