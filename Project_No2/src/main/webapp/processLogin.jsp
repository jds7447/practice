<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.MemberDAO" %>
<%@ page import="dto.MemberDTO" %>

<%
//로그인 폼으로부터 받은 아이디와 패스워드
String userId = request.getParameter("user_id");
String userPw = request.getParameter("user_pw");

//web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

//회원 테이블 DAO를 통해 회원 정보 DTO 획득
MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
MemberDTO memberDTO = dao.getMemberDTO(userId, userPw);
dao.close();
String msg = "0";

//로그인 성공 여부에 따른 처리
if(memberDTO.getId() != null){
	//로그인 성공
	session.setAttribute("UserId", memberDTO.getId());  //memberDTO에 입력된 id값을 가져온다 ->musthave
	session.setAttribute("UserName", memberDTO.getName());  //memberDTO.getName() -> 머스트해브
	response.sendRedirect("main.jsp");
} //값이 확장된다. 값은 변화되어지고 변화하면서 돌아올 수 있다.
else {
	//로그인 실패
	//out.println("<script>alert('아이디 또는 비밀번호를 확인해주세요.');</script>");
	request.setAttribute("LoginErrMsg", "아이디 또는 비밀번호를 확인해주세요.");
	request.getRequestDispatcher("loginForm.jsp").forward(request, response);
	//request.getRequestDispatcher("msg").forward(request, response);
}
%>