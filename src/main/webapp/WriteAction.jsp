<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.mos.BBSDAO" %>
<%@ page import="com.mos.UserDAO" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOS</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		PrintWriter script = response.getWriter();
		if(userID == null){
			script.println("<script>");
			script.println("alert('계정 정보가 유효하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			BBSDAO dao = new BBSDAO();
			String result = dao.postBBS(userID, request);
			if(result != null){
				script.println("<script>");
				script.println("location.href='bbs.jsp?name="+result+"'");
				script.println("</script>");
			} else {
				script.println("<script>");
				script.println("alert('데이터베이스 오류입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
	
	%>
</body>
</html>