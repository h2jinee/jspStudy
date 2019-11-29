package board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/*
 * servlet3.x부터 지원하는 어노테이션 등록방식
 */
//HttpServlet은 Apache Tomcat에 있기 때문에 언바운드되거나 import가 되지 않을 경우 이 곳에서 문제가 발생한 것

@WebServlet("/member/loginCheck")
public class MemberLoginCheckServlet extends HttpServlet {
    
    public void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException{
        
        // 1. encoding
        request.setCharacterEncoding("utf-8");
        // 2. parameter
        String memberId = request.getParameter("memberId");
        String password = request.getParameter("password");
        System.out.println("memberId =" + memberId);
        System.out.println("password =" + password);
        
        // 3. businessLogic
        Member m = new MemberService().selectOne(memberId);
        
        //아이디가 존재하지 않는 경우
        if(m == null) {
        	
        }
        else {
        	//사용자입력비번과 db회원정보비번 비교
        	//비번이 틀린 경우 => 로그인 실패
        	if(m.getPassword().equals(password)) {
        		
        	}
        	//아이디/비번이 모두 일치한 경우 => 로그인 성공
        	else {
        		
        	}
        }
        
        // 4. view
        
    }
    
    public void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException{
        doPost(request, response);
    }
}