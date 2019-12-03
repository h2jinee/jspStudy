package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/member/memberUpdate")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. encoding
		request.setCharacterEncoding("utf-8");
		
		//2. parameter handling
		String memberId = request.getParameter("memberId");
		String password = request.getParameter("password");
		String memberName = request.getParameter("memberName");
		int age = Integer.parseInt(request.getParameter("age"));
		String email = request.getParameter("email");
		int phone = Integer.parseInt("phone");
		String address = request.getParameter("address");
		String gender = request.getParameter("gender");
				
		//hobby: String[] => ,를 사용해 문자열 합침 => 단일문자열
		//hobby=게임&등산=등산 -> "게임,등산"
		//String[] hobby = request.getParameterValues("hobby");
		//for(int i = 0; i <hobby.length; i++) {
				
		//	System.out.print(hobby[i]+",");
		//}
		String[] hobbies = request.getParameterValues("hobby");
		
		String hobby = "";
		//String java.lang.String.join(CharSequence delimiter, CharSequence... elements)
		//파라미터로 전달한 문자열배열이 null이면, NullPointerException유발.
		if(hobbies!=null) hobby = String.join(",", hobbies);
		
		//3. business logic
		//현재 가입되어있는 memberId와 비교하여 중복 방지
		int result = new MemberService().updateMember(member);
		
		String msg = "";
		String loc = "/";
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
		
		if(result == null) {
			msg = "존재하지 않는 아이디입니다.";
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			reqDispatcher.forward(request, response);
			
		}
		
		//4. view단 처리 : msg.jsp -> /mvc
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
