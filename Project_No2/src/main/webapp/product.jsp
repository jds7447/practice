<!-- 2022-03-08 -->

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
	<!-- 2022-03-17 변경 끝------------------------------------------------------------------------------ -->
	
	<meta charset="UTF-8">
	<title>상품 상세 정보</title>
	
	<!-- 2022-03-23 추가-------------------------------------------------------------------------------- -->
	<script type="text/javascript">
		function addToCart() {   //장바구니 추가 확인 (yes or no 다이얼로그 박스)
			if(confirm("상품을 장바구니에 추가하시겠습니까?")) {   //yes(확인) 버튼 누르면 addForm 요소 제출
				document.addForm.submit();
			}
			else {   //no(취소) 버튼 누르면 addForm 요소 초기화
				document.addForm.reset();
			}
		}
	</script>
	<!-- 2022-03-23 추가 끝------------------------------------------------------------------------------ -->
	
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
			<h1 class="display-3">상품 상세 정보</h1>
		</div>
	</div>
	<%
	//2022-03-10 변경----------------------------------------------------------
	//useBean 태그에서 id 값을 통해 ProductRepository 클래스의
	//getProductById() 메서드를 호출하여 상품 상세정보 가져와 저장
	//String id = request.getParameter("id");   //전달 받은 요청 객체에서 id 라는 키(이름)에 매칭되는 값 가져와 저장
	//Product product = productDAO.getProductById(id);   //ProductRepository 저장소에서 해당 값에 대한 상세 제품 데이터 가져와 저장 
	
	String id = request.getParameter("id");   //전달 받은 요청 객체에서 id 라는 키(이름)에 매칭되는 값 가져와 저장
	ProductRepository dao = ProductRepository.getInstance();   //저장소 공용 인스턴스 생성
	Product product = dao.getProductById(id);   //저장소에서 해당 값에 대한 상세 제품 데이터 가져와 저장
	//2022-03-10 변경 끝--------------------------------------------------------
	%>
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
		
			<!-- 2022-03-17 추가-------------------------------------------------------------------------------- -->
			<div class="col-md-5">
				<%-- 이미지 파일을 가져오기 위한 경로 및 브라우저 출력 설정 --%>
				<%-- <img src="./Images/<%= product.getFilename() %>" style="width: 100%" /> --%>   <!-- 프로젝트 내 폴더 사용 -->
				<img src="/upload/<%= product.getFilename() %>" style="width: 100%" />   <!-- 다른 위치의 절대 경로 사용 -->
			</div>
			<!-- 2022-03-17 추가 끝------------------------------------------------------------------------------ -->
		
			<!-- 첫 번째 열을 md 사이즈의 6개의 칼럼을 쓰는 열로 만든다 -->
			<div class="col-md-6">
				<!-- 저장소에서 가져온 제품 데이터 객체에서 각 데이터를 빼와 나열한다 -->
				<h3><%= product.getPname() %></h3>   <!-- 제품 이름 -->
				<p><%= product.getDescription() %></p>   <!-- 제품 설명 -->
				<!-- badge-danger  : span 강조를 위한 부트스트랩, 빨간 배경에 흰 글자 -->
				<p><b>상품 코드 : </b><span class="badge badge-danger"><%= product.getProductId() %></span></p>
				<p><b>제조사</b> : <%= product.getManufacturer() %></p>
				<p><b>분류</b> : <%= product.getCategory() %></p>
				<p><b>재고 수</b> : <%= product.getUnitsInStock() %></p>
				<h4><%= product.getUnitPrice() %>원</h4>   <%-- 상품 가격 --%>
				
				<!-- 2022-03-23 변경-------------------------------------------------------------------------------- -->
				<%-- 
				<!-- a태그 #으로 누르면 현재 페이지 최상단으로 스크롤 이동 -->
				<!-- btn-info  :  버튼 모양 꾸미기 부트 스트랩, 청록 배경에 흰 글자 -->
				<!-- &raquo;  :  오른쪽 꺾인 괄호 2개 (>>) -->
				<p><a href='#' class="btn btn-info">상품 주문 &raquo;</a>
				<!-- a태그로 누르면 products.jsp 페이지(이전 페이지)로 이동 -->
				<!-- class="btn btn-secondary"  :  부트스트랩 버튼 모양 꾸미기, 회색 바탕에 흰 글자 버튼 -->
				<a href="./products.jsp" class="btn btn-secondary">상품 목록 &raquo;</a></p>
				--%>
				
				<%-- submit 시 현재 상품 id를 파라미터로 addCart.jsp 페이지 요청 --%>
				<form name="addForm" action="./addCart.jsp?id=<%= product.getProductId() %>" method="post">
					<p>
					<!-- a태그 #으로 누르면 현재 페이지 최상단으로 스크롤 이동 -->
					<!-- btn-info  :  버튼 모양 꾸미기 부트 스트랩, 청록 배경에 흰 글자 -->
					<!-- &raquo;  :  오른쪽 꺾인 괄호 2개 (>>) -->
					<!-- onclick="addToCart()"  :  장바구니에 추가 여부 결정 -->
					<a href='#' class="btn btn-info" onclick="addToCart()">상품 주문 &raquo;</a>
					
					<%-- 클릭 시 cart.jsp 페이지로 이동 --%>
					<%-- btn-warning  :  버튼 모양 꾸미기 부트 스트랩, 노란 배경에 검은 글자 --%>
					<a href='./cart.jsp' class="btn btn-warning">장바구니 &raquo;</a>
					
					<!-- a태그로 누르면 products.jsp 페이지(이전 페이지)로 이동 -->
					<!-- class="btn btn-secondary"  :  부트스트랩 버튼 모양 꾸미기, 회색 바탕에 흰 글자 버튼 -->
					<a href="./products.jsp" class="btn btn-secondary">상품 목록 &raquo;</a>
					</p>
				</form>
				<!-- 2022-03-23 변경 끝------------------------------------------------------------------------------ -->
				
			</div>
		</div>
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