<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.ProductDAO" %>
<%@ page import="dto.Product" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	ProductDAO dao = new ProductDAO();
	
	Map<String, Object> search = new HashMap<String, Object>();
	Product product = dao.selectListById(search, id);
	//String sDirectory = request.getServletContext().getRealPath("C:/upload");
	File file = new File("C:/upload" + File.separator + product.getOfile());
	if(file.exists()) {   //해당 파일이 존재한다면
		file.delete();   //삭제한다
	}
	
	int result = dao.deleteProduct(id);
	System.out.println("deleteProduct 결과 : " + result);
	
	dao.close();
	
	response.sendRedirect("products.jsp");
%>