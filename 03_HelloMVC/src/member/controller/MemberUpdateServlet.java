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
@WebServlet(name="MemberUpdateServlet", urlPatterns="/member/memberUpdate")
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
		//String password = request.getParameter("password");
		String memberName = request.getParameter("memberName");
		int age = Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("gender");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		
				
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
		
		Member member = new Member(memberId, null, memberName, gender, age, email, phone, address, hobby.toString(), null);

		System.out.println("입력한 회원정보 : "+member);
		
		//3.서비스로직호출
		int result = new MemberService().updateMember(member);
		
		//4. 받은 결과에 따라 뷰페이지 내보내기
		String view = "/WEB-INF/views/common/msg.jsp";
		String msg = "";
		String loc = "/member/memberView?memberId="+memberId;

		if(result>0) {
			
			msg = "성공적으로 회원수정했습니다.";
			//현재 session에 저장된 memberLoggedIn객체 반영
			request.getSession().setAttribute("memberLoggedIn", member);
		}
		else 
			msg = "회원수정에 실패했습니다.";	
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		RequestDispatcher reqDispatcher = request.getRequestDispatcher(view);
		reqDispatcher.forward(request, response);

	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
