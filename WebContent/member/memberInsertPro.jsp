<%@ page import="java.sql.*, common.JDBCUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리 페이지</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	<%--자바빈을 사용해 데이터를 한꺼번에 받아온다. --%>
	<jsp:useBean id="member" class="member.Member"></jsp:useBean>
	<jsp:setProperty property="*" name="member"/>
	
	<% 
	//DB 연결 객체
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql1 = "select * from member where id=?";
	
	String sql2 = "insert into member(id, pwd, name, gender, age, email, tel, address1, address2)";
	sql2 +=	" values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
	int cnt = 0;
	try {
		conn = JDBCUtil.getConnection();

		pstmt = conn.prepareStatement(sql1);
		pstmt.setString(1, member.getId());
		rs = pstmt.executeQuery();
		if(rs.next()) {	//아이디가 있을 때
			out.print("<script>alert(`이미 사용중인 아이디 입니다.\n다른 아이디를 입력하세요.`);history.back();</script>");
		} else { // 아이디가 없을 때
			JDBCUtil.close(pstmt, rs);	//커넥션은 유지하고, 사용하지 않는 sql문과 결과를 정리
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getGender());
			pstmt.setInt(5, member.getAge());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getTel());
			pstmt.setString(8, member.getAddress1());
			pstmt.setString(9, member.getAddress2());
			cnt = pstmt.executeUpdate();
		}
		if(cnt > 0) out.print("회원 가입이 성공하였습니다."); 
		else out.print("회원 가입이 실패하였습니다.");
	} catch(Exception e	) {
		e.printStackTrace();
		System.out.println("회원가입 실패");
	} finally {
		JDBCUtil.close(conn, pstmt, rs);
	}
	%>
</body>
</html>