<%-- 2022-03-24 작성 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.URLEncoder" %>

<%
//전달 받은 요청 객체의 한글을 읽을 수 있게 인코딩
request.setCharacterEncoding("UTF-8");

//전달 받은 요청 객체에서 각 파라미터 값을 빼와 한글을 읽을 수 있게 utf-8로 인코딩 후 쿠키 값으로 저장
//주문자가 나중에 다시 요청했을 때 주문자의 데이터를 알 수 있도록 쿠키를 생성
//new Cookie(이름, 값)
Cookie cartId = new Cookie("Shipping_cartId", URLEncoder.encode(request.getParameter("cartId"), "utf-8"));
Cookie name = new Cookie("Shipping_name", URLEncoder.encode(request.getParameter("name"), "utf-8"));
Cookie shippingDate = new Cookie("Shipping_shippingDate", URLEncoder.encode(request.getParameter("shippingDate"), "utf-8"));
Cookie country = new Cookie("Shipping_country", URLEncoder.encode(request.getParameter("country"), "utf-8"));
Cookie zipCode = new Cookie("Shipping_zipCode", URLEncoder.encode(request.getParameter("zipCode"), "utf-8"));
Cookie addressName = new Cookie("Shipping_addressName", URLEncoder.encode(request.getParameter("addressName"), "utf-8"));

//shippingDate를 제외한 나머지 쿠키의 유지 시간을 24시간으로 설정
cartId.setMaxAge(24 * 60 * 60);
name.setMaxAge(24 * 60 * 60);
country.setMaxAge(24 * 60 * 60);
zipCode.setMaxAge(24 * 60 * 60);
addressName.setMaxAge(24 * 60 * 60);

//생성한 각 쿠키를 응답 객체에 삽입
response.addCookie(cartId);
response.addCookie(name);
response.addCookie(shippingDate);
response.addCookie(country);
response.addCookie(zipCode);
response.addCookie(addressName);

//설정한 응답 객체를 요청지로 반환하며, orderConfirmation.jsp 페이지로 새로 요청하도록 리다이렉트
response.sendRedirect("orderConfirmation.jsp");
%>