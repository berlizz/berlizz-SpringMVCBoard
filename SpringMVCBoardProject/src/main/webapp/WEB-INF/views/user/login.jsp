<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="../include/header.jsp" %>




<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="login-box">
				
				<div class="login-box-header with-border">
					
					<h3 class="login-box-title">SIGN IN PAGE</h3>
					
				</div>
				
				
				<div class="login-box-body with-border">
					<p class="login-box-message">Sign in your session</p>
					
					<form action="/user/loginPost" method="post">
						<div class="form-group has-feedback">
							<input type="text" id="userid"name="userid" class="form-control" placeholder="User ID">
							<span class="glyphicon glyphicon-user form-control-feedback"></span>
						</div>
						<div class="form-group has-feedback">
							<input type="password" id="userpw" name="userpw" class="form-control" placeholder="Password">
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
								<button type="submit" id="signinBtn" class="btn btn-primary btn-block btn-flat">Sign In</button>
							</div>
						</div>
					</form>
					
				</div>
				
				
				<div class="login-box-footer with-border">
				</div>
				
				
			</div>
		</div>
	</div>
</section>


<%@ include file="../include/footer.jsp" %>


<!-- iCheck -->
<script src="/resources/icheck/icheck.min.js" type="text/javascript"></script>
<link href="/resources/icheck/blue.css" rel="stylesheet" type="text/css" />
<script>
/* icheck */
$(document).ready(function() {
	$("input").iCheck({
		checkboxClass : "icheckbox_flat-blue",
		radioClass : "iradio_flat-blue"
	});
});

</script>

<script>
	var result = "${result}";

	if(result == "fail") {
		alert("ID or password do not match");
	}	
	
	$("#signinBtn").on("click", function(event) {
		if($("#userid").val() == "") {
			alert("Input ID");
			$("#userid").focus();
			event.preventDefault();
			
			return;
		}
		
		if($("#userpw").val() == "") {
			alert("Input password");
			$("#userpw").focus();
			event.preventDefault();
			
			return;
		}
	});
</script>
