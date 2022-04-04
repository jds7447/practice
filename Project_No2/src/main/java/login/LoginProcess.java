package login;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import membership.MemberDAO;
import membership.MemberDTO;


@WebServlet("/login.LoginProcess.do")
public class LoginProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public LoginProcess() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("user_id");
		String userPwd = request.getParameter("user_pw");
		
		ServletContext application = getServletContext();
		
		//web.xml에서 가져온 데이터베이스 연결 정보 변수에 저장
		String oracleDriver = application.getInitParameter("OracleDriver");
		String oracleURL = application.getInitParameter("OracleURL");
		String oracleId = application.getInitParameter("OracleId");
		String oraclePwd = application.getInitParameter("OraclePwd");

		//회원 테이블 DAO를 통해 전달 받은 id와 pw로 회원 정보 DTO 획득
		MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);   //BB 접속
		MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);   //id와 pw에 대한 데이터 조회
		dao.close();   //DB 접속 해제

		//로그인 성공 여부에 따른 처리
		if(memberDTO.getId() != null) {   //조회한 데이터가 비어있지 않으면 (해당 id와 pw의 데이터가 있으면)
			
			HttpSession session = request.getSession();
			
			//로그인 성공 (회원)
			session.setAttribute("UserId", memberDTO.getId());   //세선의 UserId name에 해당 회원 id를 value로 저장
			session.setAttribute("UserName", memberDTO.getName());   //세선의 UserName name에 해당 회원 이름을 value로 저장
			response.sendRedirect("./LoginForm.jsp");   //리다이렉트로 LoginForm.jsp 페이지를 다시 불러온다 (페이지 이동? 신규 페이지 생성? 느낌)
		}
		else {   //조회한 데이터가 내용이 없으면
			//로그인 실패
			request.setAttribute("LoginErrMsg", "로그인 오류입니다.");   //요청 객체에 해당 name의 value 저장
			//브라우저의 페이지 변화 없이 서버 단에서의 LoginForm.jsp 페이지로 이동(요청 객체와 응답 객체를 인수로 전달)
			request.getRequestDispatcher("./LoginForm.jsp").forward(request, response);
		}
	}

}
