<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/jsp/common/error.jsp"%>
<%@ page import="product.model.service.*,
				 product.model.vo.*,
				 product.model.exception.*,
				 java.util.*" %>

<%
	/****** Controller ******/
	ProductService productService = new ProductService();
	List<Product> list = productService.selectProductList();
	//System.out.println("list@jsp="+list);
	//list.clear();
	List<ProductIO> ioList = productService.selectProductIOList();
	//System.out.println("ioList@jsp="+ioList);

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
});
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
</style>
</head>

<body>
<div id="container">
	<h2>상품재고관리 시스템</h2>
	<section id="tbl-container">
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
		
		<button id="btn-add">상품추가</button>
		
		<hr />
		<h3>상품입출고현황</h3>
		<table id="io">
			<thead>
				<tr>
					<th>입출고번호</th>
					<th>상품아이디</th>
					<th>날짜</th>
					<th>수량</th>
					<th>입/출고</th>
				</tr>
			</thead>
			<tbody>
			<%
				if(!ioList.isEmpty()){
					for(int i=0; i<ioList.size(); i++){
					ProductIO pio = ioList.get(i);			
			%>
				<tr productId="<%=pio.getProductId() %>">
					<td><%=pio.getIoNo() %></td>
					<td><%=pio.getProductId() %></td>
					<td><%=pio.getIoDate() %></td>
					<td><%=pio.getAmount() %></td>
					<td><%=("I".equals(pio.getStatus())? "입고" : "출고") %></td>
				</tr>
			<%
					}
				}
				else{
			%>
				<tr>
					<td colspan="5">입출고 내역이 없습니다.</td>
				</tr>
			<%
				}
			%>
			</tbody>
		</table>
	</section>
	<section id="srch-container">
		<form name="srchFrm" action="<%=request.getContextPath()%>/jsp/product/productFinder.jsp">
			<input type="radio" name="srchType" id="productId" value="productId" checked/><label for="productId">상품아이디</label>
			<input type="radio" name="srchType" id="productName" value="productName" /><label for="productName">상품명</label>
			<br /><br />
			<input type="search" name="srchKeyword" id="srchKeyword" size=25 placeholder="검색할 아이디를 입력하세요."/>
			<br /><br />
			<input type="submit" onclick="return srchValidate();" value="검색" />
		</form>
	</section>
</div>

</body>
</html>

