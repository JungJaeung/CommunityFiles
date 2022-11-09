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
	.showList:hover { cursor: pointer; background-color: gray; opacity: 0.5;}
	.listNumber { visibility: hidden;}
	#subNavi { background-color: gray; width: 200px; height: 50px;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let selectedForm = document.selectedForm;
		let showList = document.querySelectorAll(".showList");
		console.log(showList);
		console.log(selectedForm);
		for(let i=0; i<showList.length; i++) {
			showList[i].addEventListener("click", function(event) {
				selectedForm[i].action = 'selectedWriteList.jsp';
				selectedForm[i].submit();
			})
		}
		
		let memberInfo = document.querySelector("#memberInfo");
		memberInfo.addEventListener("click", function(event) {
			window.location.href = '../member/memberInfoForm.jsp';
		})
		
		let writeNew = document.querySelector("#writeNew");
		writeNew.addEventListener("click", function(event) {
			window.location.href = 'writeNewList.jsp';
		})
	})
</script>
</head>
<%request.setCharacterEncoding("utf-8"); %>
<body>
	<div id="container">
		<div id="subNavi">
			<button id="memberInfo">내 정보</button>
			<button id="memberOut">로그아웃</button>
			<button id="writeNew">게시글 작성</button>
		</div>
		<h2>게시판 메인 페이지 글 조회페이지</h2> 
		<ul>
			<li><a>게시판의 내용이 여기에 표시됩니다.</a></li>
<%
	System.out.println((String)session.getAttribute("memberId") + ", " + (String)session.getAttribute("memberPwd"));
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select listId, name, title, writeDate from boardList";
	
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
			out.print("<li class='showList'><form method='post' name='selectedForm' class='form'>" + name +  
			"&emsp;&emsp;:&emsp;&emsp;" + title + "&emsp;&emsp;:&emsp;&emsp;" + 
			writeTime + "<input type='text' value='"+ listId +"' class='listNumber' name='listId'></form></li>");
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