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
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<meta charset="UTF-8">
	<title>쇼핑도 취미다, 오버페이 마켓</title>
</head>
<body style="padding-top: 57px;">
	<jsp:include page="./menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
	
	<%
	ProductDAO dao = new ProductDAO();
	Map<String, Object> search = new HashMap<String, Object>();
	List<Product> listOfProducts = dao.selectList(search);
	dao.close();
	%>
	
	<div class="container">
		<div class="row" align="center">
			<%
			for(int i = 0; i < listOfProducts.size(); i++) {
				Product product = listOfProducts.get(i);
			%>
			<div class="col-md-4">
				<%-- <img src="./Images/<%= product.getFilename() %>" style="width: 100%" /> --%>   <!-- 프로젝트 내 폴더 사용 -->
				<%-- <%= product.getOfile() %> --%>
				<img src="/upload/<%= product.getOfile() %>" style="width: 100%" />   <!-- 다른 위치의 절대 경로 사용 -->
				<h3><%= product.getPname() %></h3>
				<p><%= product.getDescription() %></p>
				<p><%= product.getUnitPrice() %></p>
				<%= product.getProductId() %>
				<p><a href="./product.jsp?id=<%=product.getProductId()%>" class="btn btn-secondary" role="button"> 상세 정보 &raquo;</a>
			</div>
			<%
			}
			%>
		</div><hr>
	</div>
	<jsp:include page="./footer.jsp" />
</body>
</html>