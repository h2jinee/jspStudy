<%@page import="board.model.vo.BoardComment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.model.vo.Board, java.util.List" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Board b = (Board)request.getAttribute("board");
	List<BoardComment> commentList 
		= (List<BoardComment>)request.getAttribute("commentList");
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
			<a href="javascript:fileDownload('<%=b.getOriginalFileName()%>','<%=b.getRenamedFileName()%>');">
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
			<input type="button" value="수정하기" onclick="updateBoard()">
			<input type="button" value="삭제하기" onclick="deleteBoard()">
		</th>
	</tr>
	<form name="boardDelFrm" action="<%=request.getContextPath()%>/board/boardDelete" method="post">
	    <input type="hidden" name="boardNo" value="<%=b.getBoardNo() %>" />
	    <input type="hidden" name="renamedFileName" value="<%=b.getRenamedFileName()!=null?b.getRenamedFileName():"" %>" />
    </form>
	
	<script>
	function updateBoard(){
		location.href = "<%=request.getContextPath()%>/board/boardUpdateForm?boardNo=<%=b.getBoardNo()%>";	
	}
   	function deleteBoard(){
        if(!confirm('이 게시글을 정말 삭제하시겠습니까?')) return;
        $("[name=boardDelFrm]").submit();
    }

	
	</script>
	
	<%} %>	
</table>

<hr style="margin-top:30px;"/>

<div class="comment-container">
	<div class="comment-editor">
		<form action="<%=request.getContextPath()%>/board/boardCommentInsert"
			  method="post"
			  name="boardCommentFrm">
			  <input type="hidden" name="boardRef" 
			  		 value="<%=b.getBoardNo() %>" />
			  <input type="hidden" name="boardCommentWriter"
			  		 value="<%=memberLoggedIn!=null?memberLoggedIn.getMemberId():"" %>" />
			  <input type="hidden" name="boardCommentLevel" value="1" />
			  <input type="hidden" name="boardCommentRef" value="0" />
			  
			  <textarea name="boardCommentContent" cols="60" rows="3"></textarea>
			  <input type="submit" id="btn-insert" value="등록" />
		
		</form>
	</div>	
	
	<!-- 댓글목록테이블 -->
	<table id="tbl-comment">
	<%
		if(commentList != null && !commentList.isEmpty()){
			for(BoardComment bc : commentList){
				//1.댓글인 경우
				if(bc.getBoardCommentLevel() == 1){
	%>
		<tr class="level1">
			<td>
				<sub class="comment-writer"><%=bc.getBoardCommentWriter() %></sub>
				<sub class="comment-date"><%=bc.getBoardCommentDate() %></sub>
				<br />
				<%=bc.getBoardCommentContent() %>
			</td>
			<td>
				<button class="btn-reply"
						value="<%=bc.getBoardCommentNo()%>">답글</button>
				
				<!-- @실습문제: 글쓴 본인 혹은 관리자에게만 노출시킬것 -->
				<!-- /board/boardCommentDelete -->
				<!-- 삭제후, 삭제성공 메세지를 보여준후 현재페이지로 돌아올것. -->		
				<%if(memberLoggedIn!=null 
					&& ("admin".equals(memberLoggedIn.getMemberId()) 
							|| bc.getBoardCommentWriter().equals(memberLoggedIn.getMemberId()) )){%>
				<button class="btn-delete" value="<%=bc.getBoardCommentNo()%>">삭제</button>
				<%} %>

			</td>
		
		
		</tr>
	<%
				}
				//2.대댓글(답글)인 경우
				else{
	%>
		<tr class="level2">
			<td>
				<sub class="comment-writer"><%=bc.getBoardCommentWriter() %></sub>
				<sub class="comment-date"><%=bc.getBoardCommentDate() %></sub>
				<br />
				<%=bc.getBoardCommentContent() %>
			</td>
			<td>
				<%if(memberLoggedIn!=null 
					&& ("admin".equals(memberLoggedIn.getMemberId()) 
							|| bc.getBoardCommentWriter().equals(memberLoggedIn.getMemberId()) )){%>
				<button class="btn-delete" value="<%=bc.getBoardCommentNo()%>">삭제</button>
				<%} %>
			</td>
		</tr>
	<%
				}
			}
		}
	%>
	</table> 
</div>

</section>
<script>
$(function(){
	
    //삭제버튼 클릭시
    $(".btn-delete").click(function(){
        if(!confirm("정말 삭제하시겠습니까?")) return;
        //삭제처리후 돌아올 현재게시판번호도 함께 전송함.
        location.href="<%=request.getContextPath()%>/board/boardCommentDelete?boardNo=<%=b.getBoardNo() %>&del="+$(this).val();
    });
	
	
	//대댓글(답글)버튼 .btn-reply
	$(".btn-reply").on("click", function(e){
		<% 	if(memberLoggedIn == null){%>
				loginAlert();
		<% 	}
			//로그인한 경우
			else {
		%>
			var tr = $("<tr></tr>");
			var html = '<td style="display:none; text-align:left;" colspan=2>';
			html += '<form action="<%=request.getContextPath()%>/board/boardCommentInsert" method="POST">';
			html += '<input type="hidden" name="boardRef" value="<%=b.getBoardNo()%>" />';
			html += '<input type="hidden" name="boardCommentWriter" value="<%=memberLoggedIn.getMemberId()%>" />';
			html += '<input type="hidden" name="boardCommentLevel" value="2" />';
			html += '<input type="hidden" name="boardCommentRef" value="'+$(this).val()+'" />';
			html += '<textarea name="boardCommentContent" cols="60" rows="1"></textarea>';
			html += '<input type="submit" class="btn-insert2" value="등록" />';
			html += '</form></td>';
			tr.html(html);
			
			console.log($(this).parent().parent());//tr.level1
			console.log(tr.children('td'));//방금 생성한 td
			
			tr.insertAfter($(this).parent().parent())
			  .children('td')
			  .slideDown(800)
			  .children('form')
			  .submit(function(e){
				 var $textarea = $(this).children("textarea");
				 
				 if($textarea.val().trim().length == 0)
					 e.preventDefault();
				 	
			  });
			  
			  
		
		
		<%
			}		
		%>
	});
	
	
		
	//textarea
	$("[name=boardCommentContent]").click(function(){
		if(<%=memberLoggedIn == null%>){
			loginAlert();
		}
	});
	
	//submit: jquery방식 - preventDefault함수 사용 
	$("[name=boardCommentFrm]").submit(function(e){
		if(<%=memberLoggedIn == null%>){
			loginAlert();
			e.preventDefault();
			return;
		}		
		
		var $content = $("[name=boardCommentContent]");
		if($content.val().trim().length == 0){
			e.preventDefault();
			return;
		}
		
	});
});

function loginAlert(){
	alert("로그인 후 이용할 수 있습니다.");
	$("#memberId").focus();
}



function fileDownload(oName, rName){
	//ie대비 한글인코딩 명시적 처리
	oName = encodeURIComponent(oName);
	console.log(oName);
	
	location.href 
		= "<%=request.getContextPath()%>/board/fileDownload?oName="+oName+"&rName="+rName;
	
}


</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
