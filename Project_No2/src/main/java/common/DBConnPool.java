package common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConnPool {
	public Connection con;   //오라클 연결 객체 변수
	public Statement stmt;   //질의 수행을 위한 객체 변수, 스스로는 SQL 구문 이해 못함(구문해석 X) -> 전달역할, SQL 관리 O + 연결 정보 X
	public PreparedStatement psmt;   //Statement 클래스의 기능 향상, 인자와 관련된 작업이 특화(매개변수), 코드량이 증가 -> 매개변수를 set해줘야하기 때문에, 텍스트 SQL 호출
	public ResultSet rs;   //질의 결과를 위한 객체 변수
	
	//기본 생성자
	public DBConnPool() {
		try {
			//커넥션 풀(DataSource) 얻기
			//InitialContext()는 웹 애플리케이션이 처음 배치될 때 설정되고,
			//모든 설정된 엔트리와 자원은 JNDI namespace의 java:comp/env 에 놓이게 됨
			Context initCtx = new InitialContext();
			Context ctx = (Context)initCtx.lookup("java:comp/env");   //root 디렉터리
			//모든 자원은 위의 root 디렉터리 아래에 위치하게 된다
			DataSource source = (DataSource)ctx.lookup("dbcp_myoracle");
			//root 디렉터리에서 얻어오는 dbcp_myoracle 이 커넥션 풀이 된다
			//커넥션풀에는 여러개의 Connection 객체가 생성되어 운용되는데
			//이를 직접 웹 애플리케이션에서 다루기 힘들기 때문에 DataSource라는 개념을 도입
			//커넥션 풀의 Connection을 관리하기 위한 객체
			//JNDI Server를 통해서 이용
			//DataSource 객체를 통해서 필요한 Connection을 획득, 반납 등의 작업 수행
			
			//커넥션 풀을 통해 연결 얻기
			con = source.getConnection();
			
			System.out.println("DB 커넥션 풀 연결 성공");
		}
		catch(Exception e) {
			System.out.println("DB 커넥션 풀 연결 실패");
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
			if(con != null) con.close();   //자동으로 커넥션 풀로 반납됨
			
			System.out.println("JDBC 자원 해제");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
