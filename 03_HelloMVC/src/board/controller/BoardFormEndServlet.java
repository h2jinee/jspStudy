package board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import board.model.service.BoardService;
import board.model.vo.Board;
import common.MvcFileRenamePolicy;

/**
 * Servlet implementation class BoardFormEndServlet
 */
@WebServlet(name="BoardFormEndServlet", urlPatterns="/board/boardFormEnd")
public class BoardFormEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 1. 파일업로드 절차
	 *  - 저장경로
	 *  - 파일용량제한
	 *  - 파일rename정책 : FileRenamePolicy
	 *  - MultipartRequest객체생성 : 파일입출력수행
	 * 2. 사용자 입력 값 처리 : MultipartRequest객체
	 * 3. 업무로직처리
	 * 4. view단 위임
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//파일이 저장될 절대경로 가져오기
		String saveDirectory = getServletContext().getRealPath("/upload/board"); // / 웹루트 WebContent
		System.out.println("saveDirectory="+saveDirectory);
		
		//파일최대업로드 크기 제한 : 10MB까지 제한
		//10MB = 1024 * 1024 * 10 (바이트 단위)
 		int maxPostSize = 1024 * 1024 * 10;
 		
 		//파일명 재지정 정책 객체
 		FileRenamePolicy mvcFileRenamePolicy = new MvcFileRenamePolicy();
		
		MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, "utf-8", mvcFileRenamePolicy);
		
		
		//1. parameter handling
		//String boardTitle = request.getParameter("boardTitle");
		//String boardWriter = request.getParameter("boardWriter");
		//String upFile = request.getParameter("upFile");
		//String boardContent = request.getParameter("boardContent");
		String boardTitle = multiReq.getParameter("boardTitle");
		String boardWriter = multiReq.getParameter("boardWriter");
		String boardContent = multiReq.getParameter("boardContent");
		
		//XSS공격대비 & 문자변환
		boardContent = boardContent.replaceAll("<", "&lt;")
								   .replaceAll(">", "&gt;")
								   .replaceAll("\\n", "<br/>");
		
		String originalFileName = multiReq.getOriginalFileName("upFile"); //사용자가 업로드한 파일명
		String renamedFileName = multiReq.getFilesystemName("upFile"); //실제 저장된 파일명
		
		Board board = new Board();
		board.setBoardTitle(boardTitle);
		board.setBoardWriter(boardWriter);
		board.setBoardContent(boardContent);
		board.setOriginalFileName(originalFileName);
		board.setRenamedFileName(renamedFileName);
		
		System.out.println("b@boardFormEnd="+board);
		
		//2. 비즈니스 로직 호출
		int result = new BoardService().insertBoard(board);
		
		String msg = "";
		String loc = "/board/boardView?boardNo="+board.getBoardNo();
		
		if(result>0) {
			msg = "게시글 등록 성공!";
		}
		else {
			msg = "게시글 등록 실패! 관리자에게 문의하세요.";
		}
		
		
		//3.view단 처리
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
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
