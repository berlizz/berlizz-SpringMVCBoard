<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="../include/header.jsp" %>


<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				
				<div class="box-header with-border">
					
					<h3 class="box-title">LOGIN PAGE</h3>
					
				</div>
				
				
				<div class="box-body with-border">
					
					<form action="/user/loginPost" method="post">
						<div class="form-group has-feedback">
							<input type="text" name="userid" class="form-control" placeholder="User ID">
							<span class="glyphicon glyphicon-user form-control-feedback"></span>
						</div>
						<div class="form-group has-feedback">
							<input type="password" name="userpw" class="form-control" placeholder="Password">
							<span class="glyphicon glyphicon-lock form-control-feedback"></span>
						</div>
						<div class="form-group">
							<div class="col-xs-8">
								<div class="checkbox icheck">
									<label>
										<input type="checkbox" name="useCookie"> Remember Me
									</label>
								</div>
							</div>
							<div class="col-xs-4">
								<button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
							</div>
						</div>
					</form>
					
				</div>
				
				
				<div class="box-footer with-border">
				</div>
				
				
			</div>
		</div>
	</div>
</section>


<%@ include file="../include/footer.jsp" %>
