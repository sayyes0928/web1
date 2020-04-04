<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
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
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'"); //로그인이 안된사람은 로그인 페이지로 이동
			script.println("</script>");
		}
		int bbsID = 0;//매개 변수 및 기본 설정
		if (request.getParameter("bbsID") !=null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'"); //로그인이 안된사람은 로그인 페이지로 이동
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'"); //로그인이 안된사람은 로그인 페이지로 이동
			script.println("</script>");
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
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
				<!-- 현재 페이지가 게시판이다 -->
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리 <span class="caret"></span></a> <!-- "#"임시의 링크주소 입력 -->
					<!-- caret = 아래화살표 아이콘 생성 -->
					<ul class="dropdown-menu">
						<!-- dropdown-menu : 버튼을 누르면 아래로 펼쳐지는 메뉴생성 -->
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<!-- 특정한 내용(테이블)을 담을 컨테이너을 지정 -->
		<div class="row">
			<!-- 테이블이 들어갈 공간을 만든다 -->
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								글 수정 양식</th>
						</tr>
						<!-- colspan="2" 는 2개만큼의 열을 잡아먹는다-->
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="bbsContent" maxlength="2048" style="height: 350px;"><%= bbs.getBbsContent() %></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>