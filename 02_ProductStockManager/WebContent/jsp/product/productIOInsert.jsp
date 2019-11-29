<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="product.model.vo.*,
				 product.model.service.*,
				 product.model.exception.*" %>
<%
	
	String productId = request.getParameter("productId");
	String status = request.getParameter("status");
	int amount = Integer.parseInt(request.getParameter("amount"));
	
	ProductIO pio = new ProductIO();
	pio.setProductId(productId);
	pio.setStatus(status);
	pio.setAmount(amount);
	//System.out.println("pio@productIOInsert.jsp="+pio);
	
	//사용자피드백을 위한 status변수
	status = "I".equals(pio.getStatus())?"상품입고":"상품출고";
	
	//3. 업무로직 요청
	try {

		int result = new ProductService().insertProduct_IO(pio);
		
		//4. 처리결과에 따른 view단 처리
		if(result>0){
			request.setAttribute("msg", status+"성공!");
			request.setAttribute("loc", "/jsp/product/productView.jsp?productId="+productId);
			RequestDispatcher reqDispatcher  = request.getRequestDispatcher("/jsp/common/msg.jsp");
			reqDispatcher.forward(request, response);

			//RequestDispatcher객체의 forward메소드 호출 이후에는 로직 작성하지 말 것!
		}
	} catch (Exception e) {
		//e.printStackTrace();
		throw new ProductException("상품 "+status+" 오류!!!", e);
	}

%>