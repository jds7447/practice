//2022-03-17 작성

//addProduct 입력 요소의 유효성 검사
function CheckAddProduct() {
	
	//각 요소의 id 속성을 이용해 DOM 객체 생성
	var productId = document.getElementById("productId");
	var name = document.getElementById("name");
	var unitPrice = document.getElementById("unitPrice");
	var unitsIntStock = document.getElementById("unitsInStock");
	
	//상품 아이디 체크
	// /^P[0-9]{4,11}$/ : P로 시작해서 0~9 의 숫자가 4이상 11이하 반복
	// 즉, 상품 아이디는 P1234 부터 P12345678901 까지 가능
	if(!check(/^P[0-9]{4,11}$/, productId, "[상품코드]\nP와 숫자를 조합하여 5~12자까지 입력하세요\n첫 글자는 반드시 P로 시작하세요")) {
		return false;
	}
	
	//상품명 체크
	//id 속성이 name 인 요소에 입력된 값의 길이가 4보다 작거나 12보다 크면 true
	if(name.value.length < 4 || name.value.length > 12) {
		alert("[상품명]\n최소 4자에서 최대 50자까지 입력하세요");
		name.select();   //해당 요소에 입력된 데이터가 드래그 된 상태가 됨 (즉, 키 한번 눌러서 바로 수정할 수 있게 드래그 됨)
		name.focuse();   //해당 요소로 키보드 커서가 이동
		return false;
	}
	
	//상품 가격 체크
	//id 속성이 unitPrice 인 요소에 입력된 값의 길이가 0이거나 숫자가 아니면 true
	if(unitPrice.value.length == 0 || isNaN(unitPrice.value)) {
		alert("[가격]\n숫자만 입력하세요");
		unitPrice.select();
		unitPrice.focus();
		return false;
	}
	//id 속성이 unitPrice 인 요소에 입력된 값의 길이가 0보다 작으면
	if(unitPrice.value < 0) {
		alert("[가격]\n음수를 입력할 수 없습니다");
		unitPrice.select();
		unitPrice.focus();
		return false;
	}
	// /^\d+(?:[.]?[\d]?[\d])?$/ : 1개 이상의 숫자 뒤에 오는 값이 없거나 . 이거나 .숫자 이거나 .숫자숫자
	//							<예시> 1 또는 1. 또는 1.1 또는 1.11
	// /^ : 정규 표현식의 시작 (줄의 시작점)
	// \d+ : 숫자가 최소 1개이상
	// (?:패턴) : 그룹 분류 (괄호 내의 패턴을 하나로 본다)
	// [] : 괄호 안에 문자들 중 하나
	// [.]? : . 이 없거나 1개
	// [\d]? : 숫자 가 없거나 1개
	// [\d]? : 숫자 가 없거나 1개
	// (?:패턴)? : 괄호 그룹의 패턴이 없거나 1개까지 존재할 수 있음
	// $/ : 정규 표현식의 끝 (줄의 끝점)
	else if(!check(/^\d+(?:[.]?[\d]?[\d])?$/, unitPrice, "[가격]\n소수점 둘째 자리까지만 입력하세요")) {
		return false;
	}
	
	//재고 수 체크
	//id 속성이 unitsInStock 인 요소에 입력된 값이 숫자가 아니면 true
	if(isNaN(unitsInStock.value)) {
		alert("[재고 수]\n숫자만 입력하세요");
		unitInStock.select();
		unitsInStock.focus();
		return false;
	}
	
	//정규 표현식, DOM 객체, 메시지를 매개변수로 받는 함수
	function check(regExp, e, msg) {
		if(regExp.test(e.value)) {   //DOM 객체 e 요소의 값이 regExp 정규 표현식을 만족하면 
			return true;   //true 리턴 후 함수 종료
		}
		alert(msg);
		e.select();
		e.focus();
		return false;
	}
	
	//문서에서 name 속성이 newProduct 인 요소를 submit 시킨다
	document.newProduct.submit();
}