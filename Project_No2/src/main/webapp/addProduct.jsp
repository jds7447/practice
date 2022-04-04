<!-- 2020-03-10 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 2022-03-22 추가-------------------------------------------------------------------------------- -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 2022-03-22 추가 끝------------------------------------------------------------------------------ -->

<!DOCTYPE html>
<html>
<head>

	<!-- 2022-03-17 변경-------------------------------------------------------------------------------- -->
	<!-- 자바스크립트 프레임워크인 bootstrap 4 스타일을 CDN 방식으로 불러와 활용 -->
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"> -->
	
	<!-- 부트 스트랩을 CDN 방식에서 다운로드 후 불러와 사용하는 방식으로 변경 -->
	<link rel="stylesheet" href="./CSS/bootstrap.min.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	
	<!-- 입력한 상품 데이터의 유효성 검사를 위한 js 데이터 가져오기 -->
	<script type="text/javascript" src="./js/validation.js"></script>
	<!-- 2022-03-17 변경 끝------------------------------------------------------------------------------ -->
	
	<meta charset="UTF-8">
	<title>상품 등록</title>
</head>
<body style="padding-top: 57px;">

	<!-- 2022-03-22 추가-------------------------------------------------------------------------------- -->
	<%-- 현재 페이지에서 a태그로 된 언어 선택 시 해당 요청이 이곳으로 와 그 language 값에 따라 표시 언어가 달라짐 --%>
	<fmt:setLocale value='<%= request.getParameter("language") %>' />
	<fmt:bundle basename="bundle.message">   <%-- bundle로 데이터 가져다 쓸 properties 파일 지정 --%>
	<!-- 2022-03-22 추가 끝------------------------------------------------------------------------------ -->

	<!-- menu.jsp 페이지의 HTML 코드만 가져와 현재 페이지에 내장시킨다 -->
	<!-- 동적으로 페이지를 할당할 때 주로 사용되는 클라이언트 단의 내장 방식 -->
	<jsp:include page="menu.jsp" />
	<!-- jumbotron : 특정 내용을 강조하기 위해 보여주는 박스 (부스트스랩 컴포넌트) -->
	<div class="jumbotron">
		<!-- container : 스크린의 구획(영역)을 조절하기 위한 클래스
						자바에서 JFrame 안에 JPanel을 넣는 느낌으로 이해하면 됨 -->
		<div class="container">
		
			<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
			<!-- display-3 : HTML의 h1,h2,h3,... 태그 처럼 글자 크기 3번쨰 -->
			<!-- <h1 class="display-3">상품등록</h1> -->
			
			<h1 class="display-3"><fmt:message key="title" /></h1>   <%-- 지정한 properties 파일에서 key의 값 출력 --%>
			<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
			
		</div>
	</div>
	<!-- jumbotron의 밑에 다시 컨테이너 구역 생성 -->
	<div class="container">
	
		<!-- 2022-03-22 추가-------------------------------------------------------------------------------- -->
		<div class="text-right">   <%-- 클릭 시 현재 페이지로 language 값을 get 방식으로 요청 (위의 setLocale 부분) --%>
			<a href="?language=ko">Korean</a> | <a href="?language=en">English</a>
		</div>
		<!-- 2022-03-22 추가 끝------------------------------------------------------------------------------ -->
	
		<!-- 2022-03-17 변경-------------------------------------------------------------------------------- -->
		<!-- submit 누르면 processAddProduct.jsp 페이지로 form 안의 데이터 모두 전달 -->
		<!-- form-horizontal : 수평폼, 레이블과 폼 요소가 가로로 배열된 형태 -->
		<!-- <form action="./processAddProduct.jsp" name="newProduct" class="form-horizontal" method="post"> -->
		
		<!-- 이미지 파일 전달을 위한 enctype 속성 추가 -->
		<form action="./processAddProduct.jsp" name="newProduct" class="form-horizontal" method="post" enctype="multipart/form-data">
		<!-- 2022-03-17 변경 끝------------------------------------------------------------------------------ -->
		
			<!-- form-horizontal 선택자를 사용하고 label과 input 태그를 분리하기 위해서 그리드 선택자를 사용 -->
			<!-- div 요소를 12개의 컬럼으로 이루어진 하나의 행으로 만들고 -->
			<!-- 해당 form-group 안에 있는 요소들을 하나의 그룹으로 만든다 -->
			<div class="form-group row">
				
				<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
				<!-- label 요소가 sm 크기의 2개 컬럼 사용 -->
				<!-- <label class="col-sm-2">삼품 코드</label> -->
				
				<label class="col-sm-2"><fmt:message key="productId" /></label>  <%-- 지정한 properties 파일에서 key의 값 출력 --%>
				<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
				
				<!-- input 요소를 감싼 div 요소가 sm 크기의 3개 컬럼 사용 -->
				<div class="col-sm-3">
				
					<!-- 2022-03-17 변경-------------------------------------------------------------------------------- -->
					<!-- form-control : Bootstrap 자체 만의 스타일로 표시된다 -->
					<!-- <input type="text" name="productId" class="form-control"> -->
					
					<%-- js 파일 함수에서 입력 요소 유효성 검사를 위해 요소의 데이터를 가져오기 위한 id 속성 추가 --%>
					<input type="text" name="productId" id="productId" class="form-control">
					<!-- 2022-03-17 변경 끝------------------------------------------------------------------------------ -->
					
				</div>
			</div>
			<div class="form-group row">
			
				<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
				<!-- <label class="col-sm-2">삼품명</label> -->
				
				<label class="col-sm-2"><fmt:message key="pname" /></label>  <%-- 지정한 properties 파일에서 key의 값 출력 --%>
				<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
				
				<div class="col-sm-3">
				
					<!-- 2022-03-17 변경-------------------------------------------------------------------------------- -->
					<!-- <input type="text" name="name" class="form-control"> -->
					
					<%-- js 파일 함수에서 입력 요소 유효성 검사를 위해 요소의 데이터를 가져오기 위한 id 속성 추가 --%>
					<input type="text" name="name" id="name" class="form-control">
					<!-- 2022-03-17 변경 끝------------------------------------------------------------------------------ -->
					
				</div>
			</div>
			<div class="form-group row">
			
				<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
				<!-- <label class="col-sm-2">가격</label> -->
				
				<label class="col-sm-2"><fmt:message key="unitPrice" /></label>  <%-- 지정한 properties 파일에서 key의 값 출력 --%>
				<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
				
				<div class="col-sm-3">
					
					<!-- 2022-03-17 변경-------------------------------------------------------------------------------- -->
					<!-- <input type="text" name="unitPrice" class="form-control"> -->
					
					<%-- js 파일 함수에서 입력 요소 유효성 검사를 위해 요소의 데이터를 가져오기 위한 id 속성 추가 --%>
					<input type="text" name="unitPrice" id="unitPrice" class="form-control">
					<!-- 2022-03-17 변경 끝------------------------------------------------------------------------------ -->
					
				</div>
			</div>
			<div class="form-group row">
				
				<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
				<!-- <label class="col-sm-2">상세 정보</label> -->
				
				<label class="col-sm-2"><fmt:message key="description" /></label>  <%-- 지정한 properties 파일에서 key의 값 출력 --%>
				<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
				
				<div class="col-sm-5">
					<textarea name="description" cols="50" rows="2" class="from-control"></textarea>
				</div>
			</div>
			<div class="form-group row">
				
				<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
				<!-- <label class="col-sm-2">제조사</label> -->
				
				<label class="col-sm-2"><fmt:message key="manufacturer" /></label>  <%-- 지정한 properties 파일에서 key의 값 출력 --%>
				<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
				
				<div class="col-sm-3">
					<input type="text" name="manufacturer" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				
				<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
				<!-- <label class="col-sm-2">분류</label> -->
				
				<label class="col-sm-2"><fmt:message key="category" /></label>  <%-- 지정한 properties 파일에서 key의 값 출력 --%>
				<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
				
				<div class="col-sm-3">
					<input type="text" name="category" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				
				<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
				<!-- <label class="col-sm-2">재고 수</label> -->
				
				<label class="col-sm-2"><fmt:message key="unitsInStock" /></label>  <%-- 지정한 properties 파일에서 key의 값 출력 --%>
				<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
				
				<div class="col-sm-3">
				
					<!-- 2022-03-17 변경-------------------------------------------------------------------------------- -->
					<!-- <input type="text" name="unitsInStock" class="form-control"> -->
					
					<%-- js 파일 함수에서 입력 요소 유효성 검사를 위해 요소의 데이터를 가져오기 위한 id 속성 추가 --%>
					<input type="text" name="unitsInStock" id="unitsInStock" class="form-control">
					<!-- 2022-03-17 변경 끝------------------------------------------------------------------------------ -->
					
				</div>
			</div>
			<div class="form-group row">
				
				<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
				<!-- <label class="col-sm-2">상태</label> -->
				
				<label class="col-sm-2"><fmt:message key="condition" /></label>  <%-- 지정한 properties 파일에서 key의 값 출력 --%>
				<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
				
				<div class="col-sm-5">
					
					<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
					<!-- <input type="radio" name="condition" value="New">신규 제품
					<input type="radio" name="condition" value="Old">중고 제품
					<input type="radio" name="condition" value="Refurbished">재생 제품 -->
					
					<input type="radio" name="condition" value="New"><fmt:message key="condition_New" />
					<input type="radio" name="condition" value="Old"><fmt:message key="condition_Old" />
					<input type="radio" name="condition" value="Refurbished"><fmt:message key="condition_Refurbished" />
					<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
					
				</div>
			</div>
			
			<!-- 2022-03-17 추가-------------------------------------------------------------------------------- -->
			<%-- 이미지 파일 업로드를 위한 input 항목 추가 --%>
			<div class ="form-group row">
				
				<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
				<!-- <label class ="col-sm-2">이미지</label> -->
				
				<label class="col-sm-2"><fmt:message key="productImage" /></label>  <%-- 지정한 properties 파일에서 key의 값 출력 --%>
				<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
				
				<div class ="col-sm-5">
 					<input type="file" name="productImage" class="form-control">
 				</div>
 			</div>
			<!-- 2022-03-17 추가 끝------------------------------------------------------------------------------ -->
			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
				
					<!-- 2022-03-17 변경-------------------------------------------------------------------------------- -->
					<!-- <input type="submit" class="btn btn-primary" value="등록"> -->
					
					<!-- 2022-03-22 변경-------------------------------------------------------------------------------- -->
					<%-- form 데이터 전송 전에 먼저 입력 데이터 검증을 위한 js 파일의 함수 실행 --%>
					<!-- <input type="button" class="btn btn-primary" value="등록" onclick="CheckAddProduct()"> -->
					
					<input type="button" class="btn btn-primary" value="<fmt:message key="button" />" onclick="CheckAddProduct()">
					<!-- 2022-03-22 변경 끝------------------------------------------------------------------------------ -->
					
					<!-- 2022-03-17 변경 끝------------------------------------------------------------------------------ -->
					
				</div>
			</div>
		</form>
	</div>
	
	<!-- 2022-03-22 추가-------------------------------------------------------------------------------- -->
	</fmt:bundle>
	<!-- 2022-03-22 추가 끝------------------------------------------------------------------------------ -->
	
</body>
</html>