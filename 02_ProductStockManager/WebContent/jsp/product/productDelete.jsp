<%@page import="product.model.service.ProductService"%>
<%@page import="product.model.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //1.인코딩
    request.setCharacterEncoding("utf-8");
    
    //2.사용자입력값 핸들링
    String productId = request.getParameter("productId");
    
    
    System.out.println("p@delete.jsp="+productId);
    
    //3.업무로직: service logic 호출
    int result = new ProductService().deleteProduct(productId);
    
    String msg = "";
    String loc = "/";
    
    if(result>0){
        msg = "상품이 삭제되었습니다.";
        //loc = "/jsp/product/productView.jsp?productId="+productId;
    }
    else {
        msg = "상품 삭제 실패.."; 
    }
    
    //4.view단 처리: msg.jsp 위임
    request.setAttribute("msg", msg);
    request.setAttribute("loc", loc);
    
    RequestDispatcher reqDispatcher
        = request.getRequestDispatcher("/jsp/common/msg.jsp");
    reqDispatcher.forward(request, response);
    
%>