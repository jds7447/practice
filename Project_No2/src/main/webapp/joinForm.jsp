<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<meta charset="UTF-8">
	<title>쇼핑도 취미다, 오버페이 마켓</title>
	<style>
	   .card {
	        margin: 0 auto; /* Added */
	        float: none; /* Added */
	        margin-bottom: 100px; /* Added */
	        margin-top: 100px;
		}
	</style>
</head>
<body style="padding-top: 57px;">
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원가입</h1>
		</div>
	</div>
	<span style="color: red; font-size: 1.2em;">
		<%=request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg") %>
	</span>
	<%
	//session 영역에 UserId값이 비어있으면
	if(session.getAttribute("UserId") == null) { //로그인 상태 확인
		//로그아웃 상태
	%>
	<script>
	function validateForm(form) { //form 객체를 매개변수로 받아
		if(!form.user_id.value){ //form의 user_id의 값이 없으면 if문실행
		alert("아이디를 입력하세요.");
		return false;
		}
		if(form.user_pw.value == ""){ //form의 user_pw의 값이 없으면 if문실행
			alert("비밀번호 입력하세요.");
			return false;
		}
		if(form.pw_confirm.value == ""){ //form의 user_pw의 값이 없으면 if문실행
			alert("비밀번호 확인을 입력하세요.");
			return false;
		}
		if(form.user_name.value == ""){ //form의 user_pw의 값이 없으면 if문실행
			alert("이름을 입력하세요.");
			return false;
		}
		if(form.user_birthday.value == ""){ //form의 user_pw의 값이 없으면 if문실행
			alert("생년월일을 입력하세요.");
			return false;
		}
		
		if(form.user_pw.value != form.pw_confirm.value){ //form의 user_pw의 값이 없으면 if문실행
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
	}
	</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
<div class="container">
	<div class="card align-middle" style="width:25rem; border-radius:20px; ">
		<div class="card-title" style="margin-top:30px;">
			<h2 class="card-title text-center" style="color:#113366;">회원정보 입력</h2>	
		</div>
		<div class="card-body">
      		<form class="form-signin" action="processJoin.jsp" method="post" name="loginFrm" onsubmit="return validateForm(this);">
        		<!-- <h5 class="form-signin-heading">회원정보 입력</h5> -->
        		<div class="mb-3">
  					<label for="user_id" class="form-label">아이디</label>
  					<input type="text" class="form-control" name="user_id" placeholder="아이디를 입력해주세요">
  					<label style="font-size: 11px;">영문/숫자 4자리 이상을 입력해 주세요.</label>	
				</div>
				<div class="mb-3">
  					<label for="user_pw" class="form-label">비밀번호</label>
  					<input type="password" class="form-control" name="user_pw" placeholder="비밀번호를 입력해주세요">
  					<label style="font-size: 11px;">8~20자의 영문 대/소문자, 숫자를 사용하세요.</label>
				</div>
				<div class="mb-3">
  					<label for="pw_confirm" class="form-label">비밀번호 확인</label>
  					<input type="password" class="form-control" name="pw_confirm" placeholder="비밀번호를 다시한번 입력해주세요">
				</div>
				<div class="mb-3">
  					<label for="user_name" class="form-label">이름</label>
  					<input type="text" class="form-control" name="user_name" placeholder="이름을 입력해주세요">
				</div>
				<div class="mb-3">
  					<label for="phoneNum" class="form-label">전화번호</label>
  					<input type="text" class="form-control" name="phoneNum" placeholder="전화번호를 입력해주세요">
				</div>
  				<div class="mb-3">
    				<label for="birthday" class="form-label">생년월일</label>
    				<label style="font-size: 11px;">(선택)</label>
    				<div class="row row-cols-3">
    					<div class="col">
    						<select class="form-control" name="bir_Y" required>
      							<option value="0000">년도</option>
            					<option value="2008">2008</option>
								<option value="2007">2007</option>
								<option value="2006">2006</option>
								<option value="2005">2005</option>
								<option value="2004">2004</option>
								<option value="2003">2003</option>
								<option value="2002">2002</option>
								<option value="2001">2001</option>
        						<option value="2000">2000</option>
						        <option value="1999">1999</option>
						        <option value="1998">1998</option>
						        <option value="1997">1997</option>
						        <option value="1996">1996</option>
						        <option value="1995">1995</option>
						        <option value="1994">1994</option>
						        <option value="1993">1993</option>
						        <option value="1992">1992</option>
 						        <option value="1991">1991</option>
						        <option value="1990">1990</option>
						        <option value="1989">1989</option>
						        <option value="1988">1988</option>
						        <option value="1987">1987</option>
						        <option value="1986">1986</option>
						        <option value="1985">1985</option>
						        <option value="1984">1984</option>
						        <option value="1983">1983</option>
						        <option value="1982">1982</option>
						        <option value="1981">1981</option>
						        <option value="1980">1980</option>
						        <option value="1979">1979</option>
						        <option value="1978">1978</option>
						        <option value="1977">1977</option>
						        <option value="1976">1976</option>
						        <option value="1975">1975</option>
						        <option value="1974">1974</option>
						        <option value="1973">1973</option>
						        <option value="1972">1972</option>
						        <option value="1971">1971</option>
 						        <option value="1970">1970</option>
						        <option value="1969">1969</option>
						        <option value="1968">1968</option>
						        <option value="1967">1967</option>
						        <option value="1966">1966</option>
						        <option value="1965">1965</option>
						        <option value="1964">1964</option>
						        <option value="1963">1963</option>
        						<option value="1962">1962</option>
						        <option value="1961">1961</option>
						        <option value="1960">1960</option>
        						<option value="1959">1959</option>
        						<option value="1958">1958</option>
						        <option value="1957">1957</option>
						        <option value="1956">1956</option>
						        <option value="1955">1955</option>
						        <option value="1954">1954</option>
						        <option value="1953">1953</option>
						        <option value="1952">1952</option>
						        <option value="1951">1951</option>
						        <option value="1950">1950</option>
						        <option value="1949">1949</option>
						        <option value="1948">1948</option>
						        <option value="1947">1947</option>
						        <option value="1946">1946</option>
						        <option value="1945">1945</option>
						        <option value="1944">1944</option>
						        <option value="1943">1943</option>
						        <option value="1942">1942</option>
						        <option value="1941">1941</option>
						        <option value="1940">1940</option>
						        <option value="1939">1939</option>
						        <option value="1938">1938</option>
						        <option value="1937">1937</option>
						        <option value="1936">1936</option>
						        <option value="1935">1935</option>
						        <option value="1934">1934</option>
						        <option value="1933">1933</option>
						        <option value="1932">1932</option>
						        <option value="1931">1931</option>
						        <option value="1930">1930</option>
						    </select>
						</div>
						<div class="col">
    						<select class="form-control" name="bir_M" required>
            					<option value="00">월</option>
            					<option value="01">1</option>
        						<option value="02">2</option>
						        <option value="03">3</option>
						        <option value="04">4</option>
						        <option value="05">5</option>
						        <option value="06">6</option>
						        <option value="07">7</option>
						        <option value="08">8</option>
						        <option value="09">9</option>
						        <option value="10">10</option>
						        <option value="11">11</option>
						        <option value="12">12</option>
						    </select>
						</div>
    					<div class="col">	
    						<select class="form-control" name="bir_D" required>
            					<option value="00">일</option>
            					<option value="01">1</option>
						        <option value="02">2</option>
						        <option value="03">3</option>
						        <option value="04">4</option>
						        <option value="05">5</option>
						        <option value="06">6</option>
						        <option value="07">7</option>
						        <option value="08">8</option>
						        <option value="09">9</option>
						        <option value="10">10</option>
						        <option value="11">11</option>
						        <option value="12">12</option>
						        <option value="13">13</option>
						        <option value="14">14</option>
						        <option value="15">15</option>
						        <option value="16">16</option>
						        <option value="17">17</option>
						        <option value="18">18</option>
						        <option value="19">19</option>
						        <option value="20">20</option>
						        <option value="21">21</option>
						        <option value="22">22</option>
						        <option value="23">23</option>
						        <option value="24">24</option>
						        <option value="25">25</option>
						        <option value="26">26</option>
						        <option value="27">27</option>
						        <option value="28">28</option>
						        <option value="29">29</option>
						        <option value="30">30</option>
						        <option value="31">31</option>
						    </select>
						</div>
        			</div>
				</div>

			    <style>
			    	input[name="gender"]:checked + label {
						background-color: #007bff;
						color: white;
					}
			    </style>
				
				<div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label">성별</label>
					<label style="font-size: 11px;">(선택)</label><br>
					<div class="d-grid gap-2 col-6 mx-auto ">
  						<div class="btn-group " role="group" aria-label="Basic radio toggle button group">
							<input type="radio" class="btn-check" name="gender" id="genderM" autocomplete="off" style="display: none;" value="M">
  							<label class="btn btn-outline-secondary" for="genderM">남자</label>
  							<input type="radio" class="btn-check" name="gender" id="genderF" autocomplete="off" style="display: none;" value="F">
  							<label class="btn btn-outline-secondary" for="genderF">여자</label>
						</div>
					</div>
				</div>

				<div class="mb-3">
  					<label for="email" class="form-label">주소</label>
  					<div class="row">
  						<div class="col">
  						<input type="text" class="form-control" name="postcode" id="postcode" placeholder="우편번호">
  						</div>
  						<div class="col">
  						<input type="button" id="btn-address" class="btn btn-primary" onclick="execDaumPostcode()" value="우편번호 찾기">
  						</div>
  					</div>
  					<input type="text" class="form-control" name="address" id="address" placeholder="주소">
  					<input type="text" class="form-control" name="detailAddress" id="detailAddress" placeholder="상세주소">
  					<input type="text" class="form-control" name="extraAddress" id="extraAddress" placeholder="참고항목">
				</div>
        	<button id="btn-login" class="btn btn-lg btn-primary btn-block" type="submit">가입 완료하기</button>
      	</form>
		</div>
	</div>
</div>

	<div class="modal">
	</div>
	
	<%
	} else { //로그인된 상태
	%>
	<%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다. <br />
	<a href="Logout.jsp">[로그아웃]</a>
	<%
	}
	%>
	<div class="container"><hr></div>
	<jsp:include page="footer.jsp" />
</body>
</html>