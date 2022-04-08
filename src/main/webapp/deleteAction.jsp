<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.PrintWriter"%>
<%@page import="com.mos.BBSDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOS</title>
</head>
<body>
	<%
	PrintWriter script = response.getWriter();
	BBSDAO dao = new BBSDAO();
	String bbsid = request.getParameter("id");
	String name = request.getParameter("name");
	String id = (String) session.getAttribute("userID");
	if(id == null){
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	int delete = dao.deleteBBS(name, id, Integer.parseInt(bbsid));
	if(delete == 0){
		script.println("<script>");
		script.println("location.href='bbs.jsp?name="+name+"'");
		script.println("</script>");
	} else {
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>
</html>