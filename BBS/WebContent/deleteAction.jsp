<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%> <!-- 게시글을 작성할 수 있는 데이터베이스는 BbsDAO객체를 이용해서 다룰 수 있기때문 -->
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>

<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String userID = null; //사용자가 로그인 했을 경우, 세션값을 할당받아 null 값이 아니게 된다. 그럴경우 35해으로 넘어간다
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID"); //세션을 불러오면 데이터 타입은 객체를 따라가기에 강제 설정 필요
	}
	if (userID == null) { //로그인 했을 경우, 
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
	else{
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.delete(bbsID);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}
	}
	%>
</body>
</html>