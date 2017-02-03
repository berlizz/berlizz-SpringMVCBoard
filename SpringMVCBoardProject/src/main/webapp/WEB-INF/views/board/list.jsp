<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp" %>


<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<div>
						<h3 class="box-title">LIST PAGE</h3>
					</div>
					
					<div class="text-right">				
						<c:if test="${login.username != null}">
							<div class="btn-group">
								<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
									<i class="fa fa-user-circle" aria-hidden="true"></i> ${login.username} 
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu" role="menu">
									<li><a href="/">Home</a></li>
									<li class="divider"></li>
									<li><a href="/user/logout" role="menuitem">Sign out</a></li>
								</ul>
							</div>
						</c:if>
					</div>
				
				</div>
					
				
				<div class="box-body">
					<div class="form-inline">
						<select name="searchType" id="searchType" class="form-control">
							<option value="n"
								<c:out value="${cri.searchType == null? 'selected' : ''}" />>Search Type</option>
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
						
						<input type="text" name="keyword" id="keywordInput" class="form-control" placeholder="Search Keyword" value="${cri.keyword}">
						<button id="searchBtn" class="btn btn-primary">Search</button>
						<button id="newBtn" class="btn btn-primary">New Board</button>	
					</div>
						
					<table class="table table-hover table-bordered">
						<!-- <tr>
							<th style="width: 10px">BNO</th>
							<th>TITLE</th>
							<th style="width: 150px">WRITER</th>
							<th style="width: 150px">REGDATE</th>
							<th style="width: 40px">VIEWCNT</th>
						</tr> -->
						<tr>
							<th class="col-xs-1">BNO</th>
							<th class="col-xs-6">TITLE</th>
							<th class="col-xs-2">WRITER</th>
							<th class="col-xs-2">REGDATE</th>
							<th class="col-xs-1">VIEWCNT</th>
						</tr>
						<c:forEach items="${list}" var="boardVO">
							<tr>
								<td>${boardVO.bno}</td>
								<td><a href="/board/read${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${boardVO.bno}">${boardVO.title}
									<strong>[ ${boardVO.replycnt} ]</strong></a></td>
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
								<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">&laquo;</a></li>
							</c:if>
							
							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
								<li 
									<c:out value="${pageMaker.cri.page == idx ? 'class = active' : ''}" />>
									<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
								</li>
							</c:forEach>
							
							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">&raquo;</a></li>
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
		alert("Completed");
	}
	
	var makeQuery = "${pageMaker.makeQuery(1)}";
</script>

<!-- list.js -->
<script src="/resources/js/list.js"></script>

<!-- <script>
	$(document).ready(function() {
		$(".dropdown-toggle").dropdown();
		
		$("#searchBtn").on("click", function() {
			if($("#searchType").val() == "n") {
				alert("Select Search Type");
				$("#searchType").focus();
				
				return;
				
			} else if($("#keywordInput").val() == "") {
				alert("Input search keyword");
				$("#keywordInput").focus();
				
				return;
				
			} else {
				self.location = "list${pageMaker.makeQuery(1)}&searchType="
					+ $("select option:selected").val() 
					+ "&keyword="
					+ $("#keywordInput").val();	
			}
		});
		
		$("#newBtn").on("click", function() {
			self.location = "/board/register";
		});
	});
	
</script> -->
