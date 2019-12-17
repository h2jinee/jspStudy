<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, member.model.vo.*" %>
<%
	List<Member> list = (List<Member>)request.getAttribute("list");
%>
<members>
<%
	if(list!=null && !list.isEmpty()){
		for(Member m : list){
%>
	<member>
		<name><%=m.getName()%></name>
		<phone><%=m.getPhone()%></phone>
		<profile><%=m.getProfile()%></profile>
	</member>
<%
		}
	}
%>
</members>