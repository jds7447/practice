<%-- 2022-03-24 작성 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="./CSS/bootstrap.min.css" />
	<title>주문 취소</title>
</head>
<body>
	<!-- menu.jsp 페이지의 HTML 코드만 가져와 현재 페이지에 내장시킨다 -->
	<!-- 동적으로 페이지를 할당할 때 주로 사용되는 클라이언트 단의 내장 방식 -->
	<jsp:include page="menu.jsp" />
	<!-- jumbotron : 특정 내용을 강조하기 위해 보여주는 박스 (부스트스랩 컴포넌트) -->
	<div class="jumbotron">
		<!-- container : 스크린의 구획(영역)을 조절하기 위한 클래스
						자바에서 JFrame 안에 JPanel을 넣는 느낌으로 이해하면 됨 -->
		<div class="container">
			<!-- display-3 : HTML의 h1,h2,h3,... 태그 처럼 글자 크기 3번쨰 -->
			<h1 class="display-3">주문 취소</h1>
		</div>
	</div>
	<div class="container">
		<%-- alert alert-danger : 경보 표시(강조를 위해), 분홍색 배경에 빨강 글자 --%>
		<h2 class="alert alert-danger">주문이 최소되었습니다.</h2>
	</div>
	<div class="container">
		<%-- btn-secondary : 버튼 꾸미기, 회색 바탕에 흰 글자 버튼 --%>
		<%-- &laquo;  :  << 표시 --%>
		<p><a href="./products.jsp" class="btn btn-secondary">&laquo; 상품 목록</a></p>
	</div>
</body>
</html>