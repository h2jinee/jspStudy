<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="board.model.vo.Board" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%

	List<Board> list = (List<Board>)request.getAttribute("list");
	String pageBar = (String)request.getAttribute("pageBar");
	
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<section id="board-container">
	<h2>게시판 </h2>
	<!-- 로그인 한 경우에만 글쓰기 버튼 보이기 -->
	<% if(memberLoggedIn != null){ %>
	<input type="button" value="글쓰기" id="btn-add" onclick="location.href='<%=request.getContextPath() %>/board/boardForm';" />
	<%  }	%>
	<table id="tbl-board">
	  <thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th><%--첨부파일이 있는 경우, /images/file.png 표시 width:16px --%>
			<th>조회수</th>
		</tr>
	  </thead>
	  <tbody>
		<% if(list==null || list.isEmpty()){ %>
            <tr>
                <td colspan="9" align="center"> 검색 결과가 없습니다. </td>
            </tr>
        <% 
            } 
            else {
            	for(Board b : list){ 
        %>
            <tr>
            	<td><%=b.getBoardNo()%></td>
                <td>
                	<a href="<%=request.getContextPath()%>/board/boardView?boardNo=<%=b.getBoardNo()%>">
                		<%=b.getBoardTitle()%>
                	</a>
                </td>
                <td><%=b.getBoardWriter()%></td>
                <td><%=b.getBoardDate()%></td>
                <td>
                	<% if(b.getOriginalFileName() != null){ %>
                	<img alt="첨부파일" src="<%=request.getContextPath() %>/images/file.png" width="16px" />
                	<% } %>
                </td>
                <td><%=b.getReadCount()%></td>		
            </tr>		
        <%		} 
            }
        %>
		
		</tbody>
	</table>

	<div id='pageBar'>
		<%=pageBar %>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
