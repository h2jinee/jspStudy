<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/jsp/error.jsp"%>
<%
	//스클립틀릿 scriptlet
	//servlet클래스의 _jspService()메소드 몸통으로 이동함.
	int total = 0;
	for(int i=1; i<=10; i++)
		total += i;
	
	//오류유발
	//String s = null;
	//System.out.println(s.charAt(0));
	
	if(true)
		throw new RuntimeException("01_sum.jsp 처리도중 예외 발생!!");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1부터 10까지 합 구하기</title>
</head>
<body>
	<<h1>1부터 10까지 합 구하기</h1>
	<ul>
		<li>scriptlet: <% out.print(total); %></li>
		<li>expression: <%= total %></li>
		<li>javascript: <span id="total"></span></li>
	</ul>
<script>
(()=>{
	var sum = 0;
	for(var i=1; i<=10; i++)
		sum += i;
	document.querySelector("#total").innerText = sum;
	
})();
</script>	
</body>
</html>