<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mos.BBSDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>MOS</title>
</head>
<body>
	<%
	String id = (String) session.getAttribute("userID");
		if(id == null) return;
		request.setCharacterEncoding("UTF-8");
		int bbsid = Integer.parseInt(request.getParameter("id"));
		String table = request.getParameter("name");
		String fileName = URLDecoder.decode(request.getParameter("filename"),"UTF-8");
		String sFilePath = new BBSDAO().requestFilePath(table, bbsid, fileName, request);
		File oFile = new File(sFilePath);
		
		
		byte[] b = new byte[10*1024*1024];
		
		FileInputStream in = new FileInputStream(oFile);
		
		String A = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
		
		String AA = "Content-Disposition";
		String BB = "attachment; filename="+A;
		response.setHeader(AA, BB);
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Content-Length", ""+oFile.length());
		try{
			out.clear();
			out = pageContext.pushBody();
			ServletOutputStream out2 = response.getOutputStream();
			
			int numRead = 0;
			
			while((numRead=in.read(b,0,b.length)) !=-1){
				out2.write(b, 0, numRead);
			}
			out2.flush();
			out2.close();
			in.close();
		} catch(Exception e){
			e.printStackTrace();
		}
	%>
</body>
</html>