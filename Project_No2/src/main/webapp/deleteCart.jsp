<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dto.Product" %>

<%
String id = request.getParameter("cartId");   //요청 시 전달 받은 id 파라미터의 값 저장
if(id == null || id.trim().equals("")) {   //해당 값이 비었으면
	response.sendRedirect("./cart.jsp");   //장바구니 페이지로 이동
	return;   //현재 페이지 종료
}

//session.invalidate()  :  강제로 세션을 만료시켜 세션에 저장된 내용 모두 삭제 
session.invalidate();

response.sendRedirect("./cart.jsp");   //장바구니 페이지로 이동
%>