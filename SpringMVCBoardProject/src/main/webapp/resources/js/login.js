/**
 * login.jsp 
 */


/* icheck */
$(document).ready(function() {
	$("input").iCheck({
		checkboxClass : "icheckbox_flat-blue",
		radioClass : "iradio_flat-blue"
	});
});



if(result == "fail") {
	alert("ID or password do not match");
	//self.location = "/user/login";
	history.go(-1);
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

