<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%> <!-- 게시글을 작성할 수 있는 데이터베이스는 BbsDAO객체를 이용해서 다룰 수 있기때문 -->
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" /> <!-- 하나의 게시글 인스턴스를 만든다 -->
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />


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
	}else{
		
		if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
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
	
	}
		
	

	%>
</body>
</html>