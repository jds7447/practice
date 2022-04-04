<!-- 2022-03-10 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>

<!-- 2022-03-17 추가-------------------------------------------------------------------------------- -->
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<!-- 2022-03-17 추가 끝------------------------------------------------------------------------------ -->

<%
//요청 객체의 문자셋 설정
request.setCharacterEncoding("UTF-8");

//2022-03-17 변경---------------------------------------------------------------------------
//한번 더 한글로 해당 정확한 명칭 적어보기
//요청 객체에서 해당 파라미터 이름(name) 에 대해 매칭되는 값(value)을 문자열로 반환 받아 저장 
/* String productId = request.getParameter("productId");   //상품 아이디
String pname = request.getParameter("pname");   //상품명
String unitPrice = request.getParameter("unitPrice");   //상품 가격
String description = request.getParameter("description");   //상품 설명
String manufacturer = request.getParameter("manufacturer");   //제조사
String category = request.getParameter("category");   //분류, 목록표(리스트)
String unitsInStock = request.getParameter("unitsInStock");   //재고 수
String condition = request.getParameter("condition");   //신상품 or 중고품 or 재생품 */

String filename = "";   //받아온 이미지 파일 이름 넣을 변수
String realFolder = "C:/upload";   //웹 어플리케이션 상의 절대 경로
String encType = "UTF-8";   //인코딩 타입
int maxSize = 5 * 1025 * 1024;   //최대 업로드 될 파일의 크기 5MB

//파일 업로드를 위한 MultipartRequest 객체 생성 (요청 객체, 파일 업로드 경로, 파일 최대 사이즈, 인코딩 문자셋, 파일 이름 중복 시 설정)
//DefaultFileRenamePolicy() : 파일 이름 중복 시 파일이름(1).확장자 처럼 이름 변경 후 업로드 되도록 설정
MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

//전달 받은 request 요청 객체에 저장된 요소의 name 속성 값으로 value 속성 값 가져오기
String productId = multi.getParameter("productId");   //상품 아이디
String pname = multi.getParameter("name");   //상품명
String unitPrice = multi.getParameter("unitPrice");   //상품 가격
String description = multi.getParameter("description");   //상품 설명
String manufacturer = multi.getParameter("manufacturer");   //제조사
String category = multi.getParameter("category");   //분류, 목록표(리스트)
String unitsInStock = multi.getParameter("unitsInStock");   //재고 수
String condition = multi.getParameter("condition");   //신상품 or 중고품 or 재생품
//2022-03-17 변경 끝-------------------------------------------------------------------------

//저장소에 정의된 가격 변수는 정수형
Integer price;

if(unitPrice.isEmpty()) {   //가져온 상품 가격 값이 없으면 0 적용
	price = 0;
}
else {   //가져온 상품 가격 값을 정수 래퍼 객체로 변환해 저장
	price = Integer.valueOf(unitPrice);
}

//저장소에 정의된 재고 변수는 Long 정수형
long stock;

if(unitsInStock.isEmpty()) {   //가져온 재고 값이 없으면 0 적용
	stock = 0;
}
else {   //가져온 재고 값을 Long 정수 래퍼 객체로 변환해 저장
	stock = Long.valueOf(unitsInStock);
}

//2022-03-17 추가---------------------------------------------------------------------------
Enumeration files = multi.getFileNames();
String fname = (String) files.nextElement();
String fileName = multi.getFilesystemName(fname);
//폼 페이지에서 전송되어 서버에 업로드 된 파일을 가져오도록
//MultipartRequest 객체 타입의 getFilesystemName() 메서드를 작성한다
//2022-03-17 추가 끝-------------------------------------------------------------------------

//저장소의 공용 인스턴스를 생성
ProductRepository dao = ProductRepository.getInstance();

//제품(상품) 객체를 생성하여 위에서 전달 받은 모든 데이터를 셋팅
Product newProduct = new Product();
newProduct.setProductId(productId);
newProduct.setPname(pname);
newProduct.setUnitPrice(price);
newProduct.setDescription(description);
newProduct.setManufacturer(manufacturer);
newProduct.setCategory(category);
newProduct.setUnitsInStock(stock);
newProduct.setCondition(condition);

//2022-03-17 추가---------------------------------------------------------------------------
newProduct.setFilename(fileName);
//2022-03-17 추가 끝-------------------------------------------------------------------------

//셋팅된 상품 객체를 저장소에 저장
dao.addProduct(newProduct);

//products.jsp (상품 목록) 페이지로 강제 이동
response.sendRedirect("products.jsp");
%>