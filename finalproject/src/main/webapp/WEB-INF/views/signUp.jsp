<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="/webjars/bootstrap/4.6.0-1/css/bootstrap.min.css" rel="stylesheet">
<script src="/webjars/bootstrap/4.6.0-1/js/bootstrap.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<style type="text/css">
.register{
    background: -webkit-linear-gradient(left, #3931af, #00c6ff);
    margin-top: 3%;
    padding: 3%;
}
.register-left{
    text-align: center;
    color: #fff;
    margin-top: 4%;
}
.register-left input{
    border: none;
    border-radius: 1.5rem;
    padding: 2%;
    width: 60%;
    background: #f8f9fa;
    font-weight: bold;
    color: #383d41;
    margin-top: 30%;
    margin-bottom: 3%;
    cursor: pointer;
}
.register-right{
    background: #f8f9fa;
    border-top-left-radius: 10% 50%;
    border-bottom-left-radius: 10% 50%;
}
.register-left img{
    margin-top: 15%;
    margin-bottom: 5%;
    width: 25%;
    -webkit-animation: mover 2s infinite  alternate;
    animation: mover 1s infinite  alternate;
}
/* 반응형 */
@-webkit-keyframes mover {
    0% { transform: translateY(0); }
    100% { transform: translateY(-20px); }
}
@keyframes mover {
    0% { transform: translateY(0); }
    100% { transform: translateY(-20px); }
}
.register-left p{
    font-weight: lighter;
    padding: 12%;
    margin-top: -9%;
}
.register .register-form{
    padding: 10%;
    margin-top: 10%;
}
.btnRegister{
    float: right;
    margin-top: 10%;
    border: none;
    border-radius: 1.5rem;
    padding: 2%;
    background: #0062cc;
    color: #fff;
    font-weight: 600;
    width: 50%;
    cursor: pointer;
}
.register .nav-tabs{
    margin-top: 3%;
    border: none;
    background: #0062cc;
    border-radius: 1.5rem;
    width: 28%;
    float: right;
}
.register .nav-tabs .nav-link{
    padding: 2%;
    height: 34px;
    font-weight: 600;
    color: #fff;
    border-top-right-radius: 1.5rem;
    border-bottom-right-radius: 1.5rem;
}
.register .nav-tabs .nav-link:hover{
    border: none;
}
.register .nav-tabs .nav-link.active{
    width: 100px;
    color: #0062cc;
    border: 2px solid #0062cc;
    border-top-left-radius: 1.5rem;
    border-bottom-left-radius: 1.5rem;
}
.register-heading{
    text-align: center;
    margin-top: 8%;
    margin-bottom: -15%;
    color: #495057;
}
#emailInput{
	width: 80%;
}
#authBtn,#authBtn:link,#authBtn:visited,#authBtn:hover,#authBtn:active{
	background-color: darkblue;
	color: white;
	border: #dee2ee 1px solid;
	margin-left: -20px;
	text-align: center;
	text-indent: -5px;
}
#authBtn{
	position: absolute;
	top: 54px;
	right: 14px;
	width: 20%
}
.tmp{
	visibility: hidden;
}

.modal{
	position: absolute;
	width: 50%;
	height: 50%;
	margin: auto;
	overflow: auto;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	width: 400px;
	text-align: center;
}
#modalTitle{
	margin: 10px;
	font-weight: bold;
	text-align: center;
}
#closeBtn{
	border-top-left-radius: 0;
	border-top-right-radius: 0; 
}

.problem{
	color: red;
}
</style>
<script type="text/javascript">

var csrfToken = $("meta[name='_csrf']").attr("content");
$.ajaxPrefilter(function(options, originalOptions, jqXHR){
	if (options['type'].toLowerCase() === "post") {
		jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	}
});

var pattern_num = /[0-9]/;	// 숫자 

var pattern_eng = /[a-zA-Z]/;	// 문자 

var pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자

var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글체크

$(document).on('click','#authBtn',function() {
	console.log("인증 버튼 누름");
	var code='';
	var codeVerification=false;
	var email=$('#emailInput').val().replace(/\s/gi, '');
	/*	이메일 입력하지 않고 인증버튼 누르면 알림 modal 띄우기
		이 프로젝트에서는 gmail 인증만 진행하도록 함
		따라서, gamil이 아닌 경우에도 알림띄움 */
	if (email==""||!(email.endsWith("@gmail.com"))) {
		console.log("공백/지메일 아님");
		$('#error').modal('show');
		return false;
	} else {
		console.log("이메일 넘겨서 인증번호 전송될 차례");
		// 이 쯤에서 인증버튼을 disabled 시켜야 함 (타이머 적용해야 함)
		/*
			ajax 403 error
			Spring Security 4.2.13으로 인해, 클라이언트에서 서버에 접근하면
			csrf 토큰 검사를 하게 되는데 ajax header에 csrf 토큰이 없으면
			403 에러 발생
		*/
		
		
		// 비동기 통신(POST: 데이터를 body에 담아서 보냄)
		$.ajax({
			url: "/signup",
			type: "POST",
			data: {
				// 이메일 입력 값 (전체 공백 제거)
				email:$("#emailInput").val().replace(/\s/gi,"")
			},
			success: function(data){
				console.log("ajax 성공");
				console.log("인증번호 전송 완료");
				console.log("email: "+email);
				$('#codeSent').modal('show');
				/*
					1. 생각해 볼 부분
						emailInput을 전달해서, 이메일을 발송하는 로직이 수행되는 시간이
						생각보다 길어서 사용자 입장에서 인증 버튼을 누르고 기다려야함
				
					2. 나중에 추가 구현할 부분
						인증 버튼을 disabled 시키고, 5분 타이머 작동
						5분 후에 다시 인증 버튼 보낼 수 있음
						타이머가 끝나면 인증 번호도 invalid 상태로 바꿔야함
				*/
				document.getElementById('codeInput').disabled=false;
				/*
					인증번호 일치 여부
					1. 일치 여부를 input박스 하단에 표기 등
					2. 회원가입 버튼을 눌렀을 때 검증
				*/
				
				
				//요청 후 회원가입 시 값 체크를 위해 아이디 값 저장.
			 	var user=$(".username").val();
				
				$(".btncheck").on("click", function(){
					codeVerification=false;
					// 인증번호
					code=data;
					var codeInput=$('#codeInput').val();
					if(codeInput!=""||code!=""){
						if(codeInput==code){
							console.log('인증코드 일치');
							$('.problem').html("인증에 성공하였습니다.");
							
							//인증 성공 후 회원가입버튼 인증 요청 알림 기능 삭제
							$(".btnRegister").off('click');
							
							//회원가입 버튼 활성화
							$(".joinForm").append($(".btnRegister"));
							
							//회원가입 버튼 클릭 시 값 체크 후 회원가입 완료
							$(".btnRegister").click(function(){
								
								//이메일 인증 시 아이디 값과 현재 값이 다른지 체크 
								if(!(user==$(".username").val())){
									$('.problem').html("강제 변경된 아이디는 허용하지 않습니다.");
									return false;
								//패스워드 값 체크
									//1. 8~16자리 이내
								}else if($('.password1').val().length>16 || $('.password1').val().length<8){
									$('.problem').html('비밀번호는 8~16자리까지 입력해야합니다.');
									return false;
									
									//2. 숫자,영어,특수문자 모두 포함
								}else if(!(pattern_spc.test($('.password1').val())) ||
										!(pattern_num.test($('.password1').val())) ||
										!(pattern_eng.test($('.password1').val())) ){
									$('.problem').html("숫자,영어,특수문자를 포함하여 비밀번호를 입력해주세요.");
									return false;
									//3. 비밀번호 확인 번호와 일치 여부 체크
								}else if(!($('.password1').val()==$('.password2').val())){
									$('.problem').html("비밀번호와 확인번호가 서로 일치하지 않습니다.");
									return false;
									
								//이름 체크
									//1. 2자이상 10자 이하	
								}else if($('.memName').val().length>10 || $('.memName').val().length<2){
									$('.problem').html("이름은 2자 이상 10자리 이내로 입력해주세요.");
									return false;
									//2. $('.memName').val('이름')을 통한 특수문자, 숫자 입력 방어
								}else if(pattern_spc.test($('.memName').val()) || 
										 pattern_num.test($('.memName').val())){
									$('.problem').html("강제 입력한 이름은 허용하지 않습니다.");
									$('.memName').val("");
									return false;
								
								//닉네임 체크
									//1. 2자이상 10자 이하	
								}else if($('.memNickName').val().length>10 || $('.memNickName').val().length<2){
									$('.problem').html("닉네임은 2자 이상 10자리 이내로 입력해주세요.");
									return false;
									//2. $('.memNickName').val('닉네임')을 통한 특수문자 입력 방어
								}else if(pattern_spc.test($('.memNickName').val())){
									$('.problem').html("강제 입력은 허용하지 않습니다.");
									$('.memNickName').val("");
									return false;
								
								//부서 체크
									//1. 2자이상 20자 이하	
								}else if($('.dept').val().length>20 || $('.dept').val().length<2){
									$('.problem').html("부서는 2자 이상 20자리 이내로 입력해주세요.");
									return false;
									//2. $('.dept').val('부서')을 통한 특수문자 입력 방어
								}else if(pattern_spc.test($('.dept').val())){
									$('.problem').html("강제 입력은 허용하지 않습니다.");
									$('.dept').val("");
									return false;
								
								//번호 체크
									//1. 9자이상 15자 이하	
								}else if($('.memPhone').val().length>15 || $('.memPhone').val().length<9){
									$('.problem').html("번호는 9자 이상 15자리 이내로 입력해주세요.");
									return false;
									//2. $('.memPhone').val('번호')을 통한 문자,특수문자 입력 방어
								}else if(!(pattern_num.test($('.memPhone').val()))){
									$('.problem').html("강제 입력은 허용하지 않습니다.");
									$('.memPhone').val("");
									return false;
									
								}else{
									//값을 모두 체크 후 회원가입 신청 완료
									return true
								}
								
							});
							
							
						} else{
							console.log('인증코드 불일치');
							$('.problem').html("인증코드가 일치하지 않습니다.")
							$(".joinForm")
							$(".btnRegister").click(function(){
								return false;
							});
						}
					}

				});
			},
			error: function(){
				console.log("ajax 에러");
				$('#error').modal('show');
			}
		});
	}
});

$(function(){
	
	//아이디(이메일)중복검사 하기 전 이메일 인증번호 전송버튼 비활성화
	$("#authBtn").prop('disabled',"true");
	
	//비동기 통신 (아이디 중복검사)
	$(".userCheck").click(function(){
		var username = $(".username").val();
		$.ajax({
			url: "/usercheck",
			type: "POST",
			data: {username},
			contentType : "application/json; charset=utf-8",
			success: function(data){
						console.log(data);
						if(data=="notNull"){
							alert("사용가능한 아이디입니다.");
							//인증버튼 활성화
							$("#authBtn").removeProp('disabled');
							//인증요청을 하였을 때 아이디를 바꾸지 못하게 readonly
							$(".username").prop("readonly","readonly");
						}else{
							alert("사용중인 아이디입니다.");
						}
					 },
			error: function(){
				console.log("ajax 에러");
				$('#error').modal('show');
			}
			
		});
	});
	
	
	$(".btnRegister").on("click", function(){
		$('.problem').html("인증 먼저 부탁드립니다.");
	});
	
	//패스워드 16자 제한
	$(".password1").keyup(function(){
		if($('.password1').val().length>16){
			$('.password1').val($('.password1').val().substring(0,16));
	}});
	
	$(".password2").keyup(function(){
		if($('.password2').val().length>16){
			$('.password2').val($('.password2').val().substring(0,16));
	}});
	
	//이름 10자 제한 및 숫자, 특수문자 사용 재한
	$('.memName').keyup(function(data){
		if($('.memName').val().length>10){
			$('.memName').val($('.memName').val().substring(0,10));
		}
		
		if(pattern_spc.test($(data).prop('key')) || pattern_num.test($(data).prop('key'))){
			if($(data).prop('key')!='Backspace'){
				$('.problem').html("이름에 숫자 및 특수문자는 사용할 수 없습니다.");
				$('.memName').val("").focus();
			}
		}
	});
	
	//닉네임 10자 제한 및 특수문자 사용 제한
	$('.memNickName').keyup(function(data){
		if($('.memNickName').val().length>10){
			$('.memNickName').val($('.memNickName').val().substring(0,10));
		}
		
		if(pattern_spc.test($(data).prop('key'))){
			if($(data).prop('key')!='Backspace'){
				$('.problem').html("닉네임에 특수문자는 사용할 수 없습니다.");
				$('.memNickName').val("").focus();
			}
		}
	});
	
	//부서 20자 제한 및 특수문자 사용 제한
	$(".dept").keyup(function(data){
		if($('.dept').val().length>20){
			$('.dept').val($('.dept').val().substring(0,20));
		}
		
		if(pattern_spc.test($(data).prop('key'))){
			if($(data).prop('key')!='Backspace'){
				$('.problem').html("부서에 특수문자는 사용할 수 없습니다.");
				$('.dept').val("").focus();
			}
		}
	});
	
	//번호 15자 제한 및 숫자 외 입력 제한
	$(".memPhone").keyup(function(data){
		if($('.memPhone').val().length>15){
			$('.memPhone').val($('.memPhone').val().substring(0,15));
		}
		if(!pattern_num.test($(data).prop('key'))){
			if($(data).prop('key')!='Backspace'){
				$('.problem').html("숫자만 입력 가능합니다.");
				$('.memPhone').val("").focus();
			}
		}
	});
	
});

</script>
<title>이메일인증</title>
</head>
<body>
	<div class="container register">
		<div class="row">
			<div class="col-md-3 register-left">
				<img src="https://image.ibb.co/n7oTvU/logo_white.png" alt=""/>
				<h3>9'o Clock</h3>
				<p>즐거운~♪<br>회원가입~♬<br>우와~♪</p>
				<input type="submit" name="id" value="로그인"/><br/>
				
			</div>
			
			<div class="col-md-9 register-right">
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
						<h3 class="register-heading">회원 가입</h3>
							<div class="row register-form">
								<div class="col-md-11">
								
								 	<form action="/joinMember" method="post" class="joinForm">  
									<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> 
									
									<!-- emailInput에 이메일을 입력하고, 이메일 인증 버튼을 누르면,
										 input값을 넘겨서 이메일 전송 시 to로 받아서 그 이메일로 인증번호 발송 -->
									<div class="form-group">
									<!-- name=서버로 전달되는 이름 -->
										<input type="email" class="form-control username" placeholder="아이디(gmail) *" value="" id="emailInput" name="username"/>
										
									</div>
                                    <div class="form-group">
										<input type="text" class="form-control" id="codeInput" placeholder="인증번호(6자리) *" value="" disabled/>
									</div>
									<div class="form-group">
										<input type="password" class="form-control password1" placeholder="비밀번호 *" value="" name="password" />
									</div>
									<div class="form-group" id="emailPart">
										<input type="password" class="form-control password2"  placeholder="비밀번호 확인 *" value="" />
									</div>
									<div class="form-group">
										<input type="text" class="form-control memName"  placeholder="이름 *" value="" name="memName" />
									</div>
									<div class="form-group">
										<input type="text" class="form-control memNickName"  placeholder="닉네임 *" value="" name="memNickName"/>
									</div>
									<div class="form-group">
									<select name="comCode">      
										<c:forEach items="${company }" var="bean">
								        	<option value="${bean.comCode }" >${bean.comName }</option>
								        </c:forEach>
									</select>
									</div>
									<div class="form-group">
										<input type="text" class="form-control dept"  placeholder="부서 *" value="" name="dept"/>
									</div>
									<div class="form-group">
										<input type="text" class="form-control memPhone"  placeholder="번호 *" value="" name="memPhone"/>
									</div>
									<c:if test="${param.isempty != null }">
									</c:if>
									</form> 
									 <input type="submit" class="btnRegister"  value="회원가입"/>
									 <input type="submit" class="btn" id="authBtn" value="인증" data-toggle="modal" data-target="#modal"/>
									 <input type="submit" class="btncheck"  value="인증확인"/>
									 <input type="submit" class="userCheck"  value="아이디중복검증"/>
									 
									 <!-- 문제사항을 작성하는 란 -->
									 <div class="form-group problem">
										
									 </div>
								</div>
								
							<div class="col-md-1">
								<div class="form-group"><input class="tmp form-control"/></div>
								<div class="form-group">
									<!-- Modal (Button trigger) -->
									
									</div>
								</div>
							</div>
					</div>
				</div>
			</div>
			
			<!-- 1. 이메일 입력 안했을 때 뜨는 Modal -->
			<div class="modal fade" id="error" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<h5 class="modal-title" id="modalTitle">알림</h5>
						<div class="modal-body">올바른 이메일을 입력해주세요.</div>
						<button type="button" class="btn btn-danger btn-block" data-dismiss="modal" id="closeBtn">확인</button>
					</div>
				</div>
			</div>
			
			<!-- 2. 인증번호 전송 됐을 때 뜨는 Modal -->
			<div class="modal fade" id="codeSent" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<h5 class="modal-title" id="modalTitle">알림</h5>
						<div class="modal-body">인증번호가 전송되었습니다.</div>
						<button type="button" class="btn btn-primary btn-block" data-dismiss="modal" id="closeBtn">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>