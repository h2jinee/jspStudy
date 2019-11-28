<%@ page import="product.model.vo.Product,
				 product.model.service.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 한글 인코딩 처리
	request.setCharacterEncoding("utf-8");
	
	//2. 사용자 입력 값 핸들링
	String productId = request.getParameter("productId"); //input태그의 name속성과 이름이 같아야 함.
	String productName = request.getParameter("productName");
	int price = Integer.parseInt(request.getParameter("price")); //사용자 요청은 무조건 string
	int stock = Integer.parseInt(request.getParameter("stock"));
	String desc = request.getParameter("desc");
	
	Product p = new Product(productId, productName, price, stock, desc);
	System.out.println("p@productInsert.jsp="+p);
	
	//3. 업무로직
	ProductService productService = new ProductService();
	int result = productService.insertProduct(p);
	
	//4. 사용자 view단 처리(피드백 : 잘 등록 되었습니다, 오류가 발생하였습니다. 등) : msg.jsp로 위임
	String msg = "";
	String loc = "/";
	
	if(result > 0){
		msg = "상품 등록 성공!";
		loc = "/jsp/product/productView.jsp?productId="+productId;
	}
	else {
		msg = "상품 등록 실패!";
	}
	
	//변수 속성 저장
	request.setAttribute("msg", msg);
	request.setAttribute("loc", loc);
	
	RequestDispatcher reqDispatcher = request.getRequestDispatcher("/jsp/common/msg.jsp");
	reqDispatcher.forward(request, response);
%>
