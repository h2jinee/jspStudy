<%@page import="product.model.service.ProductService"%>
<%@page import="product.model.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //1.인코딩
    request.setCharacterEncoding("utf-8");
    
    //2.사용자입력값 핸들링
    String productId = request.getParameter("productId");
    String productName = request.getParameter("productName");
    int price = Integer.parseInt(request.getParameter("price"));
    String desc = request.getParameter("desc");
    int stock = Integer.parseInt(request.getParameter("stock"));
    
    Product p = new Product(productId, productName, price, stock, desc);
    System.out.println("p@update.jsp="+p);
    
    //3.업무로직: service logic 호출
    int result = new ProductService().updateProduct(p);
    
    String msg = "";
    String loc = "/";
    
    if(result>0){
        msg = "상품 정보 수정 성공!";
        loc = "/jsp/product/productView.jsp?productId="+productId;
    }
    else {
        msg = "상품 정보 수정 실패!"; 
    }
    
    //4.view단 처리: msg.jsp 위임
    request.setAttribute("msg", msg);
    request.setAttribute("loc", loc);
    
    RequestDispatcher reqDispatcher
        = request.getRequestDispatcher("/jsp/common/msg.jsp");
    reqDispatcher.forward(request, response);
    
%>