//2022-03-18 작성

package common;   //기본 패키기 지외의 패키지 (규약 1번)

public class Person {
	private String name;   //private 멤버 변수 (규약 2번)
	private int age;   //private 멤버 변수 (규약 2번)
	
	public Person() {}   //기본 생성자 (규약 3번)
	public Person(String name, int age) {
		this.name = name;
		this.age = age;
	}
	
	//public 게터/세터 메서드 (규약 4번, 5번)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
}
//자바빈
//하나의 묶음으로 전송하는 것이 훨씬 효율적
//회원 정보를 하나의 묶음으로 관리하기 위해 나온 메커니즘이 자바 빈
//자바 빈은 정보 덩어리로 데이터 저장소
//자바 빈은 데이터를 저장하기 위한 필드와 데이터를 컨트롤하는 getter/setter 메서드를 하나의 쌍으로 가지고 있는 클래스
//자바 빈은 클래스의 특별한 형태라 할 수 있다
//자바 빈은 서블릿에서만 사용되는 기술이 아니다
//자바에서 사용되는 개념인데 그것을 서블릿에서 가져다 사용하는 것이다
//클래스의 필드는 제한자를 private로 하여 외부에서 직접 필드에 접근하지 못하게 하고,
//필드에 값을 저장하고 얻어오기 위해서는 공개형 접근 제한자 메서드를 사용
//이와 같은 방식을 프로퍼티라고 한다
//package com.saeyan.javabeans;
//	  도메인이름.폴더이름.클래스이름
//도 + 폴 = 패키지이름.클래스이름
//자자빈에서 제공하는 액션태그
//<jsp:useBean> : 자바빈을 생성
//<jsp:getProperty> : 자바빈에서 정보를 가져옴
//<jsp:setProperty> : 자바빈에 정보를 저장함