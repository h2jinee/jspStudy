package ajax.jquery.json;

import java.io.IOException;
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
 * Servlet implementation class JqueryAjaxJsonMemberSelectAllServlet
 */
@WebServlet("/jquery/json/member/selectAll")
public class JqueryAjaxJsonMemberSelectAllServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqueryAjaxJsonMemberSelectAllServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. 업무로직
		List<Member> list = MemberSingletone.getInstance()
											.getList();
//		List<Member> list2 = MemberSingletone.getInstance()
//											 .getList();
//		System.out.println(list == list2);
//		System.out.println(list.hashCode());
//		System.out.println(list2.hashCode());
		
		//JSONObject : HashMap 상속
		//JSONArray : ArrayList를 상속
		JSONArray jsonArray = new JSONArray();
		
		for(Member m : list) {
			JSONObject jsonMember = new JSONObject();
			jsonMember.put("name", m.getName());
			jsonMember.put("phone", m.getPhone());
			jsonMember.put("profile", m.getProfile());
			//System.out.println(jsonMember);
			
			//jsonArray에 추가
			jsonArray.add(jsonMember);
		}
		System.out.println(jsonArray);
		
		//2. view단 처리 : json문자열을 출력하기
		//인코딩과 mime타입 설정 필수
		response.setContentType("application/json; charset=utf-8"); 
		response.getWriter().append(jsonArray.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
