<%-- 2022-03-24 작성 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductDAO" %>

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
		if(n.equals("Shipping_name")) {
			Shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		}
		if(n.equals("Shipping_shippingDate")) {
			Shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		}
		if(n.equals("Shipping_country")) {
			Shipping_country = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		}
		if(n.equals("Shipping_zipCode")) {
			Shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		}
		if(n.equals("Shipping_addressName")) {
			Shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		}
	}
}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<title>쇼핑도 취미다, 오버페이 마켓</title>
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
			<h1 class="display-3">주문 정보</h1>
		</div>
	</div>
	
	<%-- col-8 : 그리드 시스템 행의 12개 컬럼 중 8개 컬럼 사용  --%>
	<%-- alert alert-info : 경보 표시(강조를 위해), 하늘색 배경에 파란 글자 --%>
	<div class="container col-8 alert alert-info">
		<%-- text-center : 글자 가운데 정렬 --%>
		<div class="text-center">
			<h1>영수증</h1>
		</div>
		<%-- row : 그리드 시스템 행 적용 --%>
		<%-- justify-content-between : 양쪽 요소를 좌우에 붙이고 안쪽 요소들을 균일한 간격으로 배치 --%>
		<div class="row justify-content-between">
			<%-- col-4 : 그리드 행에서 4개의 컬럼 칸 사용 --%>
			<%-- align="left" : 좌측 정렬 요소 (justify-content-between의 좌측 요소) --%>
			<div class="col-4" align="left">
				<strong>배송 주소</strong> <br>
				<%-- 받아온 주문 정보를 출력 --%>
				성명 : <% out.println(Shipping_name); %> <br>
				우편번호 : <% out.println(Shipping_zipCode); %> <br>
				주소 : <% out.println(Shipping_addressName); %> <br>
			</div>
			<%-- align="right" : 우측 정렬 요소 (justify-content-between의 우측 요소) --%>
			<div class="col-4" align="right">
				<p><em>배송일 : <% out.println(Shipping_shippingDate); %></em></p>
			</div>
		</div>
		<div>
			<%-- table-hover : 테이블에 마우스를 올렸을 때 마우스 커서가 있는 행이 다른 색으로 변함 (mouseover 효과) --%>
			<table class="table table-hover">
				<tr>
					<th class="text-center">도서</th>
					<th class="text-center">#</th>
					<th class="text-center">가격</th>
					<th class="text-center">소계</th>
				</tr>
				<%
				int sum = 0;   //장바구니에 담긴 모든 제품 토탈 가격
				//세션 영역에 저장된 cartlist 속성의 값을 가져와 저장 (장바구니에 담긴 제품 목록)
				ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
				if(cartList == null) {   //cartlist가 비었으면 (장바구니가 비었으면)
					cartList = new ArrayList<Product>();   //신규 목록 생성
				}
				for(int i = 0; i < cartList.size(); i++) {   //상품 리스트 하나씩 출력하기
					Product product = cartList.get(i);   //목록의 i번째 상품의 
					int total = product.getUnitPrice() * product.getQuantity();   //가격과 장바구니 담긴 개수를 곱해서 저장
					sum = sum + total;   //i번째 상품의 가격(total)을 장바구니에 담긴 모든 상품 가격(sum)에 추가(누적)
				%>
				<tr>
					<td class="text-center"><%= product.getPname() %></td>   <%-- i번째 상품 이름 --%>
					<td class="text-center"><%= product.getQuantity() %></td>   <%-- i번째 상품이 장바구니에 담긴 개수 --%>
					<td class="text-center"><%= product.getUnitPrice() %>원</td>   <%-- i번째 상품 가격 --%>
					<td class="text-center"><%= total %>원</td>   <%-- i번째 상품의 토탈 가격 --%>
				</tr>
				<%
				}
				%>
				<tr>
					<td></td>
					<td></td>
					<td class="text-right">총액</td>
					<%-- text-danger : 글자 강조 표시, 빨간색 글자 --%>
					<td class="text-center text-danger"><strong><%= sum %></strong></td>   <%-- 장바구니에 담긴 모든 상품 총 합 가격 --%>
				</tr>
			</table>
			<%-- cartId 값을 파라미터로 shippingInfo.jsp 페이지 호출 (이전 주문자 정보 입력 페이지로) --%>
			<%-- btn-secondary : 버튼 꾸미기, 회색 바탕에 흰 글자 버튼 --%>
			<%-- role="button" : 해당 요소가 button 역할을 한다고 알려주기 위해 선언 --%>
			<a href="./shippingInfo.jsp?cartId=<%= Shipping_cartId %>" class="btn btn-secondary" role="button">이전</a>
			<%-- btn-success : 버튼 꾸미기, 초록 바탕에 흰 글자 버튼 --%>
			<a href="./thankCustomer.jsp" class="btn btn-success" role="button">주문 완료</a>
			<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button">취소</a>
		</div>
	</div>
</body>
</html>