package admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.model.service.AdminService;
import member.model.vo.Member;

/**
 * Servlet implementation class AdminMemberFinderServlet
 */
@WebServlet("/admin/memberFinder")
public class AdminMemberFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. parameter handling
		int cPage = 1;
		final int numPerPage = 10;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException E) {
			
		}
		
		String searchType = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");
		System.out.println("searchType@finder="+searchType);
		System.out.println("searchKeyword@finder="+searchKeyword);
		
		//2. 업무로직
		List<Member> list = null;
		AdminService adminService = new AdminService();
		
		switch(searchType) {
		case "memberId" : list = adminService.selectMemberByMemberId(searchKeyword, cPage, numPerPage); break;
		case "memberName" : list = adminService.selectMemberByMemberName(searchKeyword, cPage, numPerPage); break;
		case "gender" : list = adminService.selectMemberByGender(searchKeyword, cPage, numPerPage); break;
		}
		
		//페이징바 영역
		int totalContent = 0;
		
		switch(searchType) {
		case "memberId" : totalContent = adminService.selectTotalContentByMemberId(searchKeyword); break;
		case "memberName" : totalContent = adminService.selectTotalContentByMemberName(searchKeyword); break;
		case "gender" : totalContent = adminService.selectTotalContentByGender(searchKeyword); break;
		}
		int totalPage = (int)Math.ceil((double)totalContent/numPerPage); //공식2
//		System.out.printf("totalContent=%s, totalPage=%s%n", totalContent, totalPage);
		
		String pageBar = "";
		int pageBarSize = 5; //중요 (이해)
		//		   1 2 3 4 5  (다음)
		//	(이전) 6 7 8 9 10 (다음)
		//	(이전) 11 12
		//cPage, pageBarSize => pageStart
		//1, 5 => 1 => (5*0)+1
		//2, 5 => 1
		//3, 5 => 1
		//6, 5 => 6 =>  (5*1)+1
		//7, 5 => 6
		//8, 5 => 6
		//11, 5 => 11 => (5*2)+1
		//12, 5 => 11
		//공식3
		int pageStart = ((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd = pageStart+pageBarSize-1;
		
		//증감변수 pageNo
		int pageNo = pageStart;
		
		System.out.println(pageStart+"/"+pageEnd+"/"+pageNo);
		//1. 이전
		if(pageNo!=1) {
			pageBar+="<a href='"+request.getContextPath()+"/admin/memberFinder?searchType="+searchType+"&searchKeyword="+searchKeyword+"&cPage="+(pageNo-1)+"'>[이전]</a>\n";
		}
		// 2.pageNo
		while(pageNo<=pageEnd&&pageNo<=totalPage){
			//현재페이지인 경우
			if(cPage==pageNo) {
				pageBar+="<span class='cPage'>"+pageNo+"</span>";
			}else {
				pageBar+="<a href='"+request.getContextPath()+"/admin/memberFinder?searchType="+searchType+"&searchKeyword="+searchKeyword+"&cPage="+pageNo+"'>"+pageNo+"</a>\n";
			}
			pageNo++;
		}
		// 3.다음
		if(pageNo<=totalPage) {
			pageBar+="<a href='"+request.getContextPath()+"/admin/memberFinder?searchType="+searchType+"&searchKeyword="+searchKeyword+"&cPage="+pageNo+"'>[다음]</a>\n";
		}
		//3.업무로직
		request.setAttribute("list",list);
		request.setAttribute("pageBar", pageBar);
		System.out.println("list@finder="+list);
		
		//3. view단 처리
		request.getRequestDispatcher("/WEB-INF/views/admin/memberFinder.jsp")
			   .forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
