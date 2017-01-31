<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="include/header.jsp" %>

	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title">SpringMVCBoard</h3>
					</div>
					
					
					<div class="box-body with-border">
						<div class="col-xs-4 col-xs-offset-4">
							<div class="list-group">
								<a href="/board/list" class="list-group-item">
									<i class="fa fa-list-alt fa-2x" aria-hidden="true"></i>&nbsp; Board List Page</a>
								<a href="/user/login" class="list-group-item">
									<i class="fa fa-sign-in fa-2x"  aria-hidden="true"></i>&nbsp; Sign In Page</a>
								<a href="http://github.com/berlizz/berlizz-springmvcboard" class="list-group-item">
									<i class="fa fa-github fa-2x" aria-hidden="true"></i>&nbsp; Github</a>
							</div>
						</div>
					</div>
					
					
					<div class="box-footer with-border">
					</div>
					
					
				</div>
			</div>
		</div>
	</section>

<%@ include file="include/footer.jsp" %>