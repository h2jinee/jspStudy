<%--page 지시어 directive --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Arrays"%>
<%-- <%@ page import="java.util.Arrays" --%>
<%
	//자바 공간
	/*
		동일한 주석 사용가능
	*/
	//내장객체변수 request, response를 선언없이 사용가능.
	//request: doGet메소드의 첫번째 인자 HttpServletRequest객체
	//response: doGet메소드의 첫번째 인자 HttpServletResponse객체
	String name = request.getParameter("name");
	String color = request.getParameter("color");
	String animal = request.getParameter("animal");
	String[] foodArr = request.getParameterValues("food");
	
	String recommendation = (String)request.getAttribute("recommendation");
	
	System.out.println("name@jsp="+name);
	System.out.println("color@jsp="+color);
	System.out.println("animal@jsp="+animal);
	System.out.println("foodaArr@jsp="+Arrays.toString(foodArr));
	System.out.println("recommendation@jsp="+recommendation);
	
	//request객체에 속성으로 저장된 recommendation의 값 가져오기
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title> 개인취향 테스트 결과 페이지 </title>
<style>
h2{color:red;}
span.name{color:lightblue;}
span.color{color:lightgreen;}
span.animal{color:lightsalmon;}
span.food{color:lightseagreen;}
</style>
</head>
<body>
<h2>개인 취향 테스트 결과페이지(POST-Jsp)</h2>
<span class='name'><% out.print(name); %></span>님의 개인취향은
<span class='color'><% out.print(color); %></span>색을 좋아하고
<span class='animal'><%=animal %><%-- out.print의 인자로 전달되므로 ;을 찍지 않는다. --%></span>을 좋아합니다.
좋아하는 음식은 <span class='food'><%=Arrays.toString(foodArr) %></span>입니다.
<hr />
<!-- html주석 : recommendation입니다. -->
<%-- jsp주석: recommendation입니다. --%>
오늘 <span style="font-size:50px;"><%=recommendation %></span> 어떠세요?
</body>
</html>
