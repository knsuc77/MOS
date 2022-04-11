<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.PrintWriter"%>
<%@page import="com.mos.BBSDAO"%>
<%@page import="com.mos.UserDAO"%>
<%@page import="java.util.List" %>
<!doctype html>
<html lang="ko">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="fonts/icomoon/style.css">

    <link rel="stylesheet" href="css/owl.carousel.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    
    <!-- Style -->
     <link href="css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/bbsstyle.css">
   

    <title>MOS</title>
  </head>
  <body>
  		<%
  			PrintWriter script = response.getWriter();
			String name = request.getParameter("name");
  			String id = (String) session.getAttribute("userID");
  			if(id == null){
  				script.println("<script>");
  				script.println("alert('로그인이 필요합니다.')");
  				script.println("location.href='LoginForm.jsp'");
  				script.println("</script>");
  			}
  			if(name.equals("notis") || name.equals("receipt")){
				if(!new UserDAO().isAdmin(id)){
					script.println("<script>");
	  				script.println("alert('일반 부원은 작성할 수 없습니다.')");
	  				script.println("history.back()");
	  				script.println("</script>");
				}
			}
		%>
          <nav style="background-color:#222529" class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="index.jsp"><img style="width:120px; height:120px;" src="assets/img/logo_transparent.png" alt="..." /></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars ms-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link" href="bbs.jsp?name=notis">공지사항</a></li>
                        <li class="nav-item"><a class="nav-link" href="bbs.jsp?name=gallery">사진첩</a></li>
                        <%
                        	if(id != null){
                        		out.write("<li class=\"nav-item\"><a class=\"nav-link\" href=\"bbs.jsp?name=\"testsolution\"\">족보</a></li>");
                        		out.write("<li class=\"nav-item\"><a class=\"nav-link\" href=\"bbs.jsp?name=\"receipt\"\">집행내역</a></li>");
                        	}
                        %>
                    </ul>
                </div>
            </div>
        </nav>

  <div style="height:70%" class="content">
    
    <div class="container">
      <h2 style="margin-top: 100px" class="mb-5">
		<% switch(name){
		case "testsolution":
			out.write("족보");
			break;
		case "notis":
			out.write("공지사항");
			break;
		case "receipt":
			out.write("집행내역");
			break;
		case "gallery":
			out.write("사진첩");
			break;
		}
		%>
		
	</h2> 
      

      <div class="table-responsive custom-table-responsive">
		<form action="WriteAction.jsp" method="post" enctype="multipart/form-data">
		<table style="text-align: center; height: 500px" class="table custom-table">
	          <tbody>
	          	<tr>
	         		<td width="15%">게시판</td>
	         		<%
	         			String type = "";
	         		switch(name){
	        		case "testsolution":
	        			type = "족보";
	        			break;
	        		case "notis":
	        			type = "공지사항";
	        			break;
	        		case "receipt":
	        			type = "집행내역";
	        			break;
	        		case "gallery":
	        			type = "사진첩";
	        			break;
	        		}
	         			out.write("<td colspan='2' width=\"85%\"><input type=\"text\" class=\"form-control\" name=\"bbsType\" value=\""+type+"\" readonly></td>");
	         		%>
	         	</tr>
	         	<tr>
	         		<td width="15%">제목</td>
	         		<td width="85%"><input type="text" class="form-control" name="bbsTitle" placeholder="제목"></td>
	         	</tr>
	         	<tr>
	         		<td width="15%">첨부파일</td>
	         		<td width="85%"><input type="file" class="form-control" name="bbsAttached" multiple></td>
	         	</tr>
	         	<tr>
	         		<td width="15%">내용</td>
	         		<td height="80%" width="85%"><textarea class="form-control" name="bbsContext" rows="30%"></textarea></td>
	         	</tr>
	         	<tr>
	         		<td width="15%"><button type="submit" class="form-control btn btn-primary submit px-3">완료 </button></td>
	         		<td width="85%"></td>
	         	</tr>
	          </tbody>
        </table>
		</form>
      </div>


    </div>

  </div>
  
    
    

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
  </body>
</html>