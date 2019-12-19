<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/photo.css" />
<section id="photo-wrapper">
	<h2>사진게시판 작성</h2>
	<form action="<%=request.getContextPath()%>/photo/photoFormEnd"
		  method="POST">
		<table id="tbl-photo">
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="photoWriter"
						   value="<%=memberLoggedIn.getMemberId()%>"
						   readonly
						   required/>
				</td>
			</tr>	
			<tr>
				<th>첨부파일</th>
				<td>
					<input type="file" name="upFile" id="upFile"
						   onchange="loadImg(this);"
						   required/>
				</td>
			</tr>
			<tr>
				<th>이미지 보기</th>
				<td>
					<div id="img-viewer-container">
						<img id="img-viewer" width="350px"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="photoContent" 
							  id="photoContent" 
							  cols="50" rows="5" 
							  required></textarea>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" value="등록" 
						   onclick="return photoValidate();"/>
				</th>
			</tr>
		</table>
	</form>
</section>
<script>
/*
 * FileReader를 통한 이미지 미리보기 구현
 */
function loadImg(f){
	console.dir(f);
	console.dir(f.files[0]);
	
	if(f.files && f.files[0]){
		let reader = new FileReader();
		//파일읽기, 읽기완료시 load event발생
		reader.readAsDataURL(f.files[0]);
		
		reader.onload = e => {
			//파일컨텐츠는 e.target.result속성에 담겨있음.
			$("#img-viewer").attr("src", e.target.result);
		}
	}
	else{
		$("#img-viewer").attr("src", "");
	}
}



function photoValidate(){
	var $photoContent = $("#photoContent");
	if($photoContent.val().trim().length == 0){
		alert("내용을 입력하세요.");
		return false;
	}
	return true;
}

</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>