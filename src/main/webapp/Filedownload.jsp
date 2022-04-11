<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mos.BBSDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.net.URLEncoder" %>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>MOS</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String fileName = request.getParameter("filename");
		String table = request.getParameter("name");
		int bbsid = Integer.parseInt(request.getParameter("id"));
		
		String sFilePath = new BBSDAO().requestFilePath(table, bbsid, fileName, request);
		File oFile = new File(sFilePath);
		
		
		byte[] b = new byte[10*1024*1024];
		
		FileInputStream in = new FileInputStream(oFile);
		
		String sMimeType = getServletContext().getMimeType(sFilePath);
		if(sMimeType == null){
			sMimeType = "application.octec-stream";
		}
		
		response.setContentType(sMimeType);
		
		String A = new String(fileName.getBytes("utf-8"), "iso-8859-1");
		
		String AA = "Content-Disposition";
		String BB = "attachment; filename="+A;
		response.setHeader(AA, BB);
		response.setHeader("Content-Type", "application/octec-stream; charset=UTF-8");
		response.setHeader("Content-Length", ""+oFile.length());
		
		ServletOutputStream out2 = response.getOutputStream();
		
		int numRead = 0;
		
		while((numRead=in.read(b,0,b.length)) !=-1){
			out2.write(b, 0, numRead);
		}
		out2.flush();
		out2.close();
		in.close();
		
	%>
</body>
</html>