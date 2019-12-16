<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@page import="board.model.vo.Board" %>
<%
    Board b = (Board)request.getAttribute("board");
%>
<link rel="stylesheet" 
      href="<%=request.getContextPath()%>/css/board.css" />
<section id="board-container">
    <h2>게시판 수정</h2>
    <form action="<%=request.getContextPath()%>/board/boardUpdateEnd"
          method="post"
          enctype="multipart/form-data">
        <table id="tbl-board-view">
        
        <input type="hidden" name="boardNo" value="<%=b.getBoardNo() %>" />
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" name="boardTitle" 
                           value="<%=b.getBoardTitle()%>" required/>
                </td>
            </tr>     
            <tr>
                <th>작성자</th>
                <td>
                    <input type="text" 
                           name="boardWriter"
                           value="<%=b.getBoardWriter()%>"
                           readonly 
                           required/>
                </td>
            </tr>     
            <tr>
                <th>첨부파일</th>
                <td style = "position:relative;">
                <!-- file태그의 value속성은 임의로 변경할 수 없다. 반영되지 않음. -->
                    <input type="file" name="upFile" />
                    
                    <span id = "fname"><%=b.getOriginalFileName() != null? b.getOriginalFileName():""%></span>
                    <input type="hidden" name="oldOriginalFileName" value="<%=b.getOriginalFileName() != null? b.getOriginalFileName(): ""%>" />
                    <input type="hidden" name="oldRenamedFileName" value="<%=b.getRenamedFileName() != null? b.getRenamedFileName(): ""%>" />
                    
                    <!-- 기존파일삭제 체크박스 -->
                    <% if(b.getOriginalFileName() != null) { %>
                    <br />
                    <input type="checkbox" name="delFileChk" id="delFileChk" />
                    <label for="delFileChk">첨부파일삭제</label>
                    <% } %>
                </td>
            </tr>     
            <tr>
                <th>내 용</th>
                <td>
                    <textarea name="boardContent" 
                              cols="50" 
                              rows="5"><%=b.getBoardContent()%></textarea>
                </td>
            </tr>     
            <tr>
                <th colspan="2">
                    <input type="submit"
                           onclick="return boardValidate();" 
                           value="수정하기" />
                </th>
            </tr>
        </table>
    </form>
</section>
<script>
/*
 * 기존 파일명 시각화 처리
 */
$("[name=upFile]").change(function(){
    // 수정페이지에서 파일태그에 파일을 추가한 경우
    if($(this).val() != ""){
        $("#fname").hide();
        $("#delFileChk").hide().next().hide();
    }
    else{
        $("#fname").show();
        $("#delFileChk").show().next().show();
    }
});
function boardValidate(){
    //제목검사
    var $title = $("[name=boardTitle]");
    if($title.val().trim().length == 0){
        alert("제목을 입력하세요.");
        return false;
    }
    
    //내용검사
    var $content = $("[name=boardContent]");
    if($content.val().trim().length == 0){
        alert("내용을 입력하세요.");
        return false;
    }
    
    return true;
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>