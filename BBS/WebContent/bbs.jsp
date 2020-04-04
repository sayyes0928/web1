<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!-- 자바의 목록을 표시할때 필요 -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<!--  viewport= 화면상의 표시영역, content=모바일 장치들에 맞게 크기조정, initial=초기 화면비율-->
<link href="css/bootstrap.css" rel="stylesheet">
<!-- 스타일시트로 css폴더의 bootstrap.css파일 사용 -->
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
a, a:hover{color: #000000;
text-decoration: none;
}
</style>
</head>
<body>
	<!-- body style을 사용해 배경색 변경 가능 -->
	<%
		String userID = null; //로그인을 한 사람들은 userID에 해당 값이 담기고, 아닌 사람들은 null 값이 담긴다
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1; //기본페이지 설정
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%= list.get(i).getBbsID()%></td>
						<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle()%></a></td>
						<!-- 제목을 눌렀을 때 해당 게시글의 페이지로 이동시켜준다 -->
						<td><%= list.get(i).getUserID()%></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"
						+ list.get(i).getBbsDate().substring(13, 16) + "분"%></td>

					</tr>
					<%
						}
					%>
				</tbody>

			</table>
			<%
			if(pageNumber != 1){
				%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1 %>" class= "btn btn-success btn-arraw-left">이전</a>
				<%
			} if(bbsDAO.nextPage(pageNumber + 1)){
				%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1 %>" class= "btn btn-success btn-arraw-left">다음</a>
			<%
			}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>