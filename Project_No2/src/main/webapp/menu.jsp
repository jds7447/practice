<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<nav class="navbar navbar-expand-lg bg-dark navbar-dark fixed-top shadow-lg">
<!-- <nav class="navbar navbar-default bg-dark navbar-dark fixed-top shadow-lg" > -->
	<div class="container-fluid">
		<div class="navbar-header">
			<button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navMenu">
				<span class="navbar-toggler-icon"></span>        
			</button>
			<a class="navbar-brand" href="main.jsp">52Market</a>
		</div>
		<div class="collapse navbar-collapse" id="navMenu">
			<ul class="navbar-nav" style="margin:0 auto;">
				<li class="nav-item">
					<form class="navbar-form" role="search" action="#" method="post" name="searchField" id="searchField">
						<div class="form-group row" style="margin:0 auto;">
							<input type="text" class="form-control col-sm-9" placeholder="Search" name="searchWord" id="searchWord">
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
				<li class="nav-item">
					<a href="./loginForm.jsp" class="nav-link">로그인</a>
				</li>
				<li class="nav-item">
					<a href="#" class="nav-link">회원가입</a>
				</li>
				<li class="nav-item">
					<a href="#" class="nav-link">마이페이지</a>
				</li>
				<li class="nav-item">
					<a href="#" class="nav-link">장바구니</a>
				</li>
				<li class="nav-item">
					<a href="#" class="nav-link">고객센터</a>
				</li>
			</ul>
		</div>
	</div>
</nav>