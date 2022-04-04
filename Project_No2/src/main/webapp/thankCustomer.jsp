<%-- 2022-03-24 작성 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.URLDecoder" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="./CSS/bootstrap.min.css" />
	<title>주문 완료</title>
</head>
<body>
	<%
	//전달 받은 요청 객체의 한글을 읽을 수 있게 인코딩
	request.setCharacterEncoding("UTF-8");

	//session.getId() : 현재 세션 고유의 ID를 문자열 형태로 반환
	String cartId = session.getId();

	//쿠키에 담긴 데이터 값을 저장하기 위한 문자열 변수 생성
	String Shipping_cartId = "";
	String Shipping_name = "";
	String Shipping_shippingDate = "";
	String Shipping_country = "";
	String Shipping_zipCode = "";
	String Shipping_addressName = "";

	//전달 받은 요청 객체에서 쿠키를 꺼내 쿠키 배열에 저장
	Cookie[] cookies = request.getCookies();

	//전달 받은 쿠키가 있다면
	if(cookies != null) {
		for(int i = 0; i < cookies.length; i++) {   //쿠키 배열만큼 반복
			Cookie thisCookie = cookies[i];   //배열의 i번째 쿠키를 빼서 저장
			String n = thisCookie.getName();   //i번째 쿠키의 이름을 빼서 저장
			//빼온 쿠키의 이름에 따라 해당 쿠키의 이름에 맞는 변수에 쿠키 값을 사용할 수 있게 utf-8 디코딩하여 저장
			if(n.equals("Shipping_cartId")) {
				Shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			}
			if(n.equals("Shipping_shippingDate")) {
				Shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			}
		}
	}
	%>
	
	<!-- menu.jsp 페이지의 HTML 코드만 가져와 현재 페이지에 내장시킨다 -->
	<!-- 동적으로 페이지를 할당할 때 주로 사용되는 클라이언트 단의 내장 방식 -->
	<jsp:include page="menu.jsp" />
	<!-- jumbotron : 특정 내용을 강조하기 위해 보여주는 박스 (부스트스랩 컴포넌트) -->
	<div class="jumbotron">
		<!-- container : 스크린의 구획(영역)을 조절하기 위한 클래스
						자바에서 JFrame 안에 JPanel을 넣는 느낌으로 이해하면 됨 -->
		<div class="container">
			<!-- display-3 : HTML의 h1,h2,h3,... 태그 처럼 글자 크기 3번쨰 -->
			<h1 class="display-3">주문 완료</h1>
		</div>
	</div>
	<div class="container">
		<%-- alert alert-danger : 경보 표시(강조를 위해), 분홍색 배경에 빨강 글자 --%>
		<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
		<%-- 요청 객체에서 쿠키로 가져온 값 셋팅 --%>
		<p>주문은 <% out.println(Shipping_shippingDate); %>에 배송될 예정입니다!</p>
		<p>주문번호 : <% out.println(Shipping_cartId); %></p>
	</div>
	<div class="container">
		<%-- btn-secondary : 버튼 꾸미기, 회색 바탕에 흰 글자 버튼 --%>
		<%-- &laquo;  :  << 표시 --%>
		<p><a href="./products.jsp" class="btn btn-secondary">&laquo; 상품 목록</a></p>
	</div>
</body>
</html>

<%
//session.invalidate()  :  강제로 세션을 만료시켜 세션에 저장된 내용 모두 삭제 (장바구니 목록 초기화)
session.invalidate();

//반복문으로 주문자 정보가 저장된 모든 쿠키의 유지 시간을 0으로 바꿔 만료 
for(int i = 0; i < cookies.length; i++) {
	Cookie thisCookie = cookies[i];
	String n = thisCookie.getName();
	if(n.equals("Shipping_cartId")) {
		thisCookie.setMaxAge(0);
	}
	if(n.equals("Shipping_name")) {
		thisCookie.setMaxAge(0);
	}
	if(n.equals("Shipping_shippingDate")) {
		thisCookie.setMaxAge(0);
	}
	if(n.equals("Shipping_country")) {
		thisCookie.setMaxAge(0);
	}
	if(n.equals("Shipping_zipCode")) {
		thisCookie.setMaxAge(0);
	}
	if(n.equals("Shipping_addressName")) {
		thisCookie.setMaxAge(0);
	}
	response.addCookie(thisCookie);
}
%>