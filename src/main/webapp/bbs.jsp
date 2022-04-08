<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@page import="java.io.PrintWriter"%>
<%@page import="com.mos.BBSDAO"%>
<%@page import="java.util.List" %>
<!doctype html>
<html lang="en">
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
		boolean show_allow = false;
		if(name == null){
			script.println("<script>");
			script.println("alert('비정상 접근입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
			String id = (String) session.getAttribute("userID");
			if(id == null){
				if(name.equals("testsolution") || name.equals("receipt")){
					script.println("<script>");
					script.println("alert('로그인이 필요합니다.')");
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
                        <li class="nav-item"><a class="nav-link" href="gallery.jsp">사진첩</a></li>
                        <%
                        	if(id != null){
                        		out.write("<li class=\"nav-item\"><a class=\"nav-link\" href=\"bbs.jsp?name=testsolution\">족보</a></li>");
                        		out.write("<li class=\"nav-item\"><a class=\"nav-link\" href=\"bbs.jsp?name=receipt\">집행내역</a></li>");
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
		}
		%>
		
	</h2> 
      

      <div class="table-responsive custom-table-responsive">

        <table style="text-align: center" class="table custom-table">
          <thead>
            <tr> 
              <th width="15%" scope="col">번호</th>
              <th width="15%"scope="col">작성자</th>
              <th width="50%"scope="col">제목</th>
              <th width="20%"scope="col">작성일</th>
            </tr>
          </thead>
          <tbody>
          <%
          	BBSDAO dao = new BBSDAO();
          List<String[]> db = dao.getBBSDatabase(name);
          	for(int i = db.size()-1; i >= 0; i --){
          		String[] data = db.get(i);
          		out.write("<tr>");
          		out.write("<td>");
          		out.write(data[0]);
          		out.write("</td>");
          		out.write("<td>" + data[2] + "</td>");
          		out.write("<td>");
          		out.write("<a href=\"bbsShow.jsp?name="+name+"&id="+data[0]+"\">"+data[1]+"</a>");
          		out.write("</td>");
          		out.write("<td>");
          		out.write(data[3]);
          		out.write("</td>");
          		if(!data.equals(db.get(0))){
          			out.write("<tr class=\"spacer\"><td colspan=\"100\"></td></tr>");
          		}
          	}
          %>
          
          </tbody>
        </table>
      </div>
      <%out.write("<a href=\"bbsWrite.jsp?name="+name+"\">Write!</a>"); %>


    </div>

  </div>
  
    
    

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
  </body>
</html>