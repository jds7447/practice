<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>쇼핑도 취미다, 오버페이 마켓</title>
	<!-- 자바스크립트 프레임워크인 bootstrap 4 스타일을 CDN 방식으로 불러와 활용 -->
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"> -->
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
</head>
<body>
	<!-- 
	navbar : 네비게이션 바
	navbar-expand : 브라우저 창 크기에 따라 늘었다 줄었다 함 (창 가로 576px 이상에서 100% 너비)
					창 가로 크기 576px 미만에선 항목들 세로 정렬 이상에선 가로 정렬
	navbar-dark : 네비게이션 바 글자 색을 어두운 배경색에서 보이게
	bg-dark : 네비게이션 바 배경 색 어둡게
	 -->
	<nav class="navbar navbar-expand navbar-dark bg-dark" style="margin-top: 70px;">
		<!-- 컨테이너 영역 생성 -->
		<div class="container">
			<!-- navbar-header : 네비게이션 바의 헤더 부분? (굳이 없어도 됨) -->
			<div class="navbar-header">
				<!-- navbar-brand : 회사명이나 제품명, 프로젝트명 등 표시 -->
				<!-- Home 누르면 Welcome01.jsp 페이지로 이동 -->
				<a class="navbar-brand" href="./main.jsp">Home</a>
			</div>
		</div>
	</nav>
	<!-- 하단 footer 바 -->
	<!-- 회사, 사업장 등의 위치, 주소, 번호 등의 정보들을 작성하는 공간 -->
	<!-- 창크기 576px 이상에서 100%의 너비를 갖는 기본 컨테이너 -->
	<footer class="container">
		<p>&copy; WebMarket</p>
	</footer>
</body>
</html>