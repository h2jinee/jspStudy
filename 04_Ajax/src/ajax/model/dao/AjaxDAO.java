package ajax.model.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AjaxDAO {
	public List<String> selectByName(String srchName) {
		List<String> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "SELECT * FROM CLASSMATE WHERE NAME LIKE ?";
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "web", "web");
			//미완성쿼리문을 가지고 객체생성함
			pstmt = conn.prepareStatement(query);
			//쿼리문 완성작업
			pstmt.setString(1, "%"+srchName+"%");
			//쿼리문실행
			//pstmt에 이제 완성된 쿼리를 가지고 있기때문에 파라미터없이 실행한다.
			rset = pstmt.executeQuery();
			list = new ArrayList<>();
			while(rset.next()){
				list.add(rset.getString("name"));
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