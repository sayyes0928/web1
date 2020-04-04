<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />


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
	if (userID != null) { //로그인 했을 경우, 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
	|| user.getUserGender() == null || user.getUserEmail() == null ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		
	}
	else {
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			session.setAttribute("userID", user.getUserID()); //해당 유저의 ID를 세션갑으로 넣는다
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	}
		
	

	%>
</body>
</html>