<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>javascript::ajax</title>
<style>
.test{
	width: 300px;
	min-height: 50px;
	border: 1px solid;
}
</style>
</head>
<body>
	<h1>javacript::ajax</h1>
	<hr />
	<form name="memberFrm">
		<input type="text" name="name" id="name" placeholder="이름" />
		<br />
		<input type="number" name="age" id="age" placeholder="나이" />
	</form>
	
	<h2>GET</h2>
	<button onclick="testGet();">실행</button>
	<p id="test1" class="test"></p>
	<script>
	var xhr; //이벤트핸들러함수 참조를 위해 전역변수 선언.
	
	function testGet(){
		//1. XMLHttpRequest객체 생성
		xhr = getXMLHttpRequest();

		if(xhr == null) return;
		
		//2. 연결 후 연결상태에 따른 이벤트핸들러 바인딩
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 0){
				console.log("readystate=0: uninitialized!");
			}
			else if(xhr.readyState == 1){
				console.log("readystate=1: loading!");				
			}
			else if(xhr.readyState == 2){
				console.log("readystate=2: loaded!");
			}
			else if(xhr.readyState == 3){
				console.log("readystate=3: interactive!");
			}
			else if(xhr.readyState == 4){
				console.log("readystate=4: completed!");
				
				if(xhr.status == 200){
					console.log("ajax 정상 처리됨!!!");
					
					console.log("xhr.responseTest="+xhr.responseText);
					
					document.querySelector("#test1").innerHTML += xhr.responseText;
					
					//초기화
					document.querySelector("#name").value = '';
					document.querySelector("#age").value = '';
				}
			}
		}
		
		//3. 연결(open)
		//method, url, ajax비동기여부
		var nameVal = document.querySelector("#name").value;
		var ageVal = document.querySelector("#age").value;
		xhr.open("GET", "<%=request.getContextPath()%>/js/test?name="+nameVal+"&age="+ageVal, true);
		
		//4. 전송
		//queryString
		xhr.send(null);
		
	}
	
	/**
	*	cross-browsing issue 해결해야 함.
	*/
	function getXMLHttpRequest(){
		//ie인 경우
		if(window.ActiveXObject){
			try{
				//ie9 이상인 경우
				return new ActiveXObject("Msxml2.XMLHTTP");
			} catch (ex){
				//ie8 이하인 경우
				try{
					return new ActiveXObject("Microsoft.XMLHTTP");
				} catch(ex){
					return null;
				}
			}
		}
		else if(window.XMLHttpRequest){
			return new XMLHttpRequest();
			
		}
		//ie외의 경우
		else {
			return null;
		}
		
	}
	</script>
	
	<h2>POST</h2>
	<button onclick="testPost()">실행</button>
	<p class="test" id="test2"></p>
	<script>
	function testPost(){
		//1. XMLHttpRequest객체 생성
		xhr = getXMLHttpRequest();
		
		if(xhr == null) return;
		
		//2. readyState값 변화에 따른 이벤트핸들러 설치
		xhr.onreadystatechange = function(){
			//completed
			if(xhr.readyState == 4){
				
				if(xhr.status == 200){
					console.log(xhr.responseText);
					document.querySelector("#test2").innerHTML += xhr.responseText;
				}
				else {
					console.log("ajax처리실패!!");
				}
			}
		}
		
		//3. 연결
		//별도의 Content-type 헤더 작성할 것 : application/x-www-form-urlencoded
		xhr.open("POST", "<%=request.getContextPath()%>/js/test", true);
		//open이후 header값 설정
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		
		//4. 전송
		var nameVal = document.querySelector("#name").value;
		var ageVal = document.querySelector("#age").value;
		xhr.send("name="+nameVal+"&age="+ageVal);
	}
	</script>

</body>
</html>