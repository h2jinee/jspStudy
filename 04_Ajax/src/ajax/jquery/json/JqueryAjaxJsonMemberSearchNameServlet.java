package ajax.jquery.json;

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

import common.MemberSingletone;
import member.model.vo.Member;

/**
 * Servlet implementation class JQueryAjaxJSONServlet1
 */
@WebServlet("/jquery/json/member/searchName")
public class JqueryAjaxJsonMemberSearchNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqueryAjaxJsonMemberSearchNameServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.요청 인코딩처리
		request.setCharacterEncoding("utf-8");
		
		//2.파라미터값  가져오기
		String srchName = request.getParameter("srchName");
		
		//3.비지니스로직처리 : 해당하는 User찾기
		List<Member> list = MemberSingletone.getInstance().getList();
		
		JSONArray jsonArray = new JSONArray();
		
		for(Member m : list) {
			System.out.println(m);
			System.out.println(m.getName());
			if(m.getName().contains(srchName)) {
				JSONObject jsonMember = new JSONObject();
				jsonMember.put("name", m.getName());
				jsonMember.put("phone", m.getPhone());
				jsonMember.put("profile", m.getProfile());
				jsonArray.add(jsonMember);
			}
		}
		System.out.println(jsonArray);
		
		//4.응답객체에 출력
		response.setContentType("application/json; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		out.print(jsonArray);		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
