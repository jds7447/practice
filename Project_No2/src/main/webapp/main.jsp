<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.Date"%>
<!-- 날짜와 관련된 라이브러리 import -->

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 자바스크립트 프레임워크인 bootstrap 4 스타일을 CDN 방식으로 불러와 활용 -->
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"> -->
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<title>쇼핑도 취미다, 오버페이 마켓</title>
</head>
<body style="padding-top: 57px;">
	<jsp:include page="menu.jsp" />
	<!-- 문자열 데이터 입력 -->
	<%!
	//선언문으로 문자열 변수 정의
	String greeting = "오버페이 쇼핑몰에 오신 것을 환영합니다";
	String tagline = "Welcome to Overpay Market!";
	%>
	<!-- jumbotron : 특정 내용을 강조하기 위해 보여주는 박스 (부스트스랩 컴포넌트) -->
	<div class="jumbotron" style="background-image: url('')">
		<!-- container : 스크린의 구획(영역)을 조절하기 위한 클래스
						자바에서 JFrame 안에 JPanel을 넣는 느낌으로 이해하면 됨 -->
		<div class="container">
			<h1 class="display-3">   <!-- display-3 : HTML의 h1,h2,h3,... 태그 처럼 글자 크기 3번쨰 -->
				<%=greeting%>   <!-- 위 선언문에서 정의한 문자열을 표현식으로 출력 -->
			</h1>
		</div>
	</div>
	<!-- jumbotron의 밑에 다시 구역 생성 -->
	<div class="container">
		<div>
			<h3>
				<!-- 문자 중앙 -->
				<%=tagline%>   <!-- 위 선언문에서 정의한 문자열을 표현식으로 출력 -->
			</h3>
			<%
			//날짜 객체를 생성해 현재 시간 날짜 표시
			Date day = new java.util.Date();   //날짜 객체 생성
			String am_pm;   //오전 오후 분별을 위한 문자열 변수 선언
			int hour = day.getHours();   //날짜 객체에서 현재 시간 가져오기 (24시간 기준임)
			int minute = day.getMinutes();   //날짜 객체에서 현재 분 가져오기
			int second = day.getSeconds();   //날짜 객체에서 현재 초 가져오기
			//if문을 활용해 AM/PM 구분
			if(hour / 12 == 0) {   //현재 시간이 12시 이하이면 오전
				am_pm = "AM";
			} else {   //현재 시간이 12시 초과이면 오후
				am_pm = "PM";
				hour = hour - 12;   //24시간 형식이기 때문에 12시간을 빼서 12시간 형식으로 바꿈
			} //날짜 출력 부분
			//이 부분에 시간 표시 (문자열 합치기)
			String CT = hour + ":" + minute + ":" + second + " " + am_pm;
			out.println("현재 접속 시각: " + CT + "\n");   //위 내용 출력
			%>
		</div><hr>
	</div>
	<!-- 아랫 부분에 footer.jsp 의 body태그 내용 표현 
		include : 외부 파일을 현재 jsp 페이지에 포함 -->
	<%@ include file="./footer.jsp" %>
</body>
</html>