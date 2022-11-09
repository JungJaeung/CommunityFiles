<%@ page import="java.sql.*, common.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 게시</title>
</head>
<%
request.setCharacterEncoding("utf-8");
System.out.println((String)session.getAttribute("memberId") + ", " + (String)session.getAttribute("memberPwd"));
%>
<body>
	<jsp:useBean id="boardInfo" class="board.BoardList"></jsp:useBean>
	<jsp:setProperty property="*" name="boardInfo"/>
<%
Connection conn = null;
PreparedStatement pstmt = null;

String sql = "insert into boardList(id, name, title, list) values(?, ?, ?, ?)";

try {
	conn = JDBCUtil.getConnection();
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, (String)session.getAttribute("memberId"));
	pstmt.setString(2, boardInfo.getName());
	pstmt.setString(3, boardInfo.getTitle());
	pstmt.setString(4, boardInfo.getList());
	int cnt = pstmt.executeUpdate();
	if(cnt > 0) {
		out.print("<script>alert('게시글이 작성되었습니다.');</script>");
		out.print("<script>window.location.href = 'mainPageList.jsp';</script>");
	} else {
		out.print("<script>alert('작업이 취소되거나, 실패하였습니다.');history.back();</script>");
	}
} catch(Exception e) {
	e.printStackTrace();
} finally {
	JDBCUtil.close(conn, pstmt);
}
%>
	
</body>
</html>