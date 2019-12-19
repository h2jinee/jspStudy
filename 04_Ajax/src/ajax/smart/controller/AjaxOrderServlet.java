package ajax.smart.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ajax.smart.model.dao.SmartDAO;
import ajax.smart.model.vo.Smartphone;

/**
 * Servlet implementation class AjaxTestOrderServlet
 */
@WebServlet("/smart/order")
public class AjaxOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxOrderServlet() {
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
		String pname = request.getParameter("pname");
		int amount = Integer.parseInt(request.getParameter("amount"));
		System.out.println("주문내역 ["+pname+", "+amount+"]");
		//3.비지니스로직처리
		int result  = new SmartDAO().insertOrder(new Smartphone(pname, amount, null));
		System.out.println(result>0?"주문완료!":"주문실패!");
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
