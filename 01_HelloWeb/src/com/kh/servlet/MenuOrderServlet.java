package com.kh.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MenuOrderServlet  extends HttpServlet{
	
	@Override
	public void doGet(HttpServletRequest request,
					  HttpServletResponse response) 
							  throws IOException, ServletException{
		
		//0. 인코딩처리
		request.setCharacterEncoding("utf-8");
		
		//1. 사용자 요청 값 자바변수에 담기
		String main_menu = request.getParameter("main_menu");
		String side_menu = request.getParameter("side_menu");
		String drink_menu = request.getParameter("drink_menu");
		
		int main_menuTotal = 0;
		int side_menuTotal = 0;
		int drink_menuTotal = 0;
		
		switch(main_menu) {
		case "한우버거" : main_menuTotal = 5000; break;
		case "치즈버거" : main_menuTotal = 4500; break;
		case "밥버거" : main_menuTotal = 4000; break;
 		}
		switch(side_menu) {
		case "감자튀김" : side_menuTotal = 1500; break;
		case "어니어링" : side_menuTotal = 1700; break;
 		}
		switch(drink_menu) {
		case "콜라" : drink_menuTotal = 1000; break;
		case "사이다" : drink_menuTotal = 1000; break;
		case "커피" : drink_menuTotal = 1500; break;
		case "밀크쉐이크" : drink_menuTotal = 2500; break;
 		}
		
		
		//2. total
		request.setAttribute("main_menuTotal", main_menuTotal);
		request.setAttribute("side_menuTotal", side_menuTotal);
		request.setAttribute("drink_menuTotal", drink_menuTotal);
		
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("/jsp/menuOrder.jsp");
		reqDispatcher.forward(request, response);

//		@Override
//		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//			doGet(request, response);
//		}
		
		
	}
}
