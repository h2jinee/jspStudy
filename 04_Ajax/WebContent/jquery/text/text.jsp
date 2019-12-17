<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax::jquery::text</title>
<script src="<%=request.getContextPath()%>/jquery/jquery-3.4.1.js"></script>
<style>
#mydiv{
	width: 300px;
	min-height: 100px;
	border: 1px solid red;
	margin: 30px 10px;
}
</style>
<script>
$(function(){
	console.log("jquery loaded!!!!!!!!!!!!!!!!");
	$('#btn1').click(function(){
		$.ajax({
			url: "sample.txt", //상대주소는 현재주소기준으로 작성된다. http://localhost:9090/ajax/jquery/text/text/sample.jsp
			type: "GET", //기본값은 GET
			dataType: "text", //text, html, script, xml, json 생략하면 서버 응답메세지에 따라 결정(생략해도 무방하다는 뜻)
			beforeSend: function(){
				console.log("beforeSend: </before>ajax send 전처리 함수!!")
			},
			success: function(data){
				console.log("success: ajax처리 성공!");
				console.log(data);
				
				//$("#mydiv").text(data);
				$("#mydiv").html(data);
			},
			error: function(jqxhr, textStatus, errorThrown){
				console.log("error: ajax처리 실패!");
				console.log(jqxhr, textStatus, errorThrown);
			},
			complete: function(){
				console.log("complete: ajax처리 완료!");
			}
		});
	});
});
</script>
</head>
<body>
	<h1>ajax::jquery::text</h1>
	<button id="btn1">sample.txt ajax로 요청하기</button>
	<div id="mydiv"></div>
</body>
</html>