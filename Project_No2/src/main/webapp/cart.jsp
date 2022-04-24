<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<%
	//session.getId() : 현재 세션 고유의 ID를 문자열 형태로 반환
	String cartId = session.getId();
	%>
	<title>쇼핑도 취미다, 오버페이 마켓</title>
</head>
<body style="padding-top: 57px;">
	<!-- menu.jsp 페이지의 HTML 코드만 가져와 현재 페이지에 내장시킨다 -->
	<!-- 동적으로 페이지를 할당할 때 주로 사용되는 클라이언트 단의 내장 방식 -->
	<jsp:include page="menu.jsp" />
	<!-- jumbotron : 특정 내용을 강조하기 위해 보여주는 박스 (부스트스랩 컴포넌트) -->
	<div class="jumbotron">
		<!-- container : 스크린의 구획(영역)을 조절하기 위한 클래스
						자바에서 JFrame 안에 JPanel을 넣는 느낌으로 이해하면 됨 -->
		<div class="container">
			<!-- display-3 : HTML의 h1,h2,h3,... 태그 처럼 글자 크기 3번쨰 -->
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	<!-- jumbotron의 밑에 다시 컨테이너 구역 생성 -->
	<div class="container">
		<!-- 그리드 시스템 : 기본적으로 12칼럼으로 나누어서 기능을 제공
						이를 테이블의 형식으로 row 클래스와 col-* 클래들로 자유롭게 구성
						이렇게 구성한 페이지들을 부트스트랩에서 알아서 크키에 따라 반응형으로 동작하도록 만듦 -->
		<!-- 부트스트랩 row와 column을 사용하여 그리드 레이아웃을 구현 -->
		<!-- row 클래스는 container나 container-fluid 안에 있어야 정상적인 배열이나 패팅을 지원 -->
		<!-- row 클래스는 가로로 그룹 지을 칼럼들의 집합 -->
		<!-- 내용은 col-* 클래스 안에 있어야 하며, row의 직속 자녀 요소로 배치해야 함 -->
		<!-- 칼럼은 총 12칼럼이 있는 것으로 정의하여 각 배치할 칸에 따라서 클래스를 결정한다
			예를 들어 같은 넓이의 3개의 칼럼을 쓰고자 한다면 .col-sm-3 칼럼 클래스를 사용한다 -->
		<!-- 컨테이너에 하나의 행을 만든다 -->
		<div class="row">
			<%-- 테이블이 div 처럼 한 행의 너비를 모두 다 씀 --%>
			<table width="100%">
				<tr>
					<td align="left">   <%-- 좌로 정렬 --%>
						<%-- 클릭 시 현재 세션 ID를 파라미터로 deleteCart.jsp 페이지로 이동 --%>
						<a href="./deleteCart.jsp?cartId=<%= cartId %>" class="btn btn-danger">삭제하기</a>
					</td>
					<td align="right">   <%-- 우로 정렬 --%>
						<%-- 클릭 시 현재 세션 ID를 파라미터로 deleteCart.jsp 페이지로 이동 --%>
						<a href="./shippingInfo.jsp?cartId=<%= cartId %>" class="btn btn-success">주문하기</a>
					</td>
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px">   <%-- 위 div 요소와 간격 50px --%>
			<%-- table-hover : 테이블에 마우스를 올렸을 때 마우스 커서가 있는 행이 다른 색으로 변함 --%>
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
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
					<td><%= product.getProductId() %> - <%= product.getPname() %></td>   <%-- i번째 상품 id, 이름 --%>
					<td><%= product.getUnitPrice() %></td>   <%-- i번째 상품 가격 --%>
					<td><%= product.getQuantity() %></td>   <%-- i번째 상품이 장바구니에 담긴 개수 --%>
					<td><%= total %></td>   <%-- i번째 상품의 토탈 가격 --%>
					<!-- badge-danger  : 강조를 위한 부트스트랩, 빨간 배경에 흰 글자 -->
					<%-- 클릭 시 i번째 상품 id를 파라미터로 removeCart.jsp 페이지로 이동하는 링크 --%>
					<td><a href="./removeCart.jsp?id=<%= product.getProductId() %>" class="badge badge-danger">삭제</a></td>
				</tr>
				<%
				}   //상품 리스트 하나씩 출력하기 종료
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%= sum %></th>   <%-- 장바구니에 담긴 모든 상품 총 합 가격 --%>
					<th></th>
				</tr>
			</table>
			<!-- btn-secondary  :  부트스트랩 버튼 모양 꾸미기, 회색 바탕에 흰 글자 버튼 -->
			<!-- &raquo;  :  왼쪽 꺾인 괄호 2개 (<<) -->
			<%-- 상품 목록 페이지 이동 링크 --%>
			<a href="./products.jsp" class="btn btn-secondary">&laquo; 쇼핑 계속하기</a>
		</div>
		<hr>
	</div>
	<jsp:include page="./footer.jsp" />   <%-- footer.jsp 페이지의 내용만 가져와 출력하는 jsp 액션 태그 --%>
</body>
</html>