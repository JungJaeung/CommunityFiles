<%@ page import="java.sql.*, common.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 내용 자세하게 보기</title>
<style>
	#container { margin: 0 auto; width: 800px;}
	#name { font-size: 1.1em;}
	#title { float: left;}
	#date { float: right;}
	#list { clear: both; border: 1px solid black;}
	#mainBtn { 
		background-color: black; color: white;
		cursor: pointer;
	}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let mainBtn = document.querySelector("#mainBtn");
		mainBtn.addEventListener("click", function(event) {
			history.back();
		})
	})
</script>
</head>
<body>
<%
	String listId = request.getParameter("listId");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from BoardList where listId = ?";
	
	String name = null;
	String title = null;
	String list = null;
	String writeDate = null;
	
	try{
		conn = JDBCUtil.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, listId);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			name = rs.getString("name");
			title = rs.getString("title");
			list = rs.getString("list");
			writeDate = rs.getString("writeDate");
		}
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		JDBCUtil.close(conn, pstmt, rs);
	}
%>
	<div id="container">
		<h2>게시글 상세 내용</h2>
		<h2 id="name">작성자 : <%=name %></h2>
		<span id="title">제목 : <%=title %></span><span id="date">작성 날짜: <%=writeDate %></span>
		<p id="list"><%=list %></p>
		<button id="mainBtn">메인 버튼 이동 버튼</button>
	</div>
</body>
</html>