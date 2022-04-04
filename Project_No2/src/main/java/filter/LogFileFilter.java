//2022-03-22 작성

package filter;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class LogFileFilter implements Filter {
	
	PrintWriter writer;

	//필터 초기화 (web.xml 파일에 설정한 filter-mapping 조건으로 현재 클래스 호출 시 제일 먼저 호출되는 메서드)
	public void init(FilterConfig config) throws ServletException {
		//FilterConfig : 초기화 중에 필터에 정보를 전달하기 위해 서블릿 컨테이너에서 사용하는 필터 구성 개체
		//즉, web.xml에서 지정된 필터 매핑 발생 시 필터 클래스 호출(요청)할 때 init-param 값으로 전달하는 값을 담아두는 객체
		
		//전달 받은 초기화 파라미터(init-param)에서 name이 filename 인 요소의 값 가져오기
		String filename = config.getInitParameter("filename");   //로그 기록 저장할 파일 경로 값

		if (filename == null)   //가져온 값이 비어있으면 로그 파일 경로 설정이 잘못 됨
			throw new ServletException("로그 파일의 이름을 찾을 수 없습니다.");

		try {
			/*
			 * new FileWriter(파일경로, true)
			 * 파일경로에 대한 출력스트림 생성
			 * true이면 해당 파일의 끝 부분에 데이터 추가
			 * false는 앞에 추가
			 */
			/*
			 * new PrintWriter(출력스트림, true)
			 * 출력스트림으로 연결된 파일에 대하여 데이터 입력을 보조할 보조스트림 생성
			 * true이면 println, printf 또는 format 메서드가 출력 버퍼를 플러시 (즉 별도 flush() 없이 바로 적용)
			 */
			//전달 받은 파일 경로 대한 출력 스트림 생성 (로그 기록을 위한)
			writer = new PrintWriter(new FileWriter(filename, true), true);
		} catch (IOException e) {
			throw new ServletException("로그 파일을 열 수 없습니다.");
		}
	}

	/*
	 * public void doFilter(ServletRequest request, SevletResponse response, FilterChain chain) throws java.io.IOException, ServletException
	 * 필터의 doFilter 메소드는 체인 끝에 있는 리소스에 대한 클라이언트 요청으로 인해 요청/응답 쌍이 체인을 통해 전달될 때마다 컨테이너에 의해 호출됨
	 * 이 메소드에 전달된 FilterChain은 필터가 요청을 전달할 수 있도록 합니다
	 * 그리고 체인의 다음 엔티티에 대한 응답
	 * 이 방법의 일반적인 구현은 다음 패턴을 따릅니다
	 * 1. 요청 검토
	 * 2. 선택적으로 요청 객체를 사용자 정의 구현으로 래핑하여 입력 필터링을 위해 콘텐츠 또는 헤더를 필터링합니다
	 * 3. 선택적으로 응답 개체를 사용자 정의 구현으로 래핑하여 출력 필터링을 위한 콘텐츠 또는 헤더를 필터링합니다
	 * 4. FilterChain 객체(chain.doFilter())를 사용하여 체인의 다음 엔티티를 호출하거나,
	 * 		또는 요청 처리를 차단하기 위해 필터 체인의 다음 엔터티에 요청/응답 쌍을 전달하지 않음
	 * 5. 필터 체인에서 다음 엔터티를 호출한 후 응답에 헤더를 직접 설정합니다
	 * 매개변수:
	 * request - ServletRequest 객체는 클라이언트의 requestresponse를 포함합니다
	 * ServletResponse 객체는 필터의 응답 체인을 포함합니다
	 * 다음 필터를 호출하기 위한 FilterChain
	 */
	//필터 역할을 하는 메서드
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws java.io.IOException, ServletException {
		//필터 체인 : 여러 개의 필터가 모여 하나의 체인을 생성할 수 있다
//		첫 번째 매개변수 ServletRequest 객체는 체인을 따라 전달하는 요청이고, 
//		두 번째 매개변수 ServletResponse 객체는 체인을 따라 전달할 응답
//		세 번째 매개변수 FilterChain 객체는 체인에서 다음 필터를 호출하는 데 사용
//		만약 호출 필터가 체인의 마지막 필터이면 체인의 끝에서 리소스를 호출

		/*
		 * request.getRemoteAddr()
		 * 요청을 보낸 클라이언트 또는 마지막 프록시의 인터넷 프로토콜(IP) 주소를 반환
		 * HTTP 서블릿의 경우 CGI 변수 REMOTE_ADDR의 값과 동일
		 * 반환값: 요청을 보낸 클라이언트의 IP 주소를 포함하는 문자열
		 */
		writer.println(" 접속한 클라이언트 IP : " + request.getRemoteAddr());
		long start = System.currentTimeMillis();   //UTC 기준 현재 시스템 시간을 (long)밀리초 단위로 반환
		writer.println(" 접근한 URL 경로 : " + getURLPath(request));   //요청 객체로 URL 경로 가져오는 메서드 호출
		writer.println(" 요청 처리 시작 시각 : " + getCurrentTime());   //요청 처리 시작 시간을 가져오는 메서드 호출

		/*
		 * chain.doFilter(request, response)
		 * 체인의 다음 필터가 호출되도록 하거나 호출 필터가 체인의 마지막 필터인 경우 체인 끝에 있는 리소스가 호출
		 */
		chain.doFilter(request, response);

		long end = System.currentTimeMillis();   //UTC 기준 현재 시스템 시간을 (long)밀리초 단위로 반환
		writer.println(" 요청 처리 종료 시각 : " + getCurrentTime());   //요청 처리 종료 시간을 가져오는 메서드 호출
		writer.println(" 요청 처리 소요 시간 : " + (end - start) + "ms");
		writer.println(" ===================================================");
	}

	/* 
	 * public void destroy()
	 * 필터가 웹 콘테이너에서 삭제될 때 호출된다 
	 */
	public void destroy() {
		writer.close();
	}
	
	//요청지(클라이언트)에서 요청(접근)한 URL 경로 도출 메서드
	private String getURLPath(ServletRequest request) {
		/*
		 * HttpServletRequest
		 * ServletRequest의 sub-interface이다
		 * ServletRequest와 같이 서블릿 컨테이너는 HttpServletRequest를 생성한 후
		 * 서블릿의 service 메서드(doGet, doPost, etc)의 인자로 넘긴다
		 */
		HttpServletRequest req;   //http(웹 브라우저)의 요청 처리를 위한 요청 객체 변수 선언
		String currentPath = "";
		String queryString = "";
		
		/*
		 * instanceof 연산자
		 * 참조변수가 참조하고 있는 인스턴스의 실제 타입을 알아보기 위해 instanceof 연산자를 사용
		 * 주로 조건문에 사용되며, instanceof의 왼쪽에는 참조변수를 오른쪽에는 타입(클래스명)이 피연산자로 위치
		 * 그리고 연산의 결과로 boolean값인 true, false 중의 하나를 반환
		 * instanceof를 이용한 연산결과로 true를 얻었다는 것은 참조변수가 검사한 타입으로 형변환이 가능하다는 것을 뜻함
		 */
		//매개변수로 전달받은 request 요청 객체가 HttpServletRequest 클래스로 형 변환이 가능한지
		if (request instanceof HttpServletRequest) {   //HttpServletRequest 클래스는 ServletRequest를 상속 받으므로 가능
			req = (HttpServletRequest) request;   //request 요청 객체를 HttpServletRequest 클래스로 다운 캐스팅
			/*
			 * req.getRequestURI()
			 * HTTP 요청의 첫 번째 줄에 있는 쿼리 문자열까지 프로토콜 이름에서 이 요청의 URL 부분을 반환
			 * 웹 컨테이너는 이 문자열을 디코딩하지 않습니다
			 * 스키마와 호스트로 URL을 재구성하려면 HttpUtils.getRequestURL(javax.servlet.http.HttpServletRequest)을 사용하십시오
			 * 반환값: 프로토콜 이름에서 쿼리 문자열까지의 URL 부분을 포함하는 문자열
			 */
			currentPath = req.getRequestURI();
			/*
			 * req.getQueryString()
			 * 경로 뒤의 requestURL에 포함된 쿼리 문자열을 반환
			 * 이 메서드는 URL에 쿼리 문자열이 없는 경우 null을 반환
			 * CGI 변수 QUERY_STRING의 값과 동일
			 * 반환값: 쿼리 문자열을 포함하는 문자열 또는 URL에 쿼리 문자열이 포함되지 않은 경우 null (값은 컨테이너에 의해 디코딩되지 않습니다)
			 */
			queryString = req.getQueryString();
			//경로(url) 뒤의 쿼리 스트링 값이 null이면 값을 공백으로 처리
			//경로(url) 뒤의 쿼리 스트링 값이 null이 아니면 갚 앞에 ? 를 추가하여 저장 (상세 경로를 위해 url 경로 뒤에 붙이기 위해) 
			queryString = queryString  == null ? "" : "?" + queryString ;
		}
		return currentPath + queryString;   //url 경로와 (값이 있다면) ?쿼리스트링(상세경로) 를 붙여서 반환
	}
	
	//호출 시 UTC 기준 현재 시스템 시간을 지정된 형식으로 반환하는 메서드
	private String getCurrentTime() {
		//날짜, 시간 형식을 적용하기 위한 포맷
		DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		/*
		 * Calendar
		 * Date 클래스의 업그레이드 버전으로 Datd와 마찬가지로 날짜와 시간에 관련된 데이터를 쉽게 처리할수있다
		 * 국가별, 시간대별 시간을 정확히 알수있도록 제공
		 * Java.util.Calendar 는 날짜와 시간을 객체 모델링화 한 클래스
		 * 년, 원, 일, 요일, 시간, 분 등과 같은 날짜, 시간정보를 제공
		 * 원하는 날짜, 시간 데이터만 가져오거나 혹은 원하는 날짜, 세간으로 셋팅할 수 있다
		 */
		Calendar calender = Calendar.getInstance();
		/*
		 * System.currentTimeMillis()
		 * UTC 기준 현재 시스템 시간을 (long)밀리초 단위로 반환
		 */
		/*
		 * calender.setTimeInMillis(밀리초)
		 * 주어진 long 값에서 이 캘린더의 현재 시간을 설정
		 * 즉, 캘린더의 현재 시간을 UTC 기준 현재 시스템 시간으로 설정
		 */
		calender.setTimeInMillis(System.currentTimeMillis());
		/*
		 * calender.getTime()
		 * 설정한 캘린더에서 시간 값을 나타내는 date 객체를 반환
		 */
		/*
		 * formatter.format(Date)
		 * 전달한 날짜, 시간 값을 지정한 포맷 형식으로 설정하여 반환
		 */
		return formatter.format(calender.getTime());
	}
}