<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" href="css/style.css">
<title>MOS</title>
</head>
<body class="img js-fullheight" style="background-color:#19191D;">
	<section class="ftco-section" style="background-color:#19191D;">
	<div class="row justify-content-center">
	<a href="index.jsp"><img src="assets/img/logo_transparent.png" height="120px" width="120px"></a>
	</div>
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4">
					<div class="login-wrap p-0">
		      	<form action="RegisterAction.jsp" class="signin-form">
		      		<div class="form-group">
		      			<input type="text" class="form-control" name="userID" placeholder="아이디" required>
		      		</div>
	            <div class="form-group">
	              <input id="password-field" type="password" name="userPassword" class="form-control" placeholder="비밀번호" required>
	              <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
	            </div>
	            <div class="form-group">
	              <input id="password-field" type="password" name="userPasswordcheck" class="form-control" placeholder="비밀번호 확인" required>
	              <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
	            </div>
	            <div class="form-group">
		      			<input type="text" class="form-control" name="userName" placeholder="이름" required>
		      		</div>
		      		<div class="form-group">
		      			<input type="text" class="form-control" name="userNumber" placeholder="학번" required>
		      		</div>
	            <div class="form-group">
	            	<button type="submit" class="form-control btn btn-primary submit px-3">회원가입</button>
	            </div>
	          </form>
		      </div>
				</div>
			</div>
		</div>
	</section>

	<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>

	</body>
</html>