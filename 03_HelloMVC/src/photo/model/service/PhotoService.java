package photo.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import photo.model.dao.PhotoDAO;
import photo.model.vo.Photo;


public class PhotoService {

	public int selectPhotoCount() {
		Connection conn = getConnection();
		int totalContent = new PhotoDAO().selectPhotoCount(conn);
		close(conn);
		return totalContent;
	}
	
	public List<Photo> selectPhotoMore(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<Photo> list = new PhotoDAO().selectPhotoMore(conn, cPage, numPerPage);
		close(conn);
		return list;
	}

}
