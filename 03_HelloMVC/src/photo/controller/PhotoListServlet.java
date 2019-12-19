package photo.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import photo.model.service.PhotoService;
/**
 * Servlet implementation class PhotoListServlet
 */
@WebServlet("/photo/photoList")
public class PhotoListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PhotoListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			//전체게시물수, 한페이지당 표시할 게시물수 => 총페이지수
			int totalContent = new PhotoService().selectPhotoCount();
			final int numPerPage = 5;
			//총페이지수: 올림처리
			int totalPage = (int)(Math.ceil((double)totalContent/numPerPage));
			System.out.println("totalContent="+totalContent);
			System.out.println("totalPage="+totalPage);
			request.setAttribute("totalPage", totalPage);
			request.getRequestDispatcher("/WEB-INF/views/photo/photoList.jsp")
				   .forward(request, response);
		} catch(Exception e) {
			throw e; // 컨테이너한테 예외를 던져야 에러페이지 전환이 가능하다.
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}