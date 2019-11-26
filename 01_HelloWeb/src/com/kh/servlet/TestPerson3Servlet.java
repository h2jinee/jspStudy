package com.kh.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servelet클래스의 생명주기
 * 
 * init(ServletConfig) - service(HttpServletRequest, HttpServletResponse)
 * 각 메소드 별 doGet, doPost 호출 됨.
 * 응답을 하게 되면 소멸하게 됨.
 *
 */
public class TestPerson3Servlet  extends HttpServlet{
	
	@Override
	public void doPost(HttpServletRequest request,
					  HttpServletResponse response) 
							  throws IOException, ServletException{
		
		//0. 인코딩처리
		request.setCharacterEncoding("utf-8");
		
		//1. 사용자 요청 값 자바변수에 담기
		String name = request.getParameter("name");
		String color = request.getParameter("color");
		String animal = request.getParameter("animal");
		String[] foodArr = request.getParameterValues("food");
		
		System.out.println("name="+name);
		System.out.println("color="+color);
		System.out.println("animal="+animal);
		System.out.println("foodArr="+Arrays.toString(foodArr));
		
		//업무로직 : 사용자 선호색상에 따라 추천기능
		String recommendation = "";
		switch(color) {
		case "빨강" : recommendation = "빨간 립스틱"; break;
		case "노랑" : recommendation = "노란 스카프"; break;
		case "초록" : recommendation = "초록 우산"; break;
		case "파랑" : recommendation = "파랑 모자"; break;
 		}
		
		//request객체에 속성으로써 변수 저장 : key - value 형식 (like USB)
		//request에 저장해두면 jsp에서 setAttribute메소드로 접근 할 수 있다.
		request.setAttribute("recommendation", recommendation);
		
		
		//2. view단 위임처리
		RequestDispatcher reqDispatcher
			= request.getRequestDispatcher("/servlet/testPersonEnd.jsp");
		reqDispatcher.forward(request, response);
		
		
	}
}
