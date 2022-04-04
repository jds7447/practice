package membership;

//회원 클래스 (각 회원 정보 객체)
public class MemberDTO {
	//멤버 변수 선언
	private String id;   //회원 id
	private String pass;   //회원 pw
	private String name;   //회원 이름
	private String regidate;   //회원 가입일
	
	//멥버 변수별 게터와 세터
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegidate() {
		return regidate;
	}
	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
}
