package utils;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

public class JSFunction {
	//(메서드 호출 형식) 메시지 알림창을 띄운 후 명시한 URL로 이동한다
	public static void alertLocation(String msg, String url, JspWriter out) {
		try {
			String script = ""   //삽입할 자바스크립트 코드
						+ "<script>"
						+ "    alert('" + msg + "');"
						+ "    location.href='" + url + "';"
						+ "</script>";
			out.println(script);   //자바스크립트 코드를 out 내장 객체로 출력(삽입)
		}
		catch(Exception e) {}
	}
	
	//(메서드 호출 형식) 메시지 알림창을 띄운 후 이전 페이지로 돌아간다
	public static void alertBack(String msg, JspWriter out) {
		try {
			String script = ""
						+ "<script>"
						+ "    alert('" + msg + "');"
						+ "    history.back();"
						+ "</script>";
			out.println(script);
		}
		catch(Exception e) {}
	}
	
	//(http servlet 요청 형식) 메시지 알림창을 띄운 후 명시한 URL로 이동한다
	public static void alertLocation(HttpServletResponse resp, String msg, String url) {
		try {
			//반환 객체의 타입과 문자셋 설정
			resp.setContentType("text/html; charset=UTF-8");
			//반환 객체에 대한 출력기
			PrintWriter writer = resp.getWriter();
			String script = ""
						+ "<script>"
						+ "    alert('" + msg + "');"
						+ "    location.href='" + url + "';"
						+ "</script>";
			writer.print(script);
		}
		catch(Exception e) {}
	}
	
	//(http servlet 요청 형식) 메시지 알림창을 띄운 후 이전 페이지로 돌아간다
	public static void alertBack(HttpServletResponse resp, String msg) {
		try {
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			String script = ""
						+ "<script>"
						+ "    alert('" + msg + "');"
						+ "    history.back();"
						+ "</script>";
			writer.print(script);
		}
		catch(Exception e) {}
	}
}
