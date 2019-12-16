package board.controller;
import java.io.File;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import board.model.*;
import board.model.service.BoardService;
import board.model.vo.Board;
import common.MvcFileRenamePolicy;
import member.model.vo.Member;
/**
 * Servlet implementation class BoardUpdateFormEndServlet
 */
@WebServlet("/board/boardUpdateEnd")
public class BoardUpdateEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    
    /**
     * 1.파일업로드 절차
	 * 	- 저장경로 
	 * 	- 파일용량제한
	 *  - 파일rename정책 : FileRenamePolicy
	 *  - MultipartReqeust객체생성: 파일입출력수행
	 * 2. 사용자입력값처리: MultipartRequest객체 
	 * 3. 업무로직처리
	 * 4. view단 위임
     * 
     * 게시글 수정
     * 1. 첨부파일이 있는 경우:
     *      - 새로운 첨부파일을 수정하는 경우: 기존 파일을 삭제, 새로운 파일정보 DB등록
     *      - 기존파일만 삭제하는 경우: 기존파일 삭제, DB데이터 null값 대입
     *      - 기존파일을 유지하는 경우: 기존파일 유지, DB데이터  기존값 유지
     * 2. 첨부파일이 없는 경우: 게시글 최초 등록과 동일
     */
    
    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. 인코딩 처리
        request.setCharacterEncoding("UTF-8");
        
        // 2. 파라미터 처리
        
        //파일이 저장될 절대경로 가져오기
        String saveDirectory
            = getServletContext().getRealPath("/upload/board");// / 웹루트 WebContent
        System.out.println("saveDirectory="+saveDirectory);
        
        //파일최대업로드크기 제한: 10MB까지 제한
        //10MB = 1024 * 1024 * 10
        int maxPostSize = 1024 * 1024 * 10; 
        
        //파일명 재지정 정책 객체
        FileRenamePolicy mvcFileRenamePolicy
            = new MvcFileRenamePolicy();
        MultipartRequest multiReq = new MultipartRequest(request,
                                                         saveDirectory, 
                                                         maxPostSize, 
                                                         "utf-8",
                                                         mvcFileRenamePolicy);
        
        String originalFileName 
        = multiReq.getOriginalFileName("upFile"); //사용자 업로드한 파일명
        String renamedFileName
        = multiReq.getFilesystemName("upFile"); //실제 저장된 파일명
        
        // 기존 첨부파일정보: 파일이없는 경우 "" 값이 넘어온다.
        String oldOriginalFileName 
            = multiReq.getParameter("oldOriginalFileName"); //사용자 업로드한 파일명
        String oldRenamedFileName
            = multiReq.getParameter("oldRenamedFileName"); //실제 저장된 파일명
        
        /**
         * 게시글 수정
         * 1. 첨부파일이 있는 경우:
         *      - 새로운 첨부파일을 추가하는 경우: 기존 파일을 삭제, 새로운 파일정보 DB등록
         *      - 기존파일만 삭제하는 경우: 기존파일 삭제, DB데이터 null값 대입
         *      - 기존파일을 유지하는 경우: 기존파일 유지, DB데이터  기존값 유지
         * 2. 첨부파일이 없는 경우: 게시글 최초 등록과 동일
         */
        if(!"".equals(oldOriginalFileName)) {
            
            // 신규첨부파일 유무 검사: upFile파일 첨부가 없는 경우, null을 리턴
            File f = multiReq.getFile("upFile");
            
            // 신규첨부파일이 있는 경우, 기존 첨부파일 삭제
            if(f!=null) {
                File delFile = new File(saveDirectory, oldRenamedFileName);
                boolean result = delFile.delete();      
                System.out.println("기존 첨부파일 삭제: " + (result?"성공!":"실패!"));
                
            }
            // 신규 첨부파일이 없는 경우 : 기존파일 삭제
            else if(multiReq.getParameter("delFileChk")!=null){
                File delFile = new File(saveDirectory, oldRenamedFileName);
                boolean result = delFile.delete();      
                System.out.println("기존 첨부파일 삭제: " + (result?"성공!":"실패!"));
            }
            // 신규 첨부파일이 없는 경우 : 기존파일 유지
            else {
            	originalFileName = oldOriginalFileName;
            	renamedFileName = oldRenamedFileName;
            }
        }
        
        int boardNo= Integer.parseInt(multiReq.getParameter("boardNo"));
        String boardTitle = multiReq.getParameter("boardTitle");
        String boardWriter = multiReq.getParameter("boardWriter");
        String boardContent = multiReq.getParameter("boardContent");
        Board board = new BoardService().selectOne(boardNo);
        
        board.setBoardTitle(boardTitle);
        board.setBoardTitle(boardTitle);
        board.setBoardWriter(boardWriter);
        board.setBoardContent(boardContent);
        board.setOriginalFileName(originalFileName);
        board.setRenamedFileName(renamedFileName);
        
        System.out.println("수정한 게시글 : " + board);
        
        // 3. 서비스로직 호출
        int result = new BoardService().updateBoard(board);
        
        // 4. 뷰페이지 
        String view = "/WEB-INF/views/common/msg.jsp";
        String msg = "";
        String loc = "/board/boardView?boardNo="+boardNo;
        
		if(result>0) {
			msg = "게시글 수정 성공!";
		}
		else {
			msg = "게시글 수정 실패! 관리자에게 문의하세요.";
		}
		
        
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
