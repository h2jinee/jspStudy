package admin.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import static common.JDBCTemplate.*;

import member.model.vo.Member;

public class AdminDAO {
	
	private Properties prop = new Properties();
	
    public AdminDAO(){
        try {
            //클래스객체 위치찾기 : 절대경로를 반환한다. 
            String fileName = AdminDAO.class.getResource("/sql/admin/admin-query.properties").getPath();
            prop.load(new FileReader(fileName));
            
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public List<Member> selectMemberList(Connection conn) {
        List<Member> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        
        String query = prop.getProperty("selectMemberList");
        
        try{
            //미완성쿼리문을 가지고 객체생성. 
            pstmt = conn.prepareStatement(query);
            
            //쿼리문실행
            //완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
            rset = pstmt.executeQuery();
            
            while(rset.next()){
                Member m = new Member();
                //컬럼명은 대소문자 구분이 없다.
                m.setMemberId(rset.getString("MEMBERID"));
                m.setPassword(rset.getString("PASSWORD"));
                m.setMemberName(rset.getString("MEMBERNAME"));
                m.setGender(rset.getString("GENDER"));
                m.setAge(rset.getInt("AGE"));
                m.setEmail(rset.getString("EMAIL"));
                m.setPhone(rset.getString("PHONE"));
                m.setAddress(rset.getString("ADDRESS"));
                m.setHobby(rset.getString("HOBBY"));
                m.setEnrollDate(rset.getDate("ENROLLDATE"));
                
                list.add(m);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            close(rset);
            close(pstmt);
        }
        
        
        return list;
    }

	public List<Member> selectMemberByMemberId(Connection conn, String searchKeyword) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Member> list = null;
		String query = prop.getProperty("selectMemberByMemberId");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "%"+searchKeyword+"%");
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			while(rset.next()){
                Member m = new Member();
                //컬럼명은 대소문자 구분이 없다.
                m.setMemberId(rset.getString("MEMBERID"));
                m.setPassword(rset.getString("PASSWORD"));
                m.setMemberName(rset.getString("MEMBERNAME"));
                m.setGender(rset.getString("GENDER"));
                m.setAge(rset.getInt("AGE"));
                m.setEmail(rset.getString("EMAIL"));
                m.setPhone(rset.getString("PHONE"));
                m.setAddress(rset.getString("ADDRESS"));
                m.setHobby(rset.getString("HOBBY"));
                m.setEnrollDate(rset.getDate("ENROLLDATE"));
                
                list.add(m);
            }
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		
		return list;
	}

	public List<Member> selectMemberByMemberName(Connection conn, String searchKeyword) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Member> list = null;
		String query = prop.getProperty("selectMemberByMemberName");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "%"+searchKeyword+"%");
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			while(rset.next()){
                Member m = new Member();
                //컬럼명은 대소문자 구분이 없다.
                m.setMemberId(rset.getString("MEMBERID"));
                m.setPassword(rset.getString("PASSWORD"));
                m.setMemberName(rset.getString("MEMBERNAME"));
                m.setGender(rset.getString("GENDER"));
                m.setAge(rset.getInt("AGE"));
                m.setEmail(rset.getString("EMAIL"));
                m.setPhone(rset.getString("PHONE"));
                m.setAddress(rset.getString("ADDRESS"));
                m.setHobby(rset.getString("HOBBY"));
                m.setEnrollDate(rset.getDate("ENROLLDATE"));
                
                list.add(m);
            }
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		
		return list;
	}

	public List<Member> selectMemberByGender(Connection conn, String searchKeyword) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Member> list = null;
		String query = prop.getProperty("selectMemberByGender");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, searchKeyword);
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			while(rset.next()){
                Member m = new Member();
                //컬럼명은 대소문자 구분이 없다.
                m.setMemberId(rset.getString("MEMBERID"));
                m.setPassword(rset.getString("PASSWORD"));
                m.setMemberName(rset.getString("MEMBERNAME"));
                m.setGender(rset.getString("GENDER"));
                m.setAge(rset.getInt("AGE"));
                m.setEmail(rset.getString("EMAIL"));
                m.setPhone(rset.getString("PHONE"));
                m.setAddress(rset.getString("ADDRESS"));
                m.setHobby(rset.getString("HOBBY"));
                m.setEnrollDate(rset.getDate("ENROLLDATE"));
                
                list.add(m);
            }
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		
		return list;
	}

}
