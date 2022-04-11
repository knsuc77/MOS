<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.mos.CalendarCal" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>MOS</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body id="page-top">
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
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
                        	if(session.getAttribute("userID") != null){
                        		out.write("<li class=\"nav-item\"><a class=\"nav-link\" href=\"bbs.jsp?name=testsolution\">족보</a></li>");
                        		out.write("<li class=\"nav-item\"><a class=\"nav-link\" href=\"bbs.jsp?name=receipt\">집행내역</a></li>");
                        	}
                        %>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Masthead-->
        <header class="masthead">
            <div class="container">
                <div class="masthead-subheading">Make Our Software!</div>
                <div class="masthead-heading text-uppercase">원광대학교 컴퓨터소프트웨어공학과 <br><%=CalendarCal.getYear() %>년 전통 학술 동아리</div><!-- 41년 동적으로 계 -->
                <%
                if(session.getAttribute("userID") == null)
                	out.write("<a class=\"btn btn-primary btn-xl text-uppercase\" href=\"LoginForm.jsp\">LOGIN</a>");
                else
                	out.write("<a class=\"btn btn-primary btn-xl text-uppercase\" href=\"Logout.jsp\">LOGOUT</a>");
                %>

            </div>
        </header>
        <footer class="footer py-4">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-4 text-lg-start">Copyright &copy; MOS 2022</div>
                   
                    <div style="margin-left: 30%" class="col-lg-4 text-lg-end">
                        <a class="link-dark text-decoration-none me-3" href="#!">회장 김예성</a>
                        <a class="link-dark text-decoration-none" href="#!">010-3380-5720</a>
                    </div>
                </div>
            </div>
        </footer>
        
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>
