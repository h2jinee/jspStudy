<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	//자바 공간
	String main_menu = request.getParameter("main_menu");
	String side_menu = request.getParameter("side_menu");
	String drink_menu = request.getParameter("drink_menu");
	
	int main_menuTotal = (int)request.getAttribute("main_menuTotal");
	int side_menuTotal = (int)request.getAttribute("side_menuTotal");
	int drink_menuTotal = (int)request.getAttribute("drink_menuTotal");
	
	int total = main_menuTotal+side_menuTotal+drink_menuTotal;
	
	System.out.println("main_menu@jsp="+main_menu);
	System.out.println("side_menu@jsp="+side_menu);
	System.out.println("drink_menu@jsp="+drink_menu);
	System.out.println("total@jsp="+total);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 선택 결과페이지(GET)</title>
<style>
span.main_menu{
	font-size: 30px;
	color: navy;
}
span.side_menu{
	font-size: 23px;
	color: darkmagenta;
}
span.drink_menu{
	font-size: 14px;
	color: lightgreen;
}
span.total{
	font-size: 30px;
	color: darkred;
}

</style>
</head>
<body>
	<h2>감사합니다.</h2>
	<span class='main_menu'><% out.print(main_menu); %></span>,<span class="side_menu"><% out.print(side_menu); %></span>,<span class="drink_menu"><% out.print(drink_menu); %></span>
	을/를 주문하셨습니다.<br>
	총 결제금액은 <span class="total"><%=total %>원</span>입니다.

</body>
</html>