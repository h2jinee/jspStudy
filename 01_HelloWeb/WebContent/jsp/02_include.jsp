<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>include테스트</title>
<style>
.today{
	font-size: 36px;
	color: hotpink;
}
</style>
</head>
<body>
	<h1>오늘의 날짜</h1>
	<%-- <span class="today"><%= today %></span>입니다. --%>
	<span class="today"><%@ include file="today.jsp" %></span>
	
</body>
</html>