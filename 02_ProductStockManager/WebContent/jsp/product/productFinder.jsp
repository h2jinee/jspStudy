<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,
				 product.model.vo.*,
				 product.model.service.*,
				 product.model.exception.*" %>
<%
	//1. encoding
	request.setCharacterEncoding("utf-8");

	//2. parameterHandling
	String srchType = request.getParameter("srchType");
	String srchKeyword = request.getParameter("srchKeyword");
	System.out.println("srchType="+srchType+", srchKeyword="+srchKeyword);
	
	//3. businessLogic request
	List<Product> list = null;
	ProductService productService = new ProductService();
	
	try{
		//상품명조회
		if("productName".equals(srchType)){
			list = productService.selectByPName(srchKeyword);
		}
		//상품아이디조회
		else{
			list = productService.selectByPId(srchKeyword);
		}
		
		System.out.println("list@finder.jsp="+list);
	} catch(Exception e){
		throw new ProductException("상품 검색 오류!!",e);
	}
	
	//4. view

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 재고 관리</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.4.1.js"></script>
<script>
$(function(){
	//console.log("jquery load 완료!!!");
	
	$("#btn-add").click(function(){
		location.href = "<%=request.getContextPath() %>/jsp/product/productForm.jsp";
	});
	
	$("table tr").click(function(){
		//사용자속성 productId값 가져오기
		var productId = $(this).attr("productId");
		console.log(productId);
		
		//테이블 헤어 row를 클릭한 경우
		if(productId == undefined) return;
		
		location.href = "<%=request.getContextPath()%>/jsp/product/productView.jsp?productId="+productId;
	});
	
	$("[name=srchType]").change(function(){
		var id = $(this).attr("id");
		if(id === 'productId')
			$("#srchKeyword").attr("placeholder","검색할 상품 아이디를 입력하세요.").focus();
		else
			$("#srchKeyword").attr("placeholder","검색할 상품명을 입력하세요.").focus();
	});
	
	//스크립트로 처리하기
	$("#<%=srchType%>").prop("checked", true);
});

function srchValidate(){
	var len = $("#srchKeyword").val().trim().length;
	if(len == 0){
		alert("검색어를 입력하세요.");
		return false;
	}
	return true;
}
</script>
<style>
button#btn-add{
	float: right;
	margin: 10px 0;
}
hr{
	clear: both;
}
div#container {
	/* border:1px solid black; */
	width:1000px; 
	margin:auto; 
	padding:50px; 
	text-align:center; 
}
section{
	/*display:inline-block;*/ /* inline-block하면 요소가 높낮이가 달라짐 */
	float:left;
}
section#tbl-container{
	/* border:1px solid black; */
	width:500px; 
	text-align: center; 
	padding: 0 50px 50px
}
section#tbl-container table{
	border:1px solid black;
	border-collapse:collapse;
	width: 100%;
	
}
section#tbl-container table th, section#tbl-container table td {
	border:1px solid black;
	padding:5px;
}
section#tbl-container table tr:hover td{
	background: lightgray;
	color: white;
	cursor: pointer;
}
section#srch-container{
	/* border:1px solid black; */
	width: 250px;
	text-align:left;
	padding:30px 30px 100px;
}
#to-main{
	float:left;
}
#to-main img{
	width: 30px;
}
</style>
</head>

<body>
<div id="container">
	<h2>상품재고관리 시스템</h2>
	<section id="tbl-container">
		<a href="<%=request.getContextPath()%>" id="to-main">
		<img src="<%=request.getContextPath()%>/images/home.png" />
		</a>
	<br />
		<h3>상품현황</h3>
		<table id="product">
			<thead>
				<tr>
					<th>상품아이디</th>
					<th>상품명</th>
					<th>가격</th>
					<th>재고량</th>
				</tr>
			</thead>
			<tbody>
			<%
				if(!list.isEmpty()){
					for(int i=0; i<list.size(); i++){
						Product p = list.get(i);
						//System.out.println(p);
			%>
					<tr productId="<%=p.getProductId() %>">
						<td><%=p.getProductId() %></td>
						<td><%=p.getProductName() %></td>
						<td><%=p.getPrice() %></td>
						<td><%=p.getStock() %></td>
					</tr>
			<%      }
				}
				else{
			%>
					<tr>
						<td colspan="4">상품이 존재하지 않습니다.</td>
					</tr>
			<%
			
				}
			%>
			</tbody>
		</table>
	</section>
	<section id="srch-container">
		<form name="srchFrm" action="<%=request.getContextPath()%>/jsp/product/productFinder.jsp">
			<input type="radio" name="srchType" id="productId" value="productId" <%="productId".equals(srchType)?"checked":"" %>/>
			<label for="productId">상품아이디</label>
			<input type="radio" name="srchType" id="productName" value="productName" <%="productName".equals(srchType)?"checked":"" %>/>
			<label for="productName">상품명</label>
			<br /><br />
			<input type="search" name="srchKeyword" id="srchKeyword" size=25 value="<%=srchKeyword %>" placeholder="검색할 아이디를 입력하세요."/>
			<br /><br />
			<input type="submit" onclick="return srchValidate();" value="검색" />
		</form>
	</section>
</div>

</body>
</html>

