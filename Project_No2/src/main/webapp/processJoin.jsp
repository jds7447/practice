<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<%@ page import="dto.MemberDTO" %>
<%
//폼값 받기
String user_id = request.getParameter("user_id");
String user_pw = request.getParameter("user_pw");
String user_name = request.getParameter("user_name");
String phoneNum = request.getParameter("phoneNum");
String birthday = request.getParameter("bir_Y") + "-" + request.getParameter("bir_M") + "-" + request.getParameter("bir_D");
String gender = request.getParameter("gender");
String postcode = request.getParameter("postcode");
String address = request.getParameter("address") + request.getParameter("extraAddress") + request.getParameter("detailAddress");

//web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

//폼값을 DTO 객체에 저장
MemberDTO dto = new MemberDTO();
dto.setId(user_id);
dto.setPass(user_pw);
dto.setName(user_name);
dto.setPhoneNum(phoneNum);
dto.setBirthday(birthday);
dto.setGender(gender);
dto.setPostcode(postcode);
dto.setAddress(address);

//DAO 객체를 통해 DB에 DTO 저장
MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
int result = dao.insertUser(dto);
dao.close();

//성공or실패
if(result == 1) {
	response.sendRedirect("thankJoin.jsp");
} else {
	
}
%>