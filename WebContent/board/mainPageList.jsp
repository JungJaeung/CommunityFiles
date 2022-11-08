<%@ page import="java.sql.*, common.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 메인 홈페이지</title>
<style>
	#container { margin: 0 auto; width: 1000px;}
	
</style>
</head>
<%request.setCharacterEncoding("utf-8"); %>
<body>
	<div id="container">
		<h2>게시판 메인 페이지 글 조회페이지</h2>
		<ul>
			<li><a>게시판의 내용이 여기에 표시됩니다.</a></li>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select name, title, writeDate from boardList";
	
	try {
		conn = JDBCUtil.getConnection();
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			int listId = rs.getInt("listId");
			String name = rs.getString("name");
			String title = rs.getString("title");
			String writeTime = rs.getString("writeDate");
			//해당 글에 해당하는 데이터의 정보를 다음 페이지에서 쓸수 있게 가져가야함.
			out.print("<li><form action='selectedWriteList.jsp' method='post'><a href='#'>" + name +  "&emsp;&emsp;:&emsp;&emsp;" + title + "&emsp;&emsp;:&emsp;&emsp;" +  writeTime + "</a></form></li>");
			out.print("");
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		JDBCUtil.close(conn, pstmt, rs);
	}
%>
		</ul>
	</div>
</body>
</html>