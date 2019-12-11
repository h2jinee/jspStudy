<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.model.vo.Board, java.util.List" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Board b = (Board)request.getAttribute("board");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<section id="board-container">
<h2>게시판</h2>
<table id="tbl-board-view">
	<tr>
		<th>글번호</th>
		<td><%=b.getBoardNo() %></td>
	</tr>
	<tr>
		<th>제 목</th>
		<td><%=b.getBoardTitle() %></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><%=b.getBoardWriter() %></td>
	</tr>
	<tr>
		<th>조회수</th>
		<td><%=b.getReadCount() %></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>
		<% if(b.getOriginalFileName() != null){ %>
			<a href="javascript:fileDownLoad('<%=b.getOriginalFileName()%>','<%=b.getRenamedFileName()%>');">
			<img alt="첨부파일" src="<%=request.getContextPath() %>/images/file.png" width=16px><%= b.getOriginalFileName() %>
			</a>
		<% }%>
		</td>
	</tr>
	<tr>
		<th>내 용</th>
		<td><%=b.getBoardContent()%></td>
	</tr>
	<%--글작성자/관리자인경우 게시글 수정삭제버튼 보일수 있게 함 --%>
	<% if(memberLoggedIn!=null && 
		(b.getBoardWriter().equals(memberLoggedIn.getMemberId())
		|| "admin".equals(memberLoggedIn.getMemberId())) ){ %>
	<tr>
		<th colspan="2">
			<input type="button" value="수정하기" onclick="fn_updateBoard()">
			<input type="button" value="삭제하기" onclick="fn_deleteBoard()">
		</th>
	</tr>
	
	<%} %>	
</table>
</section>
<script>
function fileDownLoad(oName, rName){
	//ie대비 한글인코딩 명시적 처리
	oName = encodeURIComponent(oName);
	console.log(oName);
	
	location.href = "<%=request.getContextPath()%>/board/fileDownload?oName="+oName+"&rName="+rName;
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
