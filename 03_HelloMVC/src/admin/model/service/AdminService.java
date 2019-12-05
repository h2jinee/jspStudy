package admin.model.service;

import java.sql.Connection;
import java.util.List;

import admin.model.dao.AdminDAO;
import member.model.vo.Member;
import static common.JDBCTemplate.*;

public class AdminService {
	
    public List<Member> selectMemberList() {
        Connection conn = getConnection();
        List<Member> list= new AdminDAO().selectMemberList(conn);
        close(conn);
        return list;
    }

	public List<Member> selectMemberByMemberId(String searchKeyword) {
		List<Member> list = null;
		Connection conn = getConnection();
		list = new AdminDAO().selectMemberByMemberId(conn, searchKeyword);
		close(conn);
		return list;
	}

	public List<Member> selectMemberByMemberName(String searchKeyword) {
		List<Member> list = null;
		Connection conn = getConnection();
		list = new AdminDAO().selectMemberByMemberName(conn, searchKeyword);
		close(conn);
		return list;
	}

	public List<Member> selectMemberByGender(String searchKeyword) {
		List<Member> list = null;
		Connection conn = getConnection();
		list = new AdminDAO().selectMemberByGender(conn, searchKeyword);
		close(conn);
		return list;
	}

}
