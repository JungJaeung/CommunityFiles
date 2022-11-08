<%@ page import="java.sql.*, common.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 내용 자세하게 보기</title>
<style>
	#container { margin: 0 auto; width: 1000px;}
</style>
</head>
<body>
	<div id="container">
<%
	String listId = request.getParameter("listId");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from BoardList where listId = ?";
	
	try{
		conn = JDBCUtil.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, listId);
		rs = pstmt.executeQuery();
		String name = null;
		String title = null;
		String list = null;
		String writeDate = null;
		if(rs.next()) {
			name = rs.getString("name");
			title = rs.getString("title");
			list = rs.getString("list");
			writeDate = rs.getString("writeDate");
		}
		out.print("<ul><li> " + name + "</li>");
		out.print("<li> " + title + "</li>");
		out.print("<li> " + list + "</li>");
		out.print("<li> " + writeDate + "</li></ul>");
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		JDBCUtil.close(conn, pstmt, rs);
	}
%>
	</div>
</body>
</html>