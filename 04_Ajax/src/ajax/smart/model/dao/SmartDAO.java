package ajax.smart.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ajax.smart.model.vo.Smartphone;


public class SmartDAO {
	
	public int insertOrder(Smartphone s) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO SMARTPHONE VALUES(?,?,DEFAULT)";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "web", "web");

			//미완성쿼리문을 가지고 객체생성함
			pstmt = conn.prepareStatement(query);
			//쿼리문 완성작업
			pstmt.setString(1,s.getPname());
			pstmt.setInt(2,s.getAmount());
			
			//쿼리문실행
			//pstmt에 이제 완성된 쿼리를 가지고 있기때문에 파라미터없이 실행한다.
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		return result;
	}


	public List<Smartphone> selectOrderList() {
		List<Smartphone> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * \n"+
						"from (\n"+
						"select * \n"+
						"from smartphone\n"+
						"order by pdate desc) A\n"+
						"where rownum between 1 and 5";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "web", "web");
			
			//미완성쿼리문을 가지고 객체생성함
			pstmt = conn.prepareStatement(query);
			
			//쿼리문실행
			//pstmt에 이제 완성된 쿼리를 가지고 있기때문에 파라미터없이 실행한다.
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			
			while(rset.next()){
				Smartphone s = new Smartphone();
				s.setPname(rset.getString("pname"));
				s.setAmount(rset.getInt("amount"));
				s.setPdate(rset.getDate("pdate"));
				list.add(s);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rset.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;

	}

	public List<Map<String, Object>> selectRankList() {
		List<Map<String, Object>> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select A.*, rownum as rnum\n"+
						"from ( \n"+
						"select pname\n"+
						"      ,sum(amount) total\n"+
						"from smartphone\n"+
						"group by pname\n"+
						"order by total desc) A \n"+
						"where rownum between 1 and 5";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "web", "web");
			
			//미완성쿼리문을 가지고 객체생성함
			pstmt = conn.prepareStatement(query);
			
			//쿼리문실행
			//pstmt에 이제 완성된 쿼리를 가지고 있기때문에 파라미터없이 실행한다.
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			
			while(rset.next()){
				Map<String, Object> map = new HashMap<>();
				map.put("pname", rset.getString("pname"));
				map.put("total", rset.getString("total"));
				map.put("rnum", rset.getString("rnum"));
				list.add(map);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rset.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}

}
