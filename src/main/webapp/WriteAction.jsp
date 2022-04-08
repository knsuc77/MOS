<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.mos.BBSDAO" %>
<%@ page import="com.mos.UserDAO" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.FileUploadException"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bbs" class="com.mos.BBS" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContext" />
<jsp:setProperty name="bbs" property="bbsAttached" />
<jsp:setProperty name="bbs" property="bbsType" />
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
			String table = "";
			switch(bbs.getBbsType()){
			case "공지사항":
				table = "notis";
				break;
			case "족보":
				table = "testsolution";
				break;
			case "집행내역":
				table = "receipt";
				break;
			}
			BBSDAO dao = new BBSDAO();
			UserDAO udao = new UserDAO();
			String author = udao.getName(userID)+"("+userID+")";
			if(author.equals("")){
				script.println("<script>");
				script.println("alert('데이터베이스 오류입니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				
				int result = dao.postBBS(table, author, bbs.getBbsTitle(), bbs.getBbsContext(), request);
				if(result == -1){
					script.println("<script>");
					script.println("alert('데이터베이스 오류입니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					script.println("<script>");
					script.println("location.href='bbs.jsp?name=" + table + "'");
					script.println("</script>");
				}
			}
		}
	
	%>
</body>
</html>