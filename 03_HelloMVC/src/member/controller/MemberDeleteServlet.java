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
 * Servlet implementation class MemberDeleteServlet
 */
@WebServlet("/member/memberDeleteServlet")
public class MemberDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
		//1.인코딩
	    request.setCharacterEncoding("utf-8");
	    
	    //2.사용자입력값 핸들링
	    String memberId = request.getParameter("memberId");
	    
	    
	    //System.out.println("m@delete.jsp="+memberId);
	    
	    //3.업무로직: service logic 호출
		int result = new MemberService().deleteMember(memberId);
		
		//4. 받은 결과에 따라 뷰페이지 내보내기
		String view = "/WEB-INF/views/common/msg.jsp";
		String msg = "";
		//javascript/html에서 사용할 url은 contextPath를 포함한다.
		String loc = "/";

		if(result>0) {
			
			msg = "성공적으로 회원삭제했습니다.";
			
			Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
			if(!"admin".equals(memberLoggedIn.getMemberId())) {
				//회원탈퇴인 경우, 로그아웃 처리함.
				loc = "/member/logout";
			}
			
		}
		else 
			msg = "회원삭제에 실패했습니다.";	
		
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
