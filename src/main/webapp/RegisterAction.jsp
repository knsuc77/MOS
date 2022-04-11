<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.PrintWriter"%>
<%@page import="com.mos.UserDAO"%>
<%@page import="com.mos.Encryptor"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="com.mos.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userNumber"/>
<jsp:setProperty name="user" property="userPasswordcheck"/>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>MOS</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
		if(!user.getUserPassword().equals(user.getUserPasswordcheck())){
			script.println("<script>");
			script.println("alert('비밀번호가 일치하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO dao = new UserDAO();
			int result = dao.joinwait(user);
			if(result == -1){
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				script.println("<script>");
				script.println("alert('회원가입 신청이 완료되었습니다. 관리자가 승인 후 사용 가능합니다.')");
				script.println("location.href='index.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>