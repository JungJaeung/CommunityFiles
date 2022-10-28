<%@page import="member.Member"%>
<%@ page import="java.sql.*, common.JDBCUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Gugi&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Gugi&family=Hahmlet&display=swap');
	h2 {font-family: 'Gugi', cursive;}
	h1 {font-family: 'Hahmlet', serif;}
	h1, h2 {text-align: center;}
	#container { width: 600px; margin: 0 auto;}
	table { width: 100%; border: 1px solid black; border-collapse: collapse;}
	tr { height: 40px;}
	td, th { border: 1px solid black;}
	td {padding-left: 10px;}
	input[type="text"], input[type="password"] { padding-left: 10px; height: 20px;}
	/* 아이디 필드 */
	tr:first-child { height: 80px;}
	
	<%-- 이메일, 비밀번호, 전화번호 -> 유효성 체크 --%>
	tr:nth-child(2), tr:nth-child(3), tr:nth-child(7), tr:nth-child(8) { height: 60px;}
	.s_pwd, .s_pwd2, .s_email, .s_tel { font-size: 0.9em;}
	
	/* 주소 필드 */ 
	tr:nth-child(9) { height: 90px;}
	tr:nth-child(9)	input { margin: 3px 0;}
	tr:nth-child(9) #btnAddress { width: 100px; height: 30px;
	background-color: #adb5db; color: white; border: none; border-radius: 3px; cursor: pointer;}

	/*회원가입 버튼 필드*/
	tr:last-child input { width: 120px; height: 40px;
	background-color: black; color: white; border-radius: 5px; font-size: 0.9em; font-weight: bold;}
	tr:last-child { text-align: center;}
	tr:last-child td { padding: 10px 0;}
</style>
<!-- 다음에서 제공하는 주소 찾기 라이브러리 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.infoForm;
		//중복 아이디 체크 - DB 테이블 확인
		let btnIdCheck = document.getElementById("btnIdCheck");
		btnIdCheck.addEventListener("click", function(event) {
			if(form.id.value.length < 8) {
				alert("아이디는 8글자 이상 입력하시오.");
				form.id.focus();
			} else {
				form.action = 'memberIdCheck.jsp';
				form.submit();
			}
		})
		/*
		정규표현식
		^: 처음글자를  일치
		[0-9a-zA-Z] -> 숫자, 영어소문자, 영어대문자만 허용하고,
		? : 해당 ?기호 앞의 문자는 한개 혹은 없어야함. 2개이상일 경우 false
		* : 해당 *기호 앞에 해당 문자가 있을 경우
		$ : 끝이라는 표현
		*/
		
		//비밀번호 유효성 검사
		let pwd = document.getElementById("pwd");
		let s_pwd = document.querySelector(".s_pwd");
		//길이 범위 : 8~20, 숫자, 영어소문자, 영어대문자, 특수기호 특수기호(!@#$%^&*) 중 1개는 포함
		//let regex_pwd = /^([0-9a-zA-Z!@#$%^&*]){8,20}$/;
		let regex_pwd2 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$/;
		pwd.addEventListener("keyup", function() { 
			if(regex_pwd2.test(pwd.value)) {
				s_pwd.textContent = "비밀번호 형식이 맞습니다.";
				s_pwd.style.color = "blue";
			} else {
				s_pwd.textContent = "비밀번호 형식이 맞지 않습니다.";
				s_pwd.style.color = "red";
			}
		})
		
		//비밀번호 확인 검사
		let pwd2 = document.getElementById("pwd2");
		let s_pwd2 = document.querySelector(".s_pwd2");
		pwd2.addEventListener("keyup", function() {
			if(pwd.value== pwd2.value) {
				s_pwd2.textContent = "비밀번호가 일치합니다.";
				s_pwd2.style.color = "blue";
			} else {
				s_pwd2.textContent = "비밀번호가 일치하지 않습니다. ";
				s_pwd2.style.color = "red";
			}
		})
		//이메일 유효성 검사
		let f_email = false;
		let email = document.getElementById("email");
		let s_email = document.querySelector(".s_email");
		//let regex_email = /[\d-\D]\@\D/;
		//처음은 영어숫자만 나오고, @앞에 비면 안되고, -_.은 연속으로 사용하지 않으며, 영어숫자를 사용하고, 
		//.앞에 아무것도 없으면 안되며, .뒤에는 2자리3자리는 입력해야함.
		let regex_email2 = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		email.addEventListener("keyup", function() {
			if(regex_email2.test(email.value)) {
				s_email.textContent = "이메일 형식이 맞습니다."
				s_email.style.color = "blue";
				f_email = true;
			} else {
				s_email.textContent = "이메일 형식이 맞지 않습니다."
				s_email.style.color = "red";
				f_email = false;
			}
		})
		//전화번호 유효성 검사	, 정규식 
		//test(): 만족하면 tru, 그렇지 않으면 false를 반영하는 명제 확인 메소드
		let f_tel = false;
		let tel = document.getElementById("tel");
		let s_tel = document.querySelector(".s_tel");
		//let regex_tel = /^0\d{1,2}-\d{3,4}-\d{4}$/;	
		//형식 000-0000-0000, 13글자
		let regex_tel2 = /\d{2,3}-\d{3,4}-\d{4}$/;
		tel.addEventListener("keyup", function() {
			if(regex_tel2.test(tel.value)) {
				s_tel.textContent = "전화번호 형식이 맞습니다."
				s_tel.style.color = "blue";
				f_tel = true;
			} else {
				s_tel.textContent = "전화번호 형식이 맞지 않습니다."
				s_tel.style.color = "red";
				f_tel = false;
			}
		})
		
		//주소 찾기 - 다음 라이브러리 프로퍼티 적용
		let btnAddress = document.getElementById("btnAddress");
		btnAddress.addEventListener("click", function() {
			new daum.Postcode({
				oncomplete:function(data) {
					address1.value = data.address;
				}
			}).open();
		})
		
		//입력 내용을 누락했을 때의 처리
		let btnUpdate = document.getElementById("btnUpdate");
		//중복 체크를 하지 않고 다른 입력란으로 이동했을 때
		btnUpdate.addEventListener("click", function(event) {
			if(form.id.value.length < 8) {
				alert("아이디는 8글자 이상 입력하시오.");
				form.id.focus();
				return;
			}
			if(form)
			if(!form.pwd.value) {
				alert("비밀번호를 입력하세요.");
				form.pwd.focus();
				return;
			}
			if(!form.pwd2.value) {
				alert("비밀번호 확인을 입력하세요.");
				form.pwd2.focus();
				return;
			}
			if(pwd.value != pwd2.value) {
				alert("비밀번호가 일치하지 않습니다.");
				form.pwd2.focus();
				return;
			}
			if(pwd.value != pwd2.value) {
				alert("비밀번호와 비밀번호 확인이 다릅니다");
				form.pwd2.focus();
				return;
			}
			if(!form.name.value) {
				alert("이름을 입력하세요.");
				form.name.focus();
				return;
			}
			if(!form.age.value) {
				alert("나이를 입력하세요.");
				form.age.focus();
				return;
			}
			if(!form.email.value) {
				alert("이메일을 입력하세요.");
				form.email.focus();
				return;
			}
			if(!f_email) {
				alert("이메일 형식이 맞지 않습니다.");
				form.email.focus();
				return;
			}
			if(!f_tel) {
				alert("전화번호 형식이 맞지 않습니다.");
				form.tel.focus();
				return;
			}
			if(!form.tel.value) {
				alert("전화번호를 입력하세요.");
				form.tel.focus();
				return;
			}
			if(!form.address1.value) {
				alert("주소 앞자리를 입력하세요.");
				form.address1.focus();
				return;
			}
			if(!form.address2.value) {
				alert("주소 뒷자리를 입력하세요.");
				form.address2.focus();
				return;
			}
			
			form.submit();
		})
	})
</script>
</head>
<body>
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String sql = "select * from member where id=? and pwd=?";

Member member = new Member();

try {
	conn = JDBCUtil.getConnection();
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, pwd);
	rs = pstmt.executeQuery();
	
	if(rs.next()) {
		member.setId(rs.getString("id"));
		member.setPwd(rs.getString("pwd"));
		member.setName(rs.getString("name"));
		member.setGender(rs.getString("gender"));
		member.setAge(rs.getInt("age"));
		member.setEmail(rs.getString("email"));
		member.setTel(rs.getString("tel"));
		member.setAddress1(rs.getString("address1"));
		member.setAddress2(rs.getString("address2"));
		member.setRegDate(rs.getTimestamp("regDate"));
	} else {
		out.print("<></>");
	}
} catch(Exception e) {
	e.printStackTrace();
	
} finally {
	JDBCUtil.close(conn, pstmt, rs);
}
%>
	<div id="container">
		<h1>EZEN Cafe</h1>
		<h2>회원정보 폼</h2>
		<%-- 이메일, 비밀번호, 전화번호 -> 유효성 체크 --%>
		<form action="memberUpdatePro.jsp" method="post" name="infoForm">
		<table>
			<tr>
				<th width="20%">아이디</th>
				<td width="80%">
					<input type="text" name="id" id="id" value="" readonly>&ensp;
					<input type="button" name="btnIdCheck" id="btnIdCheck" value="중복 아이디 확인">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="pwd" id="pwd" value=""><br>
					<span class="s_pwd">비밀번호는 숫자, 영어소문자, 영대문자, 특수기호(!@#$%^&*)중 1개는 포함</span>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
					<input type="password" name="pwd2" id="pwd2">
					<span class="s_pwd2"></span>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" id="name" value=""></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="radio" name="gender" id="male" value="남성" checked><label for="male">남성</label>&emsp;&emsp;&emsp;
					<input type="radio" name="gender" id="female" value="여성"><label for="female">여성</label>
				</td>
			</tr>
			<tr>
				<th>나이</th>
				<td><input type="text" name="age" id="age" size="2" value=""></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="email" id="email" size="30" value="">
					<span class="s_email"></span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="text" name="tel" id="tel" value="">
					<span class="s_tel"></span>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type="button" name="btnAddress" id="btnAddress" value="주소찾기"><br>
					<input type="text" name="address1" id="address1" size="59" value=""><br>
					<input type="text" name="address2" id="address2" size="59" value=""> 
				</td>
			</tr>			
			<tr>
				<th>가입일</th>
				<td></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" id="btnUpdate" value="정보수정">&emsp;
					<input type="button" id="btnDelete" value="회원탈퇴">&emsp;
					<input type="button" id="btnLogin" value="돌아가기">&emsp;
				</td>
			</tr>			
		</table>
		</form>
	</div>
</body>
</html>