<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
    
<%
	//폼값 받기
	request.setCharacterEncoding("UTF-8");
	String user_id = request.getParameter("user_id");
	String user_name = request.getParameter("user_name");
	String phoneNum = request.getParameter("phoneNum");
	
	//web.xml에서 가져온 데이터베이스 연결 정보
	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");
	
	MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
	String resultPw = dao.findPw(user_id, user_name, phoneNum);
	dao.close();
%>
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
<script>
	function validateForm(form) { //form 객체를 매개변수로 받아
		if(!form.user_pw.value){ //form의 user_id의 값이 없으면 if문실행
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if(form.pw_confirm.value == ""){ //form의 user_pw의 값이 없으면 if문실행
			alert("비밀번호 확인을 입력하세요.");
			return false;
		}
		if(form.user_pw.value != form.pw_confirm.value){ //form의 user_pw의 값이 없으면 if문실행
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
	}
</script>
<div class="container">
	<div class="card align-middle" style="width:20rem; border-radius:20px; ">
		<div class="card-title" style="margin-top:30px;">
			<h2 class="card-title text-center" style="color:#113366;">오버페이</h2>
		</div>
		<div class="card-body">
      		<form class="form-signin" action="searchPwResultEdit.jsp" method="post" name="loginFrm" onsubmit="return validateForm(this);">
      		<%
      			if(resultPw != null) {
      		%>
        		<h5 class="form-signin-heading">비밀번호 재설정</h5>		
        		<label for="user_pw" class="sr-only">비밀번호</label> 
					<input type="password" name="user_pw" class="form-control" placeholder="비밀번호" required autofocus><BR> 
				<label for="pw_confirm" class="sr-only">비밀번호 확인</label> 
					<input type="password" name="pw_confirm" class="form-control" placeholder="비밀번호 확인" required><br>
					<input type="hidden" class="form-control" name="user_id" value="<%=user_id %>">
        		<div class="row">
        			<div class="col">
        				<div class="mb-2">
        					<button type="submit" class="btn btn-outline-info btn-primary btn-sm" >재설정 완료</button>
        				</div>
        			</div>
        			<div class="mb-2">
        				<div class="col">
        					<button type="button" class="btn btn-outline-info btn-primary btn-sm" onclick="location.href='loginForm.jsp'">취소</button>
        				</div>
        			</div>
        		</div>
        	<%
      			} else {        	
        	%>

        		<h5 class="form-signin-heading">등록된 회원정보가 없습니다.</h5>
        		<div class="row">
        			<div class="col">
        				<div class="mb-2">
        					<button type="button" class="btn btn-outline-info btn-primary btn-sm" onclick="location.href='searchPwForm.jsp'">다시찾기</button>
        				</div>
        			</div>
        			<div class="mb-2">
        				<div class="col">
        					<button type="button" class="btn btn-outline-info btn-primary btn-sm" onclick="location.href='joinForm.jsp'">회원가입</button>
        				</div>
        			</div>
        		</div>
        	<%
      			}
        	%>
      		</form>
		</div>
	</div>
</div>
	<div class="container"><hr></div>
	<jsp:include page="footer.jsp" />
</body>
</html>