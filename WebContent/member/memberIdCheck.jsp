<%@ page import="java.sql.*, common.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberIdCheck</title>
</head>
<body>
	<%
	String id = request.getParameter("id");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from member where id=?";
	String idCheck = "0";
	try {
		conn = JDBCUtil.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		//아이디가 있으면 1. 없으면  0
		if(rs.next()) idCheck = "1";
		else session.setAttribute("useId", id);
		session.setAttribute("idCheck", idCheck);
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		JDBCUtil.close(conn, pstmt, rs);
	}
	
	response.sendRedirect("memberInsertForm.jsp");
	%>
</body>
</html>