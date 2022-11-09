<%@ page import="java.sql.*, common.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>
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
		//메인 페이지로 돌아가기
		let mainBtn = document.querySelector("#mainBtn");
		mainBtn.addEventListener("click", function(event) {
			history.back();
		})
		//작성한 내용 처리 버튼
		let completeBtn = document.querySelector("#completeBtn");
		completeBtn.addEventListener("click", function(event) {
			let form = document.newList;
			form.submit();
		})
	})
</script>
</head>
<%
request.setCharacterEncoding("utf-8"); 
System.out.println((String)session.getAttribute("memberId") + ", " + (String)session.getAttribute("memberPwd"));

String sql = "select name from member where id=?";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String name = null;

try {
	conn = JDBCUtil.getConnection();
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, (String)session.getAttribute("memberId"));
	rs = pstmt.executeQuery();
	
	if(rs.next()) {
		name = rs.getString("name");
	}
} catch(Exception e) {
	e.printStackTrace();
} finally {
	JDBCUtil.close(conn, pstmt, rs);
}
%>
<body>
	<div id="container">
		<form action="writeNewListPro.jsp" method="post" name="newList">
			<h2>게시글 작성하기</h2>
			<label id="name">작성자 : </label><input type="text" name="name" value="<%=name %>" readonly>
			<span id="title">제목 : </span><input type="text" name="title" id="title"><br>
			<label id="list">글 내용 : </label><textarea cols="50" rows="10" name="list"></textarea><br>
			<button id="completeBtn">작성 완료</button>&emsp;
			<button id="mainBtn">메인 버튼 이동 버튼</button>&emsp;
		</form>
	</div>
</body>
</html>