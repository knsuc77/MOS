<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.PrintWriter"%>
<%@page import="com.mos.BBSDAO"%>
<%@page import="com.mos.UserDAO"%>
<%@ page import="java.net.URLEncoder" %>
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
			String bbsid = request.getParameter("id");
  			String id = (String) session.getAttribute("userID");
  			if(id == null){
  				script.println("<script>");
  				script.println("alert('로그인이 필요합니다.')");
  				script.println("location.href='LoginForm.jsp'");
  				script.println("</script>");
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
                        		out.write("<li class=\"nav-item\"><a class=\"nav-link\" href=\"bbs.jsp?name=testsolution\">족보</a></li>");
                        		out.write("<li class=\"nav-item\"><a class=\"nav-link\" href=\"bbs.jsp?name=testsolution\">집행내역</a></li>");
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
		
		String[] bbsdata = new BBSDAO().getBBSData(name, Integer.parseInt(bbsid));
		if(bbsdata == null){
			script.println("<script>");
			script.println("alert('삭제되었거나 존재하지 않는 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		%>
		
	</h2>
      <div class="table-responsive custom-table-responsive">
		<table style="text-align: center; height: 500px;" class="table custom-table">
	          <tbody>
	         	<tr>
	         		<td width="15%"><label style="color:white;">제목</label></td>
	         		<td width="85%"><label style="color:white;"><% out.write(bbsdata[0]); %></label></td>
	         	</tr>
	         	<tr>
	         		<td width="15%"><label style="color:white;">첨부파일</label></td>
	         		<td width="85%"><label style="color:white;"><% 
						if(bbsdata[4] == null){
							out.write("첨부파일이 없습니다.");
						} else {
							String[] files = bbsdata[4].split(",");
							for(String line : files){
								out.write("<a href=\"Filedownload.jsp?filename="+URLEncoder.encode(line,"UTF-8")+"&name="+name+"&id="+bbsid+"\">"+line+"<br>");
							}
						}
	         		%></label></td>
	         	</tr>
	         	<tr style="border-top: 1px solid white;">
	         		<td height="85%" width="100%" colspan='2' style="text-align:left; padding: 20px 50px 20px 50px;"><label style="color:white;">
	         			<% out.write(bbsdata[3]); %>
	         			</label>
	         		</td>
	         	</tr>
	         	<%
	         		if(new BBSDAO().isAuthor(name, id, Integer.parseInt(bbsid)) == 0){
	         			out.write("<tr>");
	    	         	out.write("<td width=\"15%\">");
	    	         	out.write("<a href=\"deleteAction.jsp?name="+name+"&id="+bbsid+"\" class=\"form-control btn btn-primary submit px-3\">삭제</a>");
	    				out.write("</td>");
	    				out.write("<td width=\"85%\">");
	    				out.write("</td>");
	    	         	out.write("</tr>");
	         		}
	         	%>
	          </tbody>
        </table>
      </div>


    </div>

  </div>
  
    
    

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
  </body>
</html>