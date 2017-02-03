/**
 * register.jsp
 */

// 파일 업로드 화면 처리
var template = Handlebars.compile($("#template").html());

$(".fileDrop").on("dragenter dragover", function(event) {
	event.preventDefault();
});

$(".fileDrop").on("drop", function(event) {
	event.preventDefault();
	
	var files = event.originalEvent.dataTransfer.files;
	
	var file = files[0];
	
	var formData = new FormData();
	formData.append("file", file);
	
	$.ajax({
		url : "/upload/uploadAjax",
		data : formData,
		dataType : "text",
		processData : false,
		contentType : false,
		type : "post",
		success : function(data) {
			var fileInfo = getFileInfo(data);
			var html = template(fileInfo);
			
			$(".uploadedList").append(html);
		}
	});
});

$(".uploadedList").on("click", ".delbtn", function(event) {
	event.preventDefault();

	var that = $(this)
	
	$.ajax({
		url : "/upload/deleteFile",
		data : {
			fileName : that.attr("href")
		},
		dataType : "text",
		type : "post",
		success : function(data) {
			if(data == "deleted") {
				that.closest("li").remove();
				alert("첨부파일이 삭제 되었습니다.");
			}
		}
	});
});



// form 태그 submit 처리 
$("#registerForm").submit(function(event) {
event.preventDefault();

var that = $(this);
var str = "";

$(".uploadedList .delbtn").each(function(index) {
	str += "<input type='hidden' name='files[" + index + "]' value='" + $(this).attr("href") + "'>";
	});
	
	that.append(str);
	that.get(0).submit();
});

$(".btn-danger").on("click", function() {
	self.location = "/board/list";
});

