<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.Date" %>
<%
	Date now = new Date();
	String today = String.format("%tY년%tm월%td일%tA", now, now, now, now);
	
	/*
	
	날짜  타입  format  ||               설명
	------------------------------------------------
	%tF                              날짜를 yyyy-mm-dd 형식으로 포맷
	%tT                         날짜의 시각을 HH:MM:SS 형식으로 포맷.
	------------------------------------------------------
	%tY                         4자리 년도만 출력 
	%ty                         2자리 년도
	%tB                         월의 이름(January, February, March...)
	%tm                         월을 01,02,03 ~12 로 출력
	%td                         일수를 1~31 로 출력
	%te                         %td 와 같음.
	%tA                         요일명 출력
	---------------------------------------------------
	%tp                         오전, 오후를 출력
	%tk                         시간을 0~23 으로 출력.
	%tl                         시간을 1~12 로 출력.
	%tM                         분을 00 ~59 로 출력.
	%tS                         초를 00 ~ 59 로 출력.
	-----------------------------------------------------
	%tZ                         타임존을 출력 (한국은 KST)
	---------------------------------------------------
	
	*/
%>

<%=today %>