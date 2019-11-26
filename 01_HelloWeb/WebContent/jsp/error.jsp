<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%-- 지시어의 속성 isErrorPage="true"를 지정하면 해당페이지에서는 exception객체에 선언없이 접근할 수 있다. --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Custom Error Page</title>
<style>
h1 {
	color: red;
	font-size: 200px;
	margin: 0 auto;
	text-align: center;
}
</style>
</head>
<body>
	<h1>오류: <%=exception.getMessage() %></h1>
</body>
</html>