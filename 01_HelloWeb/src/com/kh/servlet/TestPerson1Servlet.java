package com.kh.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

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
public class TestPerson1Servlet  extends HttpServlet{
	
	@Override
	public void doGet(HttpServletRequest request,
					  HttpServletResponse response) 
							  throws IOException, ServletException{
		
		//1. 사용자 요청 값 자바변수에 담기
		String name = request.getParameter("name");
		String color = request.getParameter("color");
		String animal = request.getParameter("animal");
		String[] foodArr = request.getParameterValues("food");
		
		System.out.println("name="+name);
		System.out.println("color="+color);
		System.out.println("animal="+animal);
		System.out.println("foodArr="+Arrays.toString(foodArr));
		
		
		//2. 응답객체 작성하기
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head>");
		out.println("<title> 개인취향 테스트 결과 페이지 </title>");
		out.println("<style>");
		out.println("h2{color:red;}");
		out.println("span.name{color:lightblue;}");
		out.println("span.color{color:lightgreen;}");
		out.println("span.animal{color:lightsalmon;}");
		out.println("span.food{color:lightseagreen;}");
		out.println("</style>");
		
		
		out.println("</head>");
		out.println("<body>");
		out.println("<h2>개인 취향 테스트 결과페이지(GET)</h2>");
		out.printf("<span class='name'>%s</span>님의 개인취향은", name);
		out.printf("<span class='color'>%s</span>색을 좋아하고", color);
		out.printf("<span class='animal'>%s</span>을 좋아합니다.", animal);
		out.printf("좋아하는 음식은 <span class='food'>%s</span>입니다.", Arrays.toString(foodArr));
		
		out.println("</body>");
		out.println("</html>");
		
		
	}
}
