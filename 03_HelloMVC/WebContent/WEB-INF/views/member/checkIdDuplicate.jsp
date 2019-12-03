<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boolean isUsable = (boolean)request.getAttribute("isUsable");
	String memberId = request.getParameter("memberId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 검사</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
<style>
#checkId-container{
	text-align: center;
	padding-top: 50px;
}
span#duplicated {
	color: red;
	font-weight: bold;
	
}
</style>
</head>
<body>
	<div id="checkId-container">
	<% if(isUsable) { %>
		[<span><%=memberId %></span>]는 사용가능합니다.
		<br /><br />
		<button type="button" onclick="self.close();">사용</button>
	<% }
		else {
	%>
		[<span id="duplicated"><%=memberId %></span>]는 이미 사용 중입니다.
		<br /><br />
		
		<form action="<%=request.getContextPath()%>/member/checkIdDuplicate" name="checkIdDuplicateFrm" method="post">
		<input type="text" name="memberId" id="memberId" placeholder="아이디를 입력하세요."/>
		&nbsp;&nbsp;
		<input type="button" value="아이디 중복 검사" />
		
		</form>
	<%
		}
	%>
	</div>
</body>
</html>