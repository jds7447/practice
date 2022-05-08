<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
    
<%
	//폼값 받기
	request.setCharacterEncoding("UTF-8");
	String user_name = request.getParameter("user_name");
	String phoneNum = request.getParameter("phoneNum");
	
	//web.xml에서 가져온 데이터베이스 연결 정보
	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");
	
	MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
	String resultId = dao.findId(user_name, phoneNum);
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
<div class="container">
	<div class="card align-middle" style="width:20rem; border-radius:20px; ">
		<div class="card-title" style="margin-top:30px;">
			<h2 class="card-title text-center" style="color:#113366;">오버페이</h2>
		</div>
		<div class="card-body">
      		<form class="form-signin"  method="post" name="loginFrm">
      		<%
      			if(resultId != null) {
      		%>
        		<h5 class="form-signin-heading">회원님의 아이디는 <%=resultId%> 입니다.</h5>		
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
        		<h5 class="form-signin-heading">등록된 회원정보가 없습니다.</h5>
        		<div class="row">
        			<div class="col">
        				<div class="mb-2">
        					<button type="button" class="btn btn-outline-info btn-primary btn-sm" onclick="location.href='searchIdForm.jsp'">다시찾기</button>
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