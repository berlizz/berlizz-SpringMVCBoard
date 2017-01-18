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
								<td><a href="/board/read${pageMaker.makeQuery(pageMaker.cri.page)}&bno=${boardVO.bno}">${boardVO.title}</a></td>
								<td>${boardVO.writer}</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate}" /></td>
								<td>${boardVO.viewcnt}</td>
							</tr>
						</c:forEach>
					</table>
					
					<div class="box-footer">
						<div class="text-center">
							<ul class="pagination">
								<c:if test="${pageMaker.prev}">
									<li><a href="listPage?page=${pageMaker.startPage - 1}">&laquo;</a></li>
								</c:if>
								
								<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
									<li 
										<c:out value="${pageMaker.cri.page == idx ? 'class = active' : ''}" />>
										<a href="listPage${pageMaker.makeQuery(idx)}">${idx}</a>
									</li>
								</c:forEach>
								
								<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<li><a href="listPage?page=${pageMaker.endPage + 1}">&raquo;</a></li>
								</c:if>
							</ul>
						</div>
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
