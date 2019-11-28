<%@page import="java.util.*"%>
<%@page import="product.model.exception.ProductException"%>
<%@page import="product.model.service.ProductService"%>
<%@page import="product.model.vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/jsp/common/error.jsp"%>
<%
	//1.인코딩설정
	request.setCharacterEncoding("utf-8");	
	
	//2.파라미터핸들링
	String productId = request.getParameter("productId");
	System.out.println("productId="+productId);
	
	Product p = null;
	List<ProductIO> ioList = null;
	ProductService productService = new ProductService();
	
	try{
		//3.비지니스 로직
		p = productService.selectOne(productId);
		
		if(p == null)
			throw new ProductException("존재하지 않는 상품아이디입니다.");
		
		//해당상품의 입출고 내역
		ioList = productService.selectIOListByPId(productId);
		System.out.println("ioList@view.jsp="+ioList);
		
	} catch(Exception e){
			//사용자 정의 예외 던지기: 
			//운영서버 기준으로 사용자가 이해할 수 있는 에러메세지를 던진다.
			throw new ProductException(e.getMessage());
	}
	
	//4.뷰단처리

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기 페이지</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.4.1.js"></script>
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
/*아이디값은 변경불가 */
input[readonly]{
	background: lightgray;
}

/*상품입출고 테이블*/
table#io{
	border: 1px solid;
	border-collapse: collapse;
	width: 70%;
	margin: 0 auto 15px; 
}
table#io th, table#io td {
	border: 1px solid;
	padding: 5px;
}
</style>
</head>
<body>
	<div id="container">
	<a href="<%=request.getContextPath()%>" id="to-main">
		<img src="<%=request.getContextPath()%>/images/home.png" />
	</a>
	<br />
	<h2>상품재고관리 시스템 - 상품 상세보기</h2>
	<form action="<%=request.getContextPath()%>/jsp/product/productUpdate.jsp"
		  method="POST">
		<table id="product">
			<tbody>
				<tr>
					<td>상품아이디 : </td>
					<td><input type="text" 
							   name="productId" 
							   id="productId"
							   value="<%=p.getProductId() %>" 
							   readonly
							   required/></td>
				</tr>
				<tr>
					<td>상품명 :</td>
					<td><input type="text" 
							   name="productName" 
							   id="productName" 
							   value="<%=p.getProductName() %>" 
							   required/></td>
				</tr>
				<tr>
					<td>가격 :</td>
					<td><input type="number" name="price" id="price" step=1000  
							   value="<%=p.getPrice() %>" required/></td>
				</tr>
				<tr>
					<td>재고 :</td>
					<td><input type="number" name="stock" id="stock" 
							   value="<%=p.getStock() %>" required/></td>
				</tr>
				<tr>
					<td>상품설명 :</td>
					<td>
						<textarea name="desc" id="desc" cols=30 rows=3><%=p.getDescription() %></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="정보수정" />
						&nbsp;&nbsp;
						<input type="reset" value="초기화" />
						&nbsp;&nbsp;
						<input type="button" value="삭제" onclick="delProduct();"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<form action="<%=request.getContextPath() %>/jsp/product/productDelete.jsp" 
		  name="delFrm"
		  method="post">
		<input type="hidden" name="productId" value="<%=productId %>" />
	</form>
	
	<hr />
	
	<h3>상품입출고현황</h3>
	<table id="io">
		<thead>
			<tr>
				<th>입출고번호</th>
				<th>날짜</th>
				<th>수량</th>
				<th>입/출고</th>
			</tr>
		</thead>
		<tbody>
<%
		if(!ioList.isEmpty()){
			for(ProductIO pio : ioList){				
%>
			<tr>
				<td><%=pio.getIoNo() %></td>
				<td><%=pio.getIoDate() %></td>
				<td><%=pio.getAmount() %></td>
				<td><%="I".equals(pio.getStatus())?"입고":"출고" %></td>
			</tr>

<%
			}
		}
		else{
%>
			<tr>
				<td colspan="4">입출고 내역이 없습니다.</td>
			</tr>

<%			
		}
%>				
		</tbody>
	</table>
	
	<form action="<%=request.getContextPath()%>/jsp/product/productIOInsert.jsp"
		  method="POST"
		  onsubmit="return pioValidate();">
		<input type="hidden" name="productId" value="<%=productId %>" />
		<input type="radio" name="status" id="in" value="I" checked/>
		<label for="in">입고</label>
		<input type="radio" name="status" id="out" value="O"/>
		<label for="out">출고</label>
		&nbsp;&nbsp;
		<label for="amount">수량 :</label>
		<input type="number" name="amount" id="amount" 
			   value="0" min="0" required/>
		<input type="submit" value="전송"/>
	</form>	
	
	</div>
	<script>
	function delProduct(){
		if(!confirm("정말 삭제하시겠습니까?")) 
			return;
		
		$("[name=delFrm]").submit();
	}
	
	
	function pioValidate(){
		
		var status = $("[name=status]:checked").val();
		var amount = Number($("#amount").val());
		
		//1. 수량 0 여부
		if(amount == 0){
			alert("수량을 입력하세요.");
			$("#amount").select();
			return false;
		}
		//2. 출고시에 현재 재고량보다 많은수(amount)를 작성한 경우
		if(status == "O"){
			var stock = <%= p.getStock()%>;
			if(amount > stock){
				alert("출고량이 재고량(<%= p.getStock()%>)보다 많습니다.");
				$("#amount").select();
				return false;								
			}
			
		}
		
		return true;
	}
	</script>
</body>
</html>








