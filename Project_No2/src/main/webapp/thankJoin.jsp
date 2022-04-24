<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<!-- 날짜와 관련된 라이브러리 import -->
<!DOCTYPE html>
<html><head><meta charset="UTF-8">
	<!-- bootstrap 스타일 활용 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>쇼핑도 취미다, 오버페이 마켓</title>
</head>
<body style="padding-top: 57px;">
	<!-- 상단메뉴바 포함 -->
	<%@ include file="menu.jsp" %>  
	<!-- 문자열 데이터 입력 -->
	<!-- 시작페이지 만들기 -->
	<%!
	String greeting = "회원가입을 축하합니다!.";
	String tagline = "Welcome to Web Market!";	
	%>
	<!-- 전체 표시 영역을 확장하여 사이트의 주요 마케팅 메시지를 표시할 수 있다. -->
	<div class="jumbotron">
		<div class="container">
		<!-- display로 h1의 크기를 더 크게 할 수 있다. -->
			<h1 class="display-3">
				<%=greeting%>
			</h1>
		</div>
	</div>
	<div class="container">
		<div class="text-center">
			<h3>
				<!-- 문자 중앙 -->
				<%=tagline%>
			</h3>
			<%
			//날짜 객체를 생성해 현재 시간 날짜 표시
			Date day = new java.util.Date();  //날짜 객체 생성
			String am_pm; //오전오후 표시 변수 생성
			int hour = day.getHours();  //시
			int minute = day.getMinutes();   //분
			int second = day.getSeconds();   //초
			//if문을 활용해 AM/PM 구현
			if(hour/12 == 0){  //시가 12시전이면
				am_pm = "AM";
			} else {
				am_pm = "PM";
				hour = hour-12; 
			} //날짜 출력부분
			//이 부분에 시간 표시
			String CT = hour + ":" + minute + ":" + second + " " + am_pm;
			out.println("현재 접속 시각: " + CT + "\n");
			%>
		</div><hr>
	</div>
	<!-- 아랫부분에 footer.jsp 내용 표현 -->
	<!-- 직역 : 외부파일에 현재 jsp파일은 포함한다. -->
	<%@ include file="footer.jsp" %>  
</body>
</html>