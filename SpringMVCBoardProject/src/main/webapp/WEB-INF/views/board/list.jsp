<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp" %>


<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					
					<h3 class="box-title">LIST PAGE</h3>
					
				</div>
					
				
				<div class="box-body">
				
					<select name="searchType">
						<option value="n"
							<c:out value="${cri.searchType == null? 'selected' : ''}" />>---</option>
						<option value="t"
							<c:out value="${cri.searchType eq 't'? 'selected' : ''}" />>Title</option>
						<option value="w"
							<c:out value="${cri.searchType eq 'w'? 'selected' : ''}" />>Writer</option>
						<option value="c"
							<c:out value="${cri.searchType eq 'c'? 'selected' : ''}" />>Content</option>
						<option value="tc"
							<c:out value="${cri.searchType eq 'tc'? 'selected' : ''}" />>Title Or Content</option>
						<option value="cw"
							<c:out value="${cri.searchType eq 'cw'? 'selected' : ''}" />>Content Or Writer</option>
						<option value="tcw"
							<c:out value="${cri.searchType eq 'tcw'? 'selected' : ''}" />>Title Or Content Or Writer</option>
					</select>
					
					<input type="text" name="keyword" id="keywordInput" value="${cri.keyword}">
					<button id="searchBtn">Search</button>
					<button id="newBtn">New Board</button>
					
					<table class="table table-bordered">
						<tr>
							<th style="width: 10px">BNO</th>
							<th>TITLE</th>
							<th>WRITER</th>
							<th>REGDATE</th>
							<th style="width: 40px">VIEWCNT</th>
						</tr>
						<c:forEach items="${list}" var="boardVO">
							<tr>
								<td>${boardVO.bno}</td>
								<td><a href="/board/read${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${boardVO.bno}">${boardVO.title}</a></td>
								<td>${boardVO.writer}</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate}" /></td>
								<td>${boardVO.viewcnt}</td>
							</tr>
						</c:forEach>
					</table>
				
				</div>
				
					
				<div class="box-footer">
				
					<div class="text-center">
						<ul class="pagination">
							<c:if test="${pageMaker.prev}">
								<li><a href="list?page=${pageMaker.startPage - 1}&perPageNum=${pageMaker.cri.perPageNum}">&laquo;</a></li>
							</c:if>
							
							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
								<li 
									<c:out value="${pageMaker.cri.page == idx ? 'class = active' : ''}" />>
									<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
								</li>
							</c:forEach>
							
							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a href="list?page=${pageMaker.endPage + 1}&perPageNum=${pageMaker.cri.perPageNum}">&raquo;</a></li>
							</c:if>
						</ul>
					</div>
				
				</div>
					
					
			</div>
		</div>
	</div>
</section>


<%@ include file="../include/footer.jsp" %>

<script>
	var result = "${result}";
	
	if(result == "success") {
		alert("처리가 완료 되었습니다.");
	}
</script>

<script>
	$(document).ready(function() {
		
		$("#searchBtn").on("click", function() {
			self.location = "list${pageMaker.makeQuery(1)}&searchType="
				+ $("select option:selected").val() 
				+ "&keyword="
				+ $("#keywordInput").val();
		});
	});
</script>
