<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax::jquery::csv</title>
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
	$("#btn").on("click", function(){
		$.ajax({
			url: "<%=request.getContextPath()%>/jquery/csv",
			dataType: "text",
			success: function(data){
				console.log(data);
				/*
					박보검,01012341234,parkBogum.jpg
					쥴리아 로버츠,01012345678,juliaRoberts.jpg
					맷 데이먼,01098765432,mattDamon.jpg
				*/
				
				var memberArr = data.split("\n");
				var $table = $("<table></table>").attr("id","tbl-member");
				
				$.each(memberArr, (idx, val)=>{
					var member = val.split(",");
					var html = "<tr>";
					html += "<td><img src='<%=request.getContextPath()%>/images/"+member[2]+"'/></td>"
					html += "<td>"+member[0]+"</td>";
					html += "<td>"+member[1]+"</td>";
					html += "</tr>";
					$table.append(html);
				});
				
				$("#mydiv").html($table);
			},
			error: function(jqxhr, textStatus, errorThrown){
				console.log("ajax처리실패!", jqxhr, textStatus, errorThrown);
			}
		});
	});
});
</script>
</head>
<body>
	<h1>ajax::jquery::csv</h1>
	<button id="btn">실행</button>
	<div id="mydiv"></div>
</body>
</html>