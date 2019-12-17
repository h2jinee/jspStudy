<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax::jquery::html</title>
<script src="<%=request.getContextPath()%>/jquery/jquery-3.4.1.js"></script>
<style>
div#mydiv{
	padding: 10px;
}
table#tbl-member{border:1px solid; border-collapse:collapse;}
#tbl-member th, #tbl-member td{border:1px solid; padding:10px;}
#tbl-member img{width:100px; }
</style>
<script>
$(function(){
	
	$("#btn").click(function(){
		$.ajax({
			url: "<%=request.getContextPath()%>/jquery/html",
			type: "get",
			dataType: "html",
			success: function(data){
				console.log(data);
				$("#mydiv").html(data);
			},
			error: function(jqxhr, textStatuc, errorThrown){
				console.log("ajax처리실패!", jqxhr, textStatuc, errorThrown);
			}
		});
	});
});
</script>
</head>
	<h1>ajax::jquery::html</h1>
	<button id="btn">실행</button>
	<div id="mydiv"></div>
<body>

</body>
</html>