package member.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import static common.JDBCTemplate.*;

import member.model.vo.Member;

public class MemberDAO {
	private Properties prop = new Properties();
	
	public MemberDAO() {
		String fileName = MemberDAO.class.getResource("/query.properties")
										 .getPath();
		
		try {
			prop.load(new FileReader(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public Member selectOne(Connection conn, String memberId) {
		Member m = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = prop.getProperty("selectOne");
		
		try {
			//1. Statement객체생성
			pstmt = conn.prepareStatement(query); //미완성 쿼리 전달
			
			//2. 미완성 쿼리 값대입
			pstmt.setString(1, memberId);
			
			//3. 쿼리실행 => ResultSet
			rset = pstmt.executeQuery();
			
			//4. ResultSet => Member
			if(rset.next()) {
				m = new Member();
				m.setMemberId(rset.getString("memberid")); //대소문자 구분 x
				m.setPassword(rset.getString("password"));
				m.setMemberName(rset.getString("MemberName"));
				m.setGender(rset.getString("Gender"));
				m.setAge(rset.getInt("age")); //숫자형
				
				m.setEmail(rset.getString("email"));
				m.setPhone(rset.getString("phone"));
				m.setAddress(rset.getString("address"));
				m.setHobby(rset.getString("hobby"));
				m.setEnrollDate(rset.getDate("enrolldate")); //날짜형
			}
			
			System.out.println("member@dato.selectOne="+m);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		//5. 자원반납
		return m;
		
	}
	
}
