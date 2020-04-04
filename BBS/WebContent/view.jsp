<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%> <!-- 실제로 데이터베이스를 사용할 수 있도록 임폴트 -->
<%@ page import="bbs.BbsDAO"%> <!-- 실제로 데이터베이스를 사용할 수 있도록 임폴트 -->

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
<body>
	<!-- body style을 사용해 배경색 변경 가능 -->
	<%
		String userID = null; //로그인을 한 사람들은 userID에 해당 값이 담기고, 아닌 사람들은 null 값이 담긴다
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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
	Bbs bbs = new BbsDAO().getBbs(bbsID); //유효한 글이라서 결과값이 0이 아닌경우, 구체적인 정보를 인스턴스에 담을 수 있게한다
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
			<%
				if (userID == null) {
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
				} else {
			%>
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
			<%
				}
			%>

		</div>
	</nav>
	<div class="container">
		<!-- 특정한 내용(테이블)을 담을 컨테이너을 지정 -->
		<div class="row">
			<!-- 테이블이 들어갈 공간을 만든다 -->
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"style="background-color: #eeeeee; text-align: center;">게시판
							게시판 글 보기</th>
					</tr>
					<!-- colspan="2" 는 2개만큼의 열을 잡아먹는다-->
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td> <!-- 비고 -->
						<td colspan="2"><%= bbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td>작성자</td> <!-- 비고 -->
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td> <!-- 비고 -->
						<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
								+ bbs.getBbsDate().substring(13, 16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td> <!-- 비고 -->
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent() %></td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a> <!-- 게시글의 수정과 삭제가 가능하게 하는 문구 -->
			<% 
			if(userID !=null && userID.equals(bbs.getUserID())){ //로그인한 유저가 본인이라면 수정 가능하도록 만든다
				%>
				<a href="update.jsp?bbsID=<%= bbsID %>"class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>"class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>