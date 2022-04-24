<%-- 2022-03-24 작성 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<h1 class="display-3">배송 정보</h1>
		</div>
	</div>
	<!-- jumbotron의 밑에 다시 컨테이너 구역 생성 -->
	<div class="container">
		<%-- 폼 제출 시 processShippingInfo.jsp 페이지 요청 --%>
		<%-- form-horizontal : 레이블과 폼 요소가 가로로 배열된 형태 --%>
		<form action="./processShippingInfo.jsp" class="form-horizontal" method="post">
			<%-- 주문자와 주문 목록 매칭을 위해 cart.jsp 페이지에서 보낸 cartId 값을 보이지 않는 입력 필드로 입력
				type="hidden" : 사용자가 변경해서는 안 되는 데이터를 함께 보낼 때 사용 --%>
			<input type="hidden" name="cartId" value="<%= request.getParameter("cartId") %>" />
			<%-- row : label과 input 태그를 분리하기 위해서 그리드 선택자를 사용 --%>
			<%-- form-group : 내부 자식 요소들이 기본 margin 값을 가져 보기 좋게 만들고 다른 요소와 구분되게 그룹화 한다 --%>
			<div class="form-group row">
				<%-- col-sm-2 : 그리드 선택자 행 안의 12칸의 컬럼 중 sm 사이즈의 2개의 칸을 사용 (1, 2 칸) --%>
				<label class="col-sm-2">성명</label>
				<%-- col-sm-3 : 그리드 선택자 행 안의 12칸의 컬럼 중 sm 사이즈의 3개의 칸을 사용 (3, 4, 5 칸) --%>
				<div class="col-sm-3">   <%-- form-control : Bootstrap 자체 만의 스타일로 요소가 꾸며짐 --%>
					<input name="name" type="text" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">배송일</label>
				<div class="col-sm-3">
					<input name="shippingDate" type="text" class="form-control" />(yyyy/mm/dd)
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">국가명</label>
				<div class="col-sm-3">
					<input name="country" type="text" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-3">
					<input name="zipCode" type="text" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소</label>
				<div class="col-sm-5">
					<input name="addressName" type="text" class="form-control" />
				</div>
			</div>
			<div class="form-group row">
				<%-- col-sm-offset-2 : 그리드 컬럼 중 sm 크기의 2 칸 만큼 띄운다 --%>
				<div class="col-sm-offset-2 col-sm-10">
					<%-- cartId 값을 파라미터로 cart.jsp 페이지 호출 (이전 장바구니 페이지로) --%>
					<%-- btn-secondary : 버튼 꾸미기, 회색 바탕에 흰 글자 버튼 --%>
					<%-- role="button" : 해당 요소가 button 역할을 한다고 알려주기 위해 선언 --%>
					<a href="./cart.jsp?cartId=<%= request.getParameter("cartId") %>" class="btn btn-secondary" role="button">이전</a>
					<%-- btn-primary : 버튼 꾸미기, 파란 바탕에 흰 글자 버튼 --%>
					<input type="submit" class="btn btn-primary" value="등록" />
					<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button">취소</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>