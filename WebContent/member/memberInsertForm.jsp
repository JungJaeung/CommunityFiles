<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<style>
	#container { width: 600px; margin: 0 auto;}
	table { width: 100%; border: 1px solid black; border-collapse: collapse;}
	tr { height: 40px;}
	td, th { border: 1px solid black;}
	td {padding-left: 10px;}
	input[type="text"], input[type="password"] { padding-left: 10px; height: 20px;}
	/* 아이디 필드 */
	tr:first-child { height: 80px;}
	tr:first-child #btnIdCheck{ width: 120px; height: 30px;
	background-color: #c84557; color: white; border: none; border-radius: 3px; cursor: pointer;}
	.s_id { font-size: 0.9em;}
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
		
		//비밀번호 유효성 검사
		

		//비밀번호 확인 검사
		
		
		//이메일 유효성 검사
		
		
		//전화번호 유효성 검사	
		
		
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
		let btnInsert = document.getElementById("btnInsert");
		 	//중복 체크를 하지 않고 다른 입력란으로 이동했을 때
		let form = document.insertForm;
		btnInsert.addEventListener("click", function(event) {
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
			//중복 아이디 확인 버튼의 클릭 여부
			if(form.flag.value == "false") {
				alert("중복 아이디 확인을 클릭해주세요.");
				return;
			}
			
			form.submit();
		})
		
	})
</script>
</head>
<body>
<%
String idCheck = (String)session.getAttribute("idCheck");
String useId = "";
if(idCheck != null && idCheck.equals("0")) { 
	useId = (String)session.getAttribute("useId");
}

//중복 아이디 확인 버튼 클릭 여부
String flag = null;
//중복 아이디 확인 버튼을 클릭하지 않았을 때. 값이 없음
if(idCheck == null) flag = "false";
else flag = "true"; 		// 중복 아이디 확인 버튼을 클릭했을 때
%>
	<div id="container">
		<h1>EZEN Cafe</h1>
		<h2>회원가입 폼</h2>
		<%-- 이메일, 비밀번호, 전화번호 -> 유효성 체크 --%>
		<form action="memberInsertPro.jsp" method="post" name="insertForm">
		<input type="hidden" name="flag" value="<%=flag %>">
		<table>
			<tr>
				<th width="20%">아이디</th>
				<td width="80%">
					<input type="text" name="id" id="id" value="<%=useId %>">&ensp;
					<input type="button" name="btnIdCheck" id="btnIdCheck" value="중복 아이디 확인">
					<%if(idCheck==null) {%>
						<br><span class="s_id" style="color:gray">중복 아이디 확인을 버튼을 클릭해 주세요.</span>
					<%} else if(idCheck!=null && idCheck.equals("0")) {%>
						<br><span class="s_id" style="color:blue">사용가능한 아이디 입니다.</span>
					<%} else if(idCheck!=null && idCheck.equals("1")) {%>
						<br><span class="s_id" style="color:red">이미 사용중인 아이디입니다.</span>
					<%}%>	
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="pwd" id="pwd"><br>
					<span></span>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
					<input type="password" name="pwd2" id="pwd2">
					<span></span>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" id="name"></td>
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
				<td><input type="text" name="age" id="age" size="2"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="email" id="email" size="30">
					<span></span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="text" name="tel" id="tel">
					<span></span>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type="button" name="btnAddress" id="btnAddress" value="주소찾기"><br>
					<input type="text" name="address1" id="address1" size="59"><br>
					<input type="text" name="address2" id="address2" size="59"> 
				</td>
			</tr>			
			<tr>
				<td colspan="2">
					<input type="button" id="btnInsert" value="회원가입">&emsp;
					<input type="reset" value="다시입력">
				</td>
			</tr>			
		</table>
		</form>
	</div>
</body>
</html>