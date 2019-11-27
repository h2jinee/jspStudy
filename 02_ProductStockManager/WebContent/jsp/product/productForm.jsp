<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/jsp/common/error.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 추가페이지</title>
<style>
div#container {
	border:1px solid black;
	width:80%; 
	margin:auto; 
	padding:50px; 
	text-align:center; 
}
table#product{
	/* border:1px solid black; */
	border-collapse:collapse;
	width: 355px;
	margin: auto;
	
}
table#product td {
	/* border:1px solid black; */
	padding:5px;
}
/* 첫번째컬럼너비 */
table#product tr td:first-of-type{
    text-align:right;
    width:30%;
}
/* 두번째컬럼 좌측정렬 */
table#product tr td:last-of-type{
    text-align:left;
}
/* 마지막버튼행 정렬 */
table#product tr:last-of-type td{
    text-align:center;
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
	<a href="<%=request.getContextPath()%>" id="to-main"><img src="<%=request.getContextPath()%>/images/home.png" /></a>
	<br />
	<h2>상품재고관리 시스템 - 상품추가</h2>
	<form action="<%=request.getContextPath()%>/jsp/product/productInsert.jsp"
		  method="POST">
		<table id="product">
			<tbody>
				<tr>
					<td>상품아이디 : </td>
					<td><input type="text" name="productId" id="productId" required/></td>
				</tr>
				<tr>
					<td>상품명 :</td>
					<td><input type="text" name="productName" id="productName" required/></td>
				</tr>
				<tr>
					<td>가격 :</td>
					<td><input type="number" name="price" id="price" step=1000 required/></td>
				</tr>
				<tr>
					<td>재고 :</td>
					<td><input type="number" name="stock" id="stock" value="0" required/></td>
				</tr>
				<tr>
					<td>상품설명 :</td>
					<td><textarea name="desc" id="desc" cols=30 rows=3></textarea></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="상품추가" />&nbsp;&nbsp;
						<input type="reset" value="초기화" />
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	
	</div>
</body>
</html>
