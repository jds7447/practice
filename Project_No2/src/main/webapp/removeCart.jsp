<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
String id = request.getParameter("id");   //요청 시 전달 받은 id 파라미터의 값 저장
if(id == null || id.trim().equals("")) {   //해당 값이 비었으면
	response.sendRedirect("products.jsp");   //상품 목록 페이지로 이동
	return;   //현재 페이지 종료
}

//상품 데이터 저장소 객체 생성
Map<String, Object> search = new HashMap<String, Object>();
ProductDAO dao = new ProductDAO();

//전달받은 id 값에 해당하는 상품 데이터 가져오기
Product dto = dao.selectListById(search, id);
if(dto == null) {   //상품 데이터가 비어있으면 에러처리 페이지로 이동
	response.sendRedirect("exceptionNoProductId.jsp");
}

//세션 영역에 저장된 cartlist 속성의 값 가져와 cartList에 저장
ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
Product goodsQnt = new Product();   //상품 객체 생성
for(int i = 0; i < cartList.size(); i++) {   //상품 리스트 하나씩 출력하기
	goodsQnt = cartList.get(i);   //목록의 i번째 상품의 
	if(goodsQnt.getProductId().equals(id)) {   //id와 전달 받은 id가 같으면
		cartList.remove(goodsQnt);   //목록에서 해당 i번째 상품 삭제
	}
}
response.sendRedirect("./cart.jsp");   //장바구니 페이지로 이동
%>