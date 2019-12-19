package ajax.smart.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import ajax.smart.model.dao.SmartDAO;

/**
 * Servlet implementation class JQueryAjaxJSONServlet1
 */
@WebServlet("/smart/rankList")
public class AjaxRankListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxRankListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1.비지니스로직처리 : Smartphone 추가
		List<Map<String,Object>> list = new SmartDAO().selectRankList();
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,Object> map: list){
				JSONObject jsonSmart = new JSONObject();
				jsonSmart.put("pname", map.get("pname"));
				jsonSmart.put("total", map.get("total"));
				jsonSmart.put("rnum", map.get("rnum"));
				jsonArr.add(jsonSmart);
		}
		System.out.println("rankList="+jsonArr);
		
		//4.응답객체에 출력
		response.setContentType("application/json; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		out.print(jsonArr);
		
		//GSON 사용
//		new Gson().toJson(list, response.getWriter());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
