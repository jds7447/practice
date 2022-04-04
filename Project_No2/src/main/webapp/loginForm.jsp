<%-- 2022.03.10 작성 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="./CSS/bootstrap.min.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<title>쇼핑도 취미다, 52마켓</title>
</head>
<body style="padding-top: 57px;">

	<jsp:include page="menu.jsp" />

	<div class="jumbotron" style="background-image: url('')">
		<div class="container">
			<h1 class="display-3">
				로그인 페이지
			</h1>
		</div>
	</div>
	
	<span style="color: red; font-size: 1.2em;">
		<%-- 요청객체의 LoginErrMsg 값이 비었으면 공란, 뭔가 있으면 해당 값 출력 --%>
		<%= request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg") %>
	</span>
	<%
	//만약 세션영역의 UserId 값이 비어있으면
	if(session.getAttribute("UserId") == null) {   //로그인 상태 확인
		//로그아웃 상태
	%>
	<script>
		//id와 pw 입력란에 뭔가 입력이 되어있는지 검사하는 함수
		function validateForm(form) {   //form 객체를 매개변수로 받는다
			if(!form.user_id.value) {   //만약 form의 name이 user_id인 요소의 값이 없으면
				alert("아이디를 입력하세요.");   //해당 메시지 다이얼로그 출력
				return false;   //false 반환
			}
			if(form.user_pw.value == "") {   //만약 form의 name이 user_pw인 요소의 값이 없으면
				alert("패스워드를 입력하세요");   //해당 메시지 다이얼로그 출력
				return false;   //false 반환
			}
		}
	</script>

	<div class="container">
		<div class="card shadow">
			<div class="card-body">
				<div class="container row">
					<div class="col-lg-9">
						<form class="form-horizontal" action="./login.LoginProcess.do" method="post" name="LoginFrm" onsubmit="return validateForm(this);">
							<div class="form-group row">
								<label class="col-lg-2" for="user_id">아이디</label>
								<div class="col-lg-5">
									<input type="text" name="user_id" id="user_id" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-lg-2" for="user_pw">패스워드</label>
								<div class="col-lg-5">
									<input type="password" name="user_pw" id="user_pw" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-lg-offset-2 col-md-10">
									<input type="submit" class="btn btn-primary" value="로그인" />
								</div>
							</div>
						</form>
					</div>
					<div class="col-lg-3">
						<input type="button"  class="btn btn-danger" value="허어억">
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
	}
	else {
		//로그인 된 상태
	%>
	<%-- 세션영역의 UserId 값을 출력 --%>
	<%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.<br/>
	<a href="./Logout.jsp">[로그아웃]</a>   <!-- [로그아웃] 누르면 Logout.jsp 페이지로 이동 -->
	<%
	}
	%>
	
	<%@ include file="./footer.jsp" %>
</body>
</html>
<%--
세션의 동작 방식
웹 브라우저가 처음 접속하면 서버(톰캣)는 세션을 새로 생성
응답 시 세션 아이디를 값으로 갖는 JSESSIONID 쿠키를 응답 헤더에 담아 웹 브라우저로 보냄
웹 브라우저는 재 요청 시마다 JSESSIONID를 요청 헤더에 추가하여 보냄
서버는 요청 헤더에 포함된 JSESSIONID로 해당 요청이 기존 세션에서 이어진 것임을 확인

세션 영역을 통해 로그인 전과 후를 판단
로그인 전 : 로그아웃 상태이므로 로그인을 위한 폼을 출력
로그인 후 : 로그인 상태이므로 세션 영역에 저장된 속성 값 출력

>>DB연동을 통한 로그인 처리시>>
DTO
Data Transfer Object
계층 사이에서 데이터를 교환하기 위해 생성하는 객체
별 다른 로직 없이 속성(멤버 변수)과 그 속성에 접근하기 위한 게터/세터 메서드로만 구성
값만 가진 객체라 하여 VO(Value Object)라고 하기도 함

DAO
Data Access Object
데이터베이스의 데이터에 접근하기 위한 객체
보통 JDBC 를 통해 구현하며, 하나의 테이블에서 수행할 수 있는 CRUD를 전담
CRUD란 Create(생성), Read(읽기), Update(갱신), Delete(삭제) 작업을 말함
--%>