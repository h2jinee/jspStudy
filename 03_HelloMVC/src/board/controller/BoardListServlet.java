package board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.model.service.AdminService;
import board.model.service.BoardService;
import board.model.vo.Board;
import member.model.vo.Member;

/**
 * Servlet implementation class BoardListServlet
 */
@WebServlet("/board/boardList")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BoardService boardService = new BoardService();
		
		//1. 파라미터 핸들링
		final int numPerPage = 5;
		int cPage = 1;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
			
		}
		
		//2. 업무로직
		
		//a. 컨텐츠영역
		
		List<Board> list = boardService.selectBoardList(cPage, numPerPage);
		System.out.println("list@servlet="+list);
		
		//b. 페이징바영역
		//전체 게시글 수, 전체 페이지 수
		int totalContent = boardService.selectBoardCount();
		int totalPage = 0; //공식 2
		
		String pageBar = "";
		
		//페이징 바 영역처리
		//int totalContent = new BoardService().selectTotalContent();
		totalPage = (int)Math.ceil((double)totalContent/numPerPage);//공식2
//		System.out.printf("totalContent=%s, totalPage=%s%n", totalContent, totalPage);
				
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
				
				//1. 이전
				if(pageNo != 1) {
					pageBar += "<a href='"+request.getContextPath()+"/board/boardList?cPage="+(pageNo-1)+"'>[이전]</a>\n";
				}
				
				//2. pageNo
				while(pageNo<=pageEnd && pageNo <= totalPage) {
					//현재페이지인 경우
					if(cPage == pageNo) {
						pageBar += "<span class='cPage'>"+pageNo+"</span>";
					}
					else {
						pageBar += "<a href='"+request.getContextPath()+"/board/boardList?cPage="+pageNo+"'>"+pageNo+"</a>\n";
					}
					
					pageNo++;
				}
				
				//3. 다음
				if(pageNo <= totalPage) {
					pageBar += "<a href='"+request.getContextPath()+"/board/boardList?cPage="+pageNo+"'>[다음]</a>\n";
				}
				
				//3.업무로직
				request.setAttribute("list",list);
				request.setAttribute("pageBar", pageBar);
		
		//3. view단
		request.getRequestDispatcher("/WEB-INF/views/board/boardList.jsp")
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
