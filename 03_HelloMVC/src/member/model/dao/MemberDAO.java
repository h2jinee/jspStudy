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
	

	public int insertMember(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("insertMember"); 
		
		try {
			//미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(query);
			//쿼리문미완성
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getMemberName());
			pstmt.setString(4, member.getGender());
			pstmt.setInt(5, member.getAge());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getPhone());
			pstmt.setString(8, member.getAddress());
			pstmt.setString(9, member.getHobby());
			
			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			//DML은 executeUpdate()
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int updateMember(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("updateMember");
		
		try {
			
			//1. 미완성쿼리문을 가지고 PreparedStatement객체생성
			pstmt = conn.prepareStatement(query);
			//객체생성후 ? 부분 값대입.
//			pstmt.setString(2, member.getPassword());
			pstmt.setString(1, member.getMemberName());
			pstmt.setString(2, member.getGender());
			pstmt.setInt(3, member.getAge());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getAddress());
			pstmt.setString(7, member.getHobby());
			pstmt.setString(8, member.getMemberId());
			
			//2. 쿼리문 실행, 실행결과 받기
			result = pstmt.executeUpdate();
			
			System.out.println(result);
			
		} catch (Exception e) {
			e.printStackTrace();//콘솔로깅용으로 남겨둠
			//사용자 정의 예외 던짐.
			//throw new MemberException("updateMember 메소드 에러! : "+e.getMessage());
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int deleteMember(Connection conn, String memberId) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("deleteMember");
		
		try {
			
			//1. 미완성쿼리문을 가지고 PreparedStatement객체생성
			pstmt = conn.prepareStatement(query);
			//객체생성후 ? 부분 값대입.
			pstmt.setString(1, memberId);

			//2. 쿼리문 실행, 실행결과 받기
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();//콘솔로깅용으로 남겨둠
			//사용자 정의 예외 던짐.
			//throw new ProductException("deleteProduct 메소드 에러! : "+e.getMessage());
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	

	public int updatePassword(Connection conn, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("updatePassword"); 

		try {
			//미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(query);
			//쿼리문미완성
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getMemberId());
			
			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			//DML은 executeUpdate()
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
