package ajax.jquery.json;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import common.MemberSingletone;
import member.model.vo.Member;

/**
 * Servlet implementation class JqueryAjaxJsonMemberInsertServlet2
 */
@WebServlet("/jquery/json/member/insertMember2")
public class JqueryAjaxJsonMemberInsertServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqueryAjaxJsonMemberInsertServlet2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. encoding
		request.setCharacterEncoding("utf-8");
		
		//2. parameter handling
		String jsonMember = request.getParameter("jsonMember");
		System.out.println(jsonMember);
		
		JSONParser jsonParser = new JSONParser();
		JSONObject obj = null;
		
		try {
			obj = (JSONObject)jsonParser.parse(jsonMember);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String name = (String)obj.get("name");
		String phone = (String)obj.get("phone");
		String profile = (String)obj.get("profile");
		
		//3. business logic
		List<Member> list = MemberSingletone.getInstance().getList();
//		list.add(new Member(name, phone, profile));
		boolean result = list.add(new Member(name, phone, profile));
		JSONObject resultObj = new JSONObject();
		resultObj.put("result", result);
		
		//4. view단 처리
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(resultObj);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
