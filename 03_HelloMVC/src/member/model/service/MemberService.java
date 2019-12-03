package member.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;

import member.model.dao.MemberDAO;
import member.model.exception.MemberException;
import member.model.vo.Member;

public class MemberService {

	public Member selectOne(String memberId) {
		Connection conn = getConnection();
		
		Member m = new MemberDAO().selectOne(conn, memberId);
		
		close(conn);
		
		return m;
	}
	
	public int insertMember(Member member) {
		Connection conn = getConnection();
		int result = new MemberDAO().insertMember(conn, member);
		if(result>0)
			commit(conn);
		else 
			rollback(conn);
		close(conn);
		return result;
	}
	
	public int deleteMember(String memberId) throws MemberException{
		Connection conn = getConnection();
		int result = new MemberDAO().deleteMember(conn, memberId);
		
		//트랜잭션 처리
		if(result>0) commit(conn);
		else rollback(conn);
		
		return result;
	}
	
	public int updateMember(Member member) throws MemberException {
		Connection conn = getConnection();
		int result = new MemberDAO().updateMember(conn, member);
		
		//트랜잭션 처리
		if(result>0) commit(conn);
		else rollback(conn);
		
		return result;
	}

}
