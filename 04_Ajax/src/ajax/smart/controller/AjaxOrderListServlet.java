package ajax.smart.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import ajax.smart.model.dao.SmartDAO;
import ajax.smart.model.vo.Smartphone;

/**
 * Servlet implementation class JQueryAjaxJSONServlet1
 */
@WebServlet("/smart/orderList")
public class AjaxOrderListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxOrderListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1.비지니스로직처리 : Smartphone 추가
		List<Smartphone> list = new SmartDAO().selectOrderList();
		
		JSONArray jsonArr = new JSONArray();
		for(Smartphone s: list){
				JSONObject jsonSmart = new JSONObject();
				jsonSmart.put("pname", s.getPname());
				jsonSmart.put("amount", s.getAmount());
				jsonSmart.put("pdate", s.getPdate().toString());
				//명시적으로 toString()을 호출하지 않으면, "pdate":2018-04-21 로 처리되어 view단 에러유발
				//parsererror
				//index.jsp:87 SyntaxError: Unexpected number in JSON at position 41
				jsonArr.add(jsonSmart);
		}
		System.out.println("orderList="+jsonArr);
		
		
		//4.응답객체에 출력
		response.setContentType("application/json; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		out.print(jsonArr.toJSONString());
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
