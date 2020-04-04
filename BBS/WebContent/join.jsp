<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<body style="background-color : lightblue;">
<!-- body style을 사용해 배경색 변경 가능 -->
	<nav class="navbar navbar-default">
	<!-- inverse=검은색, default=색 없음 -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- class="navbar-toggle collapsed" = 네비게이션의 화면 출력 여부
				data-toggle="collapse" : 모바일 상태에서 클릭하면 메뉴가 나오도록 설정 -->
				
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
				<!--  아이콘 이미지 -->
				
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		<!-- boostrap navbar 기본 메뉴바 -->
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav"> <!-- navbar-nav = 네이게이션바 메뉴 -->
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true" 
					aria-expanded="false">접속하기 <span class="caret"></span></a>
					<!-- "#"임시의 링크주소 입력 -->
					<!-- caret = 아래화살표 아이콘 생성 -->
					<ul class="dropdown-menu">
					<!-- dropdown-menu : 버튼을 누르면 아래로 펼쳐지는 메뉴생성 -->
						<li><a href="login.jsp">로그인</a></li>
						<!-- active : 활성화되면 로그인, 회원가입 -->
						<li class="active"><a href="join.jsp">회원가입</a></li>
					</ul>
					</li>
			</ul>
		</div>
	</nav>
	<div class="container"> <!-- 전체 레이아웃 감싸주기 -->
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
			<!-- jumbotron indicates a big box (바탕의 큰상자 -->
			
				<form method="post" action="joinAction.jsp">
					<h3 style="text-align: center">회원가입 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디"
							name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호"
							name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름"
							name="userName" maxlength="20">
					</div>
					<div class="form-group" style="text-align: center;">
					 <div class="btn-group" data-toggle="buttons">
					 <label class="btn btn-primary active">
					 	<input type="radio"
							name="userGender" autocomplete="off" value="남자"checked>남자
					 </label>
					 <label class="btn btn-primary">
					 	<input type="radio"
							name="userGender" autocomplete="off" value="여자">여자
					 </label>
					 </div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일"
							name="userEmail" maxlength="50">
					</div>
					<input type="submit" class="btn btn-primary form-control"
						value="회원가입">
				</form>
			</div>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>