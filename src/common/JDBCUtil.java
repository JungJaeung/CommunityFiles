package common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JDBCUtil {
	//커넥션을 사용하여 커넥션을 획득
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource)envCtx.lookup("jdbc/test01");
			
			System.out.println("Connection Pool 연결 성공");
			conn = ds.getConnection();
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("Connection Pool 연결 실패");
		}
		return conn;
	}
	//커넥션을 해제하는 클래스
	
	//커넥션 객체 해제 - conn, pstmt, rs -> select문일 때 사용
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) throws Exception {
		if(rs != null) {
			try {
				rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(conn != null) {
			try {
				conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	//커넥션 객체 해제 - conn, pstmt -> 나머지 insert, delete, update문일 때 사용
	public static void close(Connection conn, PreparedStatement pstmt) throws Exception {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(conn != null) {
			try {
				conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	//커넥션을 해제하지 않고, 다음 sql문을 세팅할 메소드
	public static void close(PreparedStatement pstmt, ResultSet rs) throws Exception {
		if(rs != null) {
			try {
				rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
}
