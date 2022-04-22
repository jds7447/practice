<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dto.Product" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="utils.JSFunction" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
//요청 객체의 문자셋 설정
request.setCharacterEncoding("UTF-8");

String filename = "";   //받아온 이미지 파일 이름 넣을 변수
String realFolder = "C:/upload";   //파일 저장할 절대 경로
String encType = "UTF-8";   //인코딩 타입
int maxSize = 5 * 1024 * 1024;   //최대 업로드 될 파일의 크기 5MB

//파일 업로드를 위한 MultipartRequest 객체 생성 (요청 객체, 파일 업로드 경로, 파일 최대 사이즈, 인코딩 문자셋, 파일 이름 중복 시 설정)
//DefaultFileRenamePolicy() : 파일 이름 중복 시 파일이름(1).확장자 처럼 이름 변경 후 업로드 되도록 설정
MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

if(multi == null) {
	JSFunction.alertBack(response, "첨부 파일이 제한 용량을 초과합니다.");
	return;
}

//전달 받은 request 요청 객체에 저장된 요소의 name 속성 값으로 value 속성 값 가져오기
String productId = multi.getParameter("productId");   //상품 아이디
String pname = multi.getParameter("name");   //상품명
String unitPrice = multi.getParameter("unitPrice");   //상품 가격
String description = multi.getParameter("description");   //상품 설명
String manufacturer = multi.getParameter("manufacturer");   //제조사
String category = multi.getParameter("category");   //분류, 목록표(리스트)
String unitsInStock = multi.getParameter("unitsInStock");   //재고 수
String condition = multi.getParameter("condition");   //신상품 or 중고품 or 재생품

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

Enumeration files = multi.getFileNames();
String fname = (String) files.nextElement();
String fileName = multi.getFilesystemName(fname);
String ext = fileName.substring(fileName.lastIndexOf("."));   //파일 확장자 (파일 이름의 .을 기준으로 .부터 나머지 문자 반환)
String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());   //현재 날짜를 (20220314_204738458) 형식으로 설정
String newFileName = now + ext;   //새로운 파일 이름 ("업로드일시.확장자")


//저장소의 공용 인스턴스를 생성
ProductDAO dao = new ProductDAO();

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
newProduct.setOfile(fileName);
newProduct.setSfile(newFileName);

//셋팅된 상품 객체를 저장소에 저장
int result = dao.insertProduct(newProduct);
System.out.println("insertProduct 결과 : " + result);

//products.jsp (상품 목록) 페이지로 강제 이동
response.sendRedirect("products.jsp");
%>