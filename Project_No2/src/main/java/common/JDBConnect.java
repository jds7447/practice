package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletContext;

public class JDBConnect {
	public Connection con;   //오라클 연결 객체 변수
	public Statement stmt;   //질의 수행을 위한 객체 변수, 스스로는 SQL 구문 이해 못함(구문해석 X) -> 전달역할, SQL 관리 O + 연결 정보 X
	public PreparedStatement psmt;   //Statement 클래스의 기능 향상, 인자와 관련된 작업이 특화(매개변수), 코드량이 증가 -> 매개변수를 set해줘야하기 때문에, 텍스트 SQL 호출
	public ResultSet rs;   //질의 결과를 위한 객체 변수
	
	//기본 생성자  (지정된 계정으로 DB 접속)
	public JDBConnect() {
		try {
			//JDBC 드라이버 로드 (해당 클래스 명으로 클래스에 접근하여 로드)
			//오라클 드라이버 객체가 생성되고, DriverManager에 등록됨
			Class.forName("oracle.jdbc.OracleDriver");
			/*
			 * Class.forName
			 * 자바 리플렉션 API(Java Reflection API)의 일부 자바 리플렉션 API란 구체적인 클래스의 타입을
			 * 알지 못해도 클래스의 변수 및 메소드 등에 접근하게 해주는 API입니다.(동적 바인딩) Reflection은 실행중인 자바프로그램 내부를
			 * 검사하고 내부의 속성을 수정할 수 있도록 해줌
			 */
			
			//DB에 연결
			String url = "jdbc:oracle:thin:@localhost:1521:xe";   //sid : 독자적인 서비스가 가능한 DB 인스턴스
//			jdbc : jdbc 라이브러리
//			oracle : 오라클로 연결
//			thin : 자바로 연결 (반대는 OCI - OS로 작동)
//			@localhost :  내 내부 아이피로 접속
//			1521 : 포트번호
//			XE : 리스너
			String id = "musthave";   //오라클 접속 계정 id
			String pwd = "1234";   //오라클 접속 계정 password
			con = DriverManager.getConnection(url, id, pwd);
			//DriverManager에 등록된 드라이버를 통해 url, id, pwd로 DB 접속
			//드라이버 서버에 접속할 수 있는 커넥션 객체를 가져옴 (연결을 관리하는 Connection 객체를 생성)
			
			System.out.println("DB 연결 성공(기본 생성자)");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//두 번째 생성자  (전달 받은 값들로 DB 접속, 자유도가 높음)
	public JDBConnect(String driver, String url, String id, String pwd) {
		try {
			//JDBC 드라이버 로드
			Class.forName(driver);
			
			//DB에 연결
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공(인수 생성자 1)");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//세 번째 생성자 (전달 받은 애플리케이션 영역의 데이터를 읽어 DB 접속)
	//웹 컨테이너가 생성될 때, 전역 변수처럼 먼저 초기화하고 싶은 파라미터들을 web.xml에 미리 설정 가능
	public JDBConnect(ServletContext application) {
		//ServletContext
		//서블릿 컨테이너와 통신하기 위해서 사용되는 메소드를 지원하는 인터페이스
		//서블릿 컨테이너가 시작될 때, 웹 서버에 등록된 웹 애플리케이션 단위로 하나의 ServletContext객체가 자동으로 생성
		//웹 애플리케이션 서비스가 중지될 때 소멸
		//웹 애플리케이션과 생명주기가 같고, 간단하게 웹 컨텍스트, 컨텍스트라고 부르기도 함
		//서블릿 컨테이너가 웹 애플리케이션 단위로 모든 자원을 관리할수 있다
		try {
			//JDBC 드라이버 로드
			String driver = application.getInitParameter("OracleDriver");
			//application.getInitParameter(name)
			//application 내장 객체에 미리 초기화 한 데이터의 이름(OracleDriver)을 이용해 해당 값을 가져온다
			Class.forName(driver);
			
			//DB에 연결
			String url = application.getInitParameter("OracleURL");
			String id = application.getInitParameter("OracleId");
			String pwd = application.getInitParameter("OraclePwd");
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공(인수 생성자 2)");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//연결 해제 (자원 반납)
	public void close() {
		try {
			//DB 사용이 끝났다면 메모리 관리를 위해
			//DB 연결 및 사용을 위한 모든 객체의 자원을 반납한다 (닫는다)
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(psmt != null) psmt.close();
			if(con != null) con.close();
			
			System.out.println("JDBC 자원 해제");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
