<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>MOS</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<script>
		location.href = "index.jsp";
	</script>
</body>
</html>