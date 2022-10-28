<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 입력몸(임시폼)</title>
</head>
<body>
	<h2>회원정보 입력폼(임시폼)</h2>
	<p>아이디와 비밀번호 입력</p>
	<form action="memberInfoForm.jsp" method="post">
		아이디: <input type="text" name="id">
		비밀번호: <input type="text" name="pwd">
		<input type="submit" value="전송">
	</form>

</body>
</html>