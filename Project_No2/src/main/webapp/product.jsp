<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductDAO" %>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="./CSS/bootstrap.min.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<meta charset="UTF-8">
	<title>상품 상세 정보</title>
	
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
</head>
<body style="padding-top: 57px;">
	<jsp:include page="menu.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 상세 정보</h1>
		</div>
	</div>
	
	<%
	String id = request.getParameter("id");
	ProductDAO dao = new ProductDAO();
	Map<String, Object> search = new HashMap<String, Object>();
	Product product = dao.selectListById(search, id);
	dao.close();
	%>
	
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<%-- <img src="./Images/<%= product.getFilename() %>" style="width: 100%" /> --%>   <!-- 프로젝트 내 폴더 사용 -->
				<img src="/upload/<%= product.getOfile() %>" style="width: 100%" />   <!-- 다른 위치의 절대 경로 사용 -->
			</div>
		
			<div class="col-md-6">
				<h3><%= product.getPname() %></h3>   <!-- 제품 이름 -->
				<p><%= product.getDescription() %></p>   <!-- 제품 설명 -->
				<p><b>상품 코드 : </b><span class="badge badge-danger"><%= product.getProductId() %></span></p>
				<p><b>제조사</b> : <%= product.getManufacturer() %></p>
				<p><b>분류</b> : <%= product.getCategory() %></p>
				<p><b>재고 수</b> : <%= product.getUnitsInStock() %></p>
				<h4><%= product.getUnitPrice() %>원</h4>   <%-- 상품 가격 --%>
				
				<form name="addForm" action="./addCart.jsp?id=<%= product.getProductId() %>" method="post">
					<p>
						<a href='#' class="btn btn-info" onclick="addToCart()">상품 주문 &raquo;</a>
						<a href='./cart.jsp' class="btn btn-warning">장바구니 &raquo;</a>
						<a href="./products.jsp" class="btn btn-secondary">상품 목록 &raquo;</a>
						<!-- 상품 삭제 하려면 회원 검증 해야하는데 회원 정보 DB 있어야하니까 보류 -->
						<!-- 일단 삭제 기능부터 넣어볼까 -->
						<a href="./productDeleteProcess.jsp?id=<%= product.getProductId() %>" class="btn btn-danger">상품 삭제 &raquo;</a>
					</p>
				</form>
				
			</div>
		</div>
	</div>
	
	<!-- footer.jsp 페이지의 HTML 코드만 가져와 현재 페이지에 내장시킨다 -->
	<jsp:include page="./footer.jsp" />
</body>
</html>