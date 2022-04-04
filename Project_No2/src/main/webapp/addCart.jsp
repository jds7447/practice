<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>

<%
String id = request.getParameter("id");   //전달 받은 파라미터의 id 값 가져와 저장
if(id == null || id.trim().equals("")) {   //id 값이 없거나 공백이면
	response.sendRedirect("products.jsp");   //상품 목록 페이지로 이동
	return;   //현재 페이지 종료
}

//상품 데이터 저장소 객체 생성
ProductRepository dao = ProductRepository.getInstance();

//전달받은 id 값에 해당하는 상품 데이터 가져오기
Product product = dao.getProductById(id);
if(product == null) {   //상품 데이터가 비어있으면 에러처리 페이지로 이동
	response.sendRedirect("exceptionNoProductId.jsp");
}

//상품 데이터 저장소에서 모든 상품 데이터 목록 가져와 저장
ArrayList<Product> goodsList = dao.getAllProducts();
Product goods = new Product();   //상품 객체 생성
for(int i = 0; i < goodsList.size(); i++) {   //상품 데이터 개수만큼 반복
	goods = goodsList.get(i);   //i번째 상품 데이터의
	if(goods.getProductId().equals(id)) {   //상품 id가 전달받은 id 값과 같으면
		break;   //반복 종료
	}
}

//세션 영역에 저장된 cartlist 속성의 값 가져와 list에 저장
ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
if(list == null) {   //세션에 cartlist 속성 값이 없으면
	list = new ArrayList<Product>();   //list에 상품만 넣을 수 있는 목록을 생성하고
	session.setAttribute("cartlist", list);   //세션 영역의 cartlist에 list 저장
}
int cnt = 0;   //상품이 장바구니에 이미 담겨 있는지 유무 체크 변수
Product goodsQnt = new Product();   //상품 객체 생성
for(int i = 0; i < list.size(); i++) {   //list의 목록 개수만큼 반복
	goodsQnt = list.get(i);   //list의 i번째 상품 데이터의
	if(goodsQnt.getProductId().equals(id)) {   //상품 id가 전달받은 id 값과 같으면
		cnt++;   //상품이 장바구니에 이미 담겨있음 (1)
		int orderQuantity = goodsQnt.getQuantity() + 1;   //상품 데이터의 장바구니 상품 개수에 1 추가
		goodsQnt.setQuantity(orderQuantity);   //추가한 장바구니 상품 개수를 상품 데이터에 저장
	}
}
if(cnt == 0) {   //상품이 장바구니에 담겨있지 않다면 (0)
	goods.setQuantity(1);   //상품 데이터의 장바구니 상품 개수를 1로 저장
	list.add(goods);   //list에 해당 상품 객체 저장
}
response.sendRedirect("product.jsp?id=" + id);   //해당 상품의 상세보기 페이지로 이동 (이전 페이지라고 볼 수 있음)
%>