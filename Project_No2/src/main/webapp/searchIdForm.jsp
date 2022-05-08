<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<meta charset="UTF-8">
	<title>쇼핑도 취미다, 오버페이 마켓</title>
	<style>
	   .card {
	        margin: 0 auto; /* Added */
	        float: none; /* Added */
	        margin-bottom: 100px; /* Added */
	        margin-top: 100px;
		} 
	
	
	</style>
</head>
<body style="padding-top: 57px;">
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
	<span style="color: red; font-size: 1.2em;">
		<%=request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg") %>
	</span>
	<%
	//session 영역에 UserId값이 비어있으면
	if(session.getAttribute("UserId") == null) { //로그인 상태 확인
		//로그아웃 상태
	%>
	<script>
	function validateForm(form) { //form 객체를 매개변수로 받아
		if(!form.user_name.value){ //form의 user_id의 값이 없으면 if문실행
			alert("이름을 입력하세요.");
			return false;
		}
		if(form.phoneNum.value == ""){ //form의 user_pw의 값이 없으면 if문실행
			alert("휴대폰번호를 입력하세요.");
			return false;
		}
	</script>
<div class="container">
	<div class="card align-middle" style="width:20rem; border-radius:20px; ">
		<div class="card-title" style="margin-top:30px;">
			<h2 class="card-title text-center" style="color:#113366;">아이디 찾기</h2>
		</div>
		<div class="card-body">
      		<form class="form-signin" action="searchIdResult.jsp" method="post" name="loginFrm" onsubmit="return validateForm(this);">
        		<h5 class="form-signin-heading" id="loingErr">회원 정보를 입력하세요</h5>
        		<% request.getAttribute("LoginErrMsg");%>
        		
        		
        			<label for="user_name" class="sr-only">이름</label>
        				<input type="text" name="user_name" class="form-control" placeholder="이름" required autofocus><BR>
        			<label for="phoneNum" class="sr-only">전화번호</label>
        				<input type="text" name="phoneNum" class="form-control" placeholder="전화번호" required><br>
        			
          			<!-- <a href="#" value="find_id">아이디찾기	</a>
          			<a href="#" value="find_id">비밀번호찾기</a> -->
          			
        				<div class="row">
        				<div class="col">
        				<div class="mb-2">
        					<button type="submit" class="btn btn-outline-info btn-primary btn-sm ">아이디 찾기</button>
        				</div>
        				</div>
        				<div class="mb-2">
        				<div class="col">
        					<button type="button" class="btn btn-outline-info btn-primary btn-sm" onclick="location.href='loginForm.jsp'">취소</button>
        				</div>
        				</div>
        			</div>
      		</form>
		</div>
	</div>
</div>
    <%
        }
	%>
	<div class="container"><hr></div>
	<jsp:include page="footer.jsp" />
</body>
</html>