<!-- <nav class="navbar navbar-expand  navbar-dark bg-dark">
navbar 반응형 축소 및 색 구성표 클래스
	navbar-expand 객 구성표
	navbar-light 밝은배경식, navbar-dark 어두운 배경색
	bg-* 유틸리티를 사용하여 사용자 지정
	<div class="container">
	container 부트스트랩에서 가장 기본적인 레이아우 요소, 기본 그리드 시스템을 사용할 때 필요함
		<div class="navbar-header">
			<a class="navbar-brand" href="./welcome.jsp">Home</a>
			a태그 : href 하이퍼링크를 걸 태그
			navbar-brand : 회사, 제품 또는 프로젝트 이름
		</div>
	</div>
</nav>
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<nav class="navbar navbar-expand-lg bg-dark navbar-dark fixed-top shadow-lg">
<!-- <nav class="navbar navbar-default bg-dark navbar-dark fixed-top shadow-lg" > -->
	<div class="container-fluid">
		<div class="navbar-header">
			<button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navMenu">
				<span class="navbar-toggler-icon"></span>        
			</button>
			<a class="navbar-brand" href="welcome.jsp">오버페이</a>
		</div>
		<div class="collapse navbar-collapse" id="navMenu">
			<ul class="navbar-nav" style="margin:0 auto;">
				<li class="nav-item">
					<form class="navbar-form" role="search" action="#" name="research" method="post">
						<div class="form-group row" style="margin:0 auto;">
							<input type="text" class="form-control col-sm-9" placeholder="Search">
							<button type="submit" class="btn btn-default col-sm-3">검색</button>
						</div>
					</form>
				</li>
			</ul>
			<ul class="navbar-nav"  style="margin:0 auto;">
				<li class="nav-item">
					<a href="./products.jsp" class="nav-link">상품목록</a>
				</li>
				<li class="nav-item">
					<a href="./addProduct.jsp" class="nav-link">상품등록</a>
				</li>
				<li class="nav-item">
					<a href="#" class="nav-link"></a>
				</li>
			</ul>
			<ul class="navbar-nav ml-auto">
				
				<%
				//session 영역에 UserId값이 비어있으면
				if(session.getAttribute("UserId") == null) { //로그인 상태 확인
				//로그아웃 상태
				%>
				<li class="nav-item">
					<a href="./loginForm.jsp" class="nav-link">로그인</a>
				</li>
				<li class="nav-item">
					<a href="./joinForm.jsp" class="nav-link">회원가입</a>
				</li>
				<%
				} else { //로그인된 상태
				%>
				<li class="nav-item">
					<a class="nav-link disabled"><%= session.getAttribute("UserName") %> 회원님, 반갑습니다.</a>
				</li>
				<li class="nav-item">
					<a href="./logout.jsp" class="nav-link">로그아웃</a>
				</li>
					<%
				}
				%>
				
				<li class="nav-item">
					<a href="#" class="nav-link">마이페이지</a>
				</li>
				<li class="nav-item">
					<a href="./cart.jsp" class="nav-link">장바구니</a>
				</li>
				<li class="nav-item">
					<a href="./list.jsp" class="nav-link">고객센터</a>
				</li>
			</ul>
		</div>
	</div>
</nav>