/**
 * list.jsp 
 */



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
			self.location = "list" + makeQuery
				+ "&searchType="
				+ $("select option:selected").val() 
				+ "&keyword="
				+ $("#keywordInput").val(); 
		}
	});
	
	$("#newBtn").on("click", function() {
		self.location = "/board/register";
	});
});