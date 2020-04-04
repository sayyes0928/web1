<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<!--  viewport= 화면상의 표시영역, content=모바일 장치들에 맞게 크기조정, initial=초기 화면비율-->
<link href="css/bootstrap.css" rel="stylesheet">
<!-- 스타일시트로 css폴더의 bootstrap.css파일 사용 -->
<title>JSP 게시판 웹 사이트</title>
</head>
<body style="background-color: lightblue;">
	<!-- body style을 사용해 배경색 변경 가능 -->
	<%
		String userID = null; //로그인을 한 사람들은 userID에 해당 값이 담기고, 아닌 사람들은 null 값이 담긴다
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>

	<nav class="navbar navbar-default">
		<!-- inverse=검은색, default=색 없음 -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- class="navbar-toggle collapsed" = 네비게이션의 화면 출력 여부
				data-toggle="collapse" : 모바일 상태에서 클릭하면 메뉴가 나오도록 설정 -->

				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
				<!--  아이콘 이미지 -->

			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
			<!-- boostrap navbar 기본 메뉴바 -->
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<!-- navbar-nav = 네이게이션바 메뉴 -->
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
			if(userID == null){
				%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기 <span class="caret"></span></a> <!-- "#"임시의 링크주소 입력 -->
					<!-- caret = 아래화살표 아이콘 생성 -->
					<ul class="dropdown-menu">
						<!-- dropdown-menu : 버튼을 누르면 아래로 펼쳐지는 메뉴생성 -->
						<li><a href="login.jsp">로그인</a></li>
						<!-- active : 활성화되면 로그인, 회원가입 -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
				<%
			}else{
				%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리 <span class="caret"></span></a> <!-- "#"임시의 링크주소 입력 -->
					<!-- caret = 아래화살표 아이콘 생성 -->
					<ul class="dropdown-menu">
						<!-- dropdown-menu : 버튼을 누르면 아래로 펼쳐지는 메뉴생성 -->
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
					</li>
			</ul>
				<%
			}
			%>
			
		</div>
	</nav>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>