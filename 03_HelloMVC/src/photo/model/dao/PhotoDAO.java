package photo.model.dao;

import java.io.File;
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

import photo.model.vo.Photo;

import static common.JDBCTemplate.*;


public class PhotoDAO {

	private Properties prop = new Properties();
	
	public PhotoDAO() {
		String fileName = getClass().getResource("/sql/photo/photo-query.properties")
									.getPath();
		try {
			
			prop.load(new FileReader(new File(fileName)));
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	
	public int selectPhotoCount(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String query = prop.getProperty("selectPhotoCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			if(rset.next())
				totalContent = rset.getInt("cnt");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContent;
	}
	
	 public List<Photo> selectPhotoMore(Connection conn, int cPage, int numPerPage) {
		List<Photo> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = prop.getProperty("selectPhotoMore");
		
		try{
			//미완성쿼리문을 가지고 객체생성. 
			pstmt = conn.prepareStatement(query);
			
			//시작 rownum과 마지막 rownum 구하는 공식
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			
			//쿼리문실행
			//완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			rset = pstmt.executeQuery();
			while(rset.next()){
				Photo p = new Photo();
				//컬럼명은 대소문자 구분이 없다.
				p.setPhotoNo(rset.getInt("photo_no"));
				p.setPhotoWriter(rset.getString("photo_writer"));
				p.setPhotoContent(rset.getString("photo_content"));
				p.setOriginalFileName(rset.getString("photo_original_filename"));
				p.setRenamedFileName(rset.getString("photo_renamed_filename"));
				p.setPhotoDate(rset.getDate("photo_date"));
				p.setReadCount(rset.getInt("photo_readcount"));
				list.add(p);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return list;
	}

}





