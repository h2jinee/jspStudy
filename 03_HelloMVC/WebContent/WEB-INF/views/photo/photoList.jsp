<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int totalPage = (int)request.getAttribute("totalPage");
	System.out.println(totalPage);
%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/photo.css" />


<section id="photo-wrapper">
	<h2>사진게시판</h2>
	<%-- 로그인한 경우 글쓰기 버튼 노출 --%>
	<% if(memberLoggedIn != null){ %>
	<input type="button" value="글쓰기" id="btn-add"
		   onclick="location.href='<%=request.getContextPath() %>/photo/photoForm'" />
	<% } %>
	<div id="photo-container"></div>
	<div id="btn-more-container">
		<button id="btn-more" value="1">더보기(1/<%=totalPage %>)</button>
	</div>
</section>
<script>
$(()=>{
	morePage(1);
	$("#btn-more").click((e)=>{
		morePage($(e.target).val());
	});
});
function morePage(cPage){
	var param = {
			cPage: cPage
	}
	//cPage=1
	$.ajax({
		url: "<%=request.getContextPath()%>/photo/photoMore",
		data: param,
		type: "POST",
		dataType: "json",
		success: data => {
			console.log(data);
			for(let i  in data){
				let html = "";
				let p = data[i];
				html += "<div class='polaroid'>";
				html += "<img src='<%=request.getContextPath()%>/upload/photo/"+p.renamedFileName+"'/>";
				html += "<p class='info'><span class='writer'>"+p.photoWriter+"</span>&nbsp;&nbsp;";
				html += "<span class='photoDate'>"+p.photoDate+"</span></p>";
				html += "<p class='caption'>"+p.photoContent+"</p></div>";
				$("#photo-container").append(html);
			}
			// 더보기버튼 작업
			$("#btn-more").val(Number(cPage)+1).text("더보기(" + cPage + "/<%=totalPage%>)");
			
			// 마지막페이지
			if(cPage == <%=totalPage%>)
				$("#btn-more").attr("disabled", "disabled")
							  .css("cursor", "not-allowed");
		},
		error: (x,s,e) =>{
			console.log("ajax처리실패!", x, s, e);
		}
	});
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>