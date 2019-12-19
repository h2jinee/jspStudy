package photo.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import photo.model.service.PhotoService;
import photo.model.vo.Photo;

/**
 * Servlet implementation class PhotoMoreServlet
 */
@WebServlet("/photo/photoMore")
public class PhotoMoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PhotoMoreServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.parameterHandling
		int cPage = Integer.parseInt(request.getParameter("cPage"));
		final int numPerPage = 5;
		
		//2.businessLogic
		List<Photo> list = new PhotoService().selectPhotoMore(cPage, numPerPage);
		 
		//3.view단처리: json
		JSONArray jsonArray = new JSONArray();
		for(Photo p : list) {
			JSONObject jsonPhoto = new JSONObject();
			jsonPhoto.put("photoNo", p.getPhotoNo());
			jsonPhoto.put("photoWriter", p.getPhotoWriter());
			jsonPhoto.put("photoContent", p.getPhotoContent());
			jsonPhoto.put("originalFileName", p.getOriginalFileName());
			jsonPhoto.put("renamedFileName", p.getRenamedFileName());
			jsonPhoto.put("photoDate", p.getPhotoDate().toString());//toString호출하지 않으면 클라이언트에서 json parsing 오류남.
			jsonPhoto.put("readCount", p.getReadCount());
			jsonArray.add(jsonPhoto);
		}
		System.out.println(jsonArray);
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(jsonArray);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
