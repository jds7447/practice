<!-- 2022-03-07 작성 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 컬렉션 리스트 임포트 -->
<%@ page import="java.util.ArrayList" %>
<!-- 각 제품 데이터 객체를 생성할 제품 클래스 임포트 -->
<%@ page import="dto.Product" %>

<!-- 2022-03-10 추가-------------------------------------------------------------------------------- -->
<%@ page import="dao.ProductRepository" %>
<!-- 2022-03-10 추가 끝------------------------------------------------------------------------------ -->

<!-- 2022-03-10 변경-------------------------------------------------------------------------------- -->
<!-- 
자바빈
데이터를 표현하는 것을 목적으로하는 클래스이다
데이터를 저장하는 필드, 데이터를 읽어올 때 사용하는 메서드, 값을 저장할 때 사용하는 메서드로 구성
 -->
<!-- ProductRepository 클래스를 productDAO라는 이름의 자바빈 객체로 지정하여 세션 영역에 저장한다 -->
<!-- 자바빈 객체 이름 productDAO, 자바빈 클래스는 dao 패키지의 ProductRepository, 저장 영역은 세션 영역 (웹 브라우저 닫으면 소멸)  -->
<%-- <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session" /> --%>
<!-- 2022-03-10 변경 끝------------------------------------------------------------------------------ -->

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
	<!-- 2022-03-17 변경 끝------------------------------------------------------------------------------ -->
	
	<meta charset="UTF-8">
	<title>상품 목록</title>
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
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
	
	<!-- 2022-03-10 변경-------------------------------------------------------------------------------- -->
	<%   //컬렉션 리스트를 선언하며, 자바빈 저장소에 있는 모든 제품 데이터 저장
	//ArrayList<Product> listOfProducts = productDAO.getAllProducts();
	
	//저장소 공용 인스턴스 생성 및 해당 저장소의 모든 데이터를 가져와 저장
	ProductRepository dao = ProductRepository.getInstance();
	ArrayList<Product> listOfProducts = dao.getAllProducts();
	%>
	<!-- 2022-03-10 변경 끝------------------------------------------------------------------------------ -->
	
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
		<div class="row" align="center">
			<%
			//컬렉션 리스트에 저장된 데이터들을 반복문으로 하나씩 꺼내어 제품 객체에 저장하고
			for(int i = 0; i < listOfProducts.size(); i++) {
				Product product = listOfProducts.get(i);
			%>
			<!-- 첫 번째 열을 md 사이즈의 4개의 칼럼을 쓰는 열로 만든다 -->
			<div class="col-md-4">
			
				<!-- 2022-03-17 추가-------------------------------------------------------------------------------- -->
				<%-- 이미지 파일을 가져오기 위한 경로 및 브라우저 출력 설정 --%>
				<%-- <img src="./Images/<%= product.getFilename() %>" style="width: 100%" /> --%>   <!-- 프로젝트 내 폴더 사용 -->
				<img src="/upload/<%= product.getFilename() %>" style="width: 100%" />   <!-- 다른 위치의 절대 경로 사용 -->
				<!-- 2022-03-17 추가 끝------------------------------------------------------------------------------ -->
			
				<!-- 저장된 제품 객체의 제품 이름, 설명, 가격을 가져와 출력한다 -->
				<h3><%= product.getPname() %></h3>
				<p><%= product.getDescription() %></p>
				<p><%= product.getUnitPrice() %></p>
				
				<!-- 2022-03-08 추가-------------------------------------------------------------------------------- -->
				<!-- a태그로 누르면 product.jsp 페이지(상세 정보 페이지)로 이동 -->
				<!-- class="btn btn-secondary"  :  부트스트랩 버튼 모양 꾸미기, 회색 바탕에 흰 글자 버튼 -->
				<!-- role="button"  :  role은 위젯, 구조 및 동작에 대한 의미 정보 등을 제대로 전달하는 웹 접근성 위해 나왔다
										button은 Widget Roles에 속하며, 버튼을 누르거나 사용자 트리거 동작을 허용하는 입력 role -->
				<p><a href="./product.jsp?id=<%=product.getProductId()%>" class="btn btn-secondary" role="button"> 상세 정보 &raquo;</a>
				<!-- 2022-03-08 추가 끝----------------------------------------------------------------------------- -->
				
			</div>
			<%
			}
			%>
		</div><hr>
	</div>
	<!-- footer.jsp 페이지의 HTML 코드만 가져와 현재 페이지에 내장시킨다 -->
	<jsp:include page="./footer.jsp" />
</body>
</html>
<!-- 
프로젝트 디렉토리 구조는 생성 방법과 사용중인 빌드 도구에 따라 다르다
Eclipse에서 파일 -> 새로 만들기 -> 동적 웹 프로젝트를 선택하여 생성하면 / WebContent 디렉터리를 찾는다
Maven을 사용하여 만든 경우 structure 디렉터리는 /src / main / webapp 이 된다
 -->