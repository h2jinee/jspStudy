<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello MVC</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/style.css" />
<script src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
<script>
$(functuion(){
	console.log("<<jquery loading 완료!!!>>")
	
});

function loginValidate(){
	var $memberId = $("#memberId");
	var $password = $("#password");
	
	if($memberId.val().trim().length == 0){
		alert("아이디를 입력하세요.");
		$memberId.focus();
		return false;
	}
	if($password.val().trim().length == 0){
		alert("비밀번호를 입력하세요.");
		$password.focus();
		return false;
	}
	
	return true;
}
</script>
</head>
<body>
	<div id="container">
		<header>
			<h1>Hello MVC</h1>
			<!--  로그인메뉴 -->
			<div class="login-container">
				<!-- 비밀번호같은 중요한 정보가 담겨있을 때에는 get이 아닌 post를 써야 함 -->
				<form action="<%=request.getContextPath() %>/member/loginCheck" id="loginFrm" method="post" onsubmit="return loginValidate();">
					<table>
						<tr>
							<td><input type="text" name="memberId" id="memberId" placeholder="아이디" tabindex="1" /></td>
							<td>
								<input type="submit" value="로그인" tabindex="3" />
							</td>
						</tr>
						<tr>
							<td><input type="password" name="password" id="password" placeholder="비밀번호" tabindex="2" /></td>
							<td></td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="checkbox" name="" id="saveId" />
								<label for="saveId">아이디 저장</label>
								<input type="button" value="회원가입" onclick="goMemberEnroll();" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<!-- 로그인메뉴 끝 -->
			<!-- 메인메뉴 시작 -->
			<!-- nav>ul.main-nav>li -->
			<nav>
				<ul class="main-nav">
					<li class="home"><a href="#">Home</a></li>
					<li class="notice"><a href="#">공지사항</a></li>
					<li class="board"><a href="#">게시판</a></li>
				</ul>
			</nav>
			<!-- 메인메뉴 끝 -->
			
		</header>
		
		<section id="content">