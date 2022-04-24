<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
    
<%
	//폼값 받기
	request.setCharacterEncoding("UTF-8");
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	
	//web.xml에서 가져온 데이터베이스 연결 정보
	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");
	
	MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
	int result = dao.editPw(user_id, user_pw);
	dao.close();
%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
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
<div class="container">
	<div class="card align-middle" style="width:20rem; border-radius:20px; ">
		<div class="card-title" style="margin-top:30px;">
			<h2 class="card-title text-center" style="color:#113366;">오버페이</h2>
		</div>
		<div class="card-body">
      		<form class="form-signin"  method="post" name="loginFrm">
      		<%
      			if(result == 1) {
      		%>
        		<h5 class="form-signin-heading">비밀번호 재설정완료</h5>	
        		<h5 class="form-signin-heading">다시 로그인 해주세요</h5>	
        		
        		<div class="row">
        			<div class="col">
        				<div class="mb-2">
        					<button type="button" class="btn btn-outline-info btn-primary btn-sm" onclick="location.href='loginForm.jsp'">로그인</button>
        				</div>
        			</div>
        		</div>
        	<%
      			} else {        	
        	%>
        		<h5 class="form-signin-heading">비밀번호 설정 오류. 다시 시도해주세요.</h5>
        		<div class="row">
        			<div class="col">
        				<div class="mb-2">
        					<button type="button" class="btn btn-outline-info btn-primary btn-sm" onclick="location.href='searchPwForm.jsp'">다시찾기</button>
        				</div>
        			</div>
        			<div class="mb-2">
        				<div class="col">
        					<button type="button" class="btn btn-outline-info btn-primary btn-sm" onclick="location.href='loginForm.jsp'">로그인</button>
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