<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, member.model.vo.Member" %>
<%
	List<Member> list = (List<Member>)request.getAttribute("list");
%>
<table id="tbl-member">
	<tr>
		<th>프로필</th>
		<th>이름</th>
		<th>전화번호</th>
	</tr>
	<% if(list != null && !list.isEmpty()) {
			for(Member m : list){
	%>
		<tr>
			<td>
				<img src="<%=request.getContextPath() %>/images/<%=m.getProfile() %>" alt="" />
			</td>
			<td><%=m.getName() %></td>
			<td><%=m.getPhone() %></td>
		</tr>
		
	<% 
			}
		}
	%>
</table>