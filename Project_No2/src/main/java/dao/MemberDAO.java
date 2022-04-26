package dao;

import common.JDBConnect;
import dto.MemberDTO;

public class MemberDAO extends JDBConnect{
	//명시한 데이터베이스로의 연결이 완료된 MemberDAO객체를 생성합니다.
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	
	//명시한 아이디/패스워드와 일치하는 회원정보를 반환합니다.
	public MemberDTO getMemberDTO(String uid, String upass) {
		MemberDTO dto = new MemberDTO(); //회원정보 DTO 객체 생성
		String query = "SELECT * FROM O_MEMBER WHERE id=? AND pass=?";
		//쿼리문 템플릿(서식, 형식, 틀)
		
		try {
			//쿼리 실행
			psmt = con.prepareStatement(query); //동적 쿼리문 준비
			psmt.setString(1, uid); //쿼리문의 첫 번째 인파라미터에 값 설정
			psmt.setString(2, upass); //쿼리문의 두 번째 인파리터에 값 설정
			rs = psmt.executeQuery(); //쿼리문 실행

			
			//결과 처리
			if(rs.next()) {
				//쿼리 결과로 얻은 회원 정보를 DTO 객체에 저장
				dto.setId(rs.getString("id"));  //id와 pass는 위에 1, 2 키를 넣어주었기때문에 id만 써줌
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));  //3번째변수 쿼리스트링? --> 키와 같음
				dto.setPhoneNum(rs.getString(4));;  //4번째변수..
				dto.setBirthday(rs.getString(5));
				dto.setGender(rs.getString(6));
				dto.setPostcode(rs.getString(7));
				dto.setAddress(rs.getString(8));
				dto.setRegidate(rs.getDate(9));  
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return dto; //DTO 객체 반환
	}
	
	//회원가입
	public int insertUser(MemberDTO dto) {
		System.out.println("메소드 멤버 인서트");
		int result = 0;
		
		try {
			//INSERT 쿼리문 작성
			String query = "INSERT INTO O_MEMBER ( "
					+ " id, pass, name, phonenum, birthday, gender, postcode, address, regidate) "
					+ " VALUES ( "
					+ " ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getPhoneNum());
			psmt.setString(5, dto.getBirthday());
			psmt.setString(6, dto.getGender());
			psmt.setString(7, dto.getPostcode());
			psmt.setString(8, dto.getAddress());
			
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("회원가입 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	//아이디 찾기
	public String findId(String user_name, String phoneNum) {
		String resultId = null;
		
		try {
			String query = "SELECT id "
					+ " FROM O_MEMBER "
					+ " WHERE name=? AND phonenum=?";
			
			//쿼리 실행
			psmt = con.prepareStatement(query); //동적 쿼리문 준비
			psmt.setString(1, user_name); //쿼리문의 첫 번째 인파라미터에 값 설정
			psmt.setString(2, phoneNum); //쿼리문의 두 번째 인파리터에 값 설정
			rs = psmt.executeQuery(); //쿼리문 실행
			
			if(rs.next()) {
				
				resultId = rs.getString("id");
			}
		} catch(Exception e) {
			System.out.println("아이디찾기 중 예외 발생");
			e.printStackTrace();
		}
		return resultId;
	}
	
	//비밀번호 찾기
	public String findPw(String user_id, String user_name, String phoneNum) {
		String resultPw = null;
		
		try {
			String query = "SELECT pass "
					+ " FROM O_MEMBER "
					+ " WHERE id=? AND name=? AND phonenum=?";
			
			//쿼리 실행
			psmt = con.prepareStatement(query); //동적 쿼리문 준비
			psmt.setString(1, user_id); //쿼리문의 첫 번째 인파라미터에 값 설정
			psmt.setString(2, user_name); //쿼리문의 두 번째 인파리터에 값 설정
			psmt.setString(3, phoneNum); //쿼리문의 세 번째 인파리터에 값 설정
			rs = psmt.executeQuery(); //쿼리문 실행
			
			if(rs.next()) {
				
				resultPw = rs.getString("pass");
			}
		} catch(Exception e) {
			System.out.println("비밀번호찾기 중 예외 발생");
			e.printStackTrace();
		}
		return resultPw;
	}
	
	//비밀번호 수정하기
	public int editPw(String user_id, String user_pw) {
		int result=0;
		
		try {
			String query = "UPDATE O_MEMBER "
					+ " SET PASS=? "
					+ " WHERE ID=? ";
			
			//쿼리 실행
			psmt = con.prepareStatement(query); //동적 쿼리문 준비
			psmt.setString(1, user_pw); //쿼리문의 첫 번째 인파라미터에 값 설정
			psmt.setString(2, user_id); //쿼리문의 두 번째 인파리터에 값 설정
			rs = psmt.executeQuery(); //쿼리문 실행
			
			result = psmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("비밀번호수정 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}	
}