package product.model.service;
import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import common.JDBCTemplate;
import product.model.dao.ProductDAO;
import product.model.exception.ProductException;
import product.model.vo.Product;
import product.model.vo.ProductIO;

public class ProductService {
	public List<ProductIO> selectIOListByPId(String productId) throws ProductException{
		List<ProductIO> ioList = null;
		Connection conn = getConnection();
		ioList = new ProductDAO().selectIOListByPId(conn, productId);
		close(conn);
		return ioList;
	}

	public int insertProduct_IO(ProductIO pio) throws ProductException {
		Connection conn = getConnection();
		
		//출고시, 출고량과 재고량을 비교한다.
		if("O".equals(pio.getStatus())) {
			Product p = new ProductDAO().selectOne(conn, pio.getProductId());
			//재고량이 출고량보다 적다면, 0을 리턴함.
			if(p.getStock()<pio.getAmount())
				return 0;
		}
		
		int result = new ProductDAO().insertProduct_IO(conn, pio);
		
		if(result>0) commit(conn);
		else rollback(conn);
		
		close(conn);
		return result;
	}

	public List<Product> selectProductList() throws ProductException {
		Connection conn = getConnection();
		List<Product> list = new ProductDAO().selectProductList(conn);
		close(conn);
		return list;
	}

	public List<ProductIO> selectProductIOList() throws ProductException {
		Connection conn = getConnection();
		List<ProductIO> list = new ProductDAO().selectProductIOList(conn);
		close(conn);
		return list;
	}

	public Product selectOne(String productId) throws ProductException{
		Connection conn = getConnection();
		Product p = new ProductDAO().selectOne(conn, productId);
		close(conn);
		return p;
	}

	public List<Product> selectByPName(String pName) throws ProductException{
		Connection conn = getConnection();
		List<Product> list = new ProductDAO().selectByPName(conn,pName);
		close(conn);
		return list;
	}

	public int insertProduct(Product p) throws ProductException {
		Connection conn = getConnection();
		int result = new ProductDAO().insertProduct(conn, p);
		
		//트랜잭션 처리
		if(result>0) commit(conn);
		else rollback(conn);
		
		return result;
	}

	public int updateProduct(Product p) throws ProductException {
		Connection conn = getConnection();
		int result = new ProductDAO().updateProduct(conn, p);
		
		//트랜잭션 처리
		if(result>0) commit(conn);
		else rollback(conn);
		
		return result;
	}

	public int deleteProduct(String productId) throws ProductException{
		Connection conn = getConnection();
		int result = new ProductDAO().deleteProduct(conn, productId);
		
		//트랜잭션 처리
		if(result>0) commit(conn);
		else rollback(conn);
		
		return result;
	}
}
