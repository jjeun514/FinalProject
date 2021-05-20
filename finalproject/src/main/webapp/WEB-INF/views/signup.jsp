<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>회원가입</title>
<%@ include file="template/navbar.jspf" %>

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
	var code='';
	var codeVerification=false;
	var email=$('#emailInput').val().replace(/\s/gi, '');
	/*	이메일 입력하지 않고 인증버튼 누르면 알림 modal 띄우기
		이 프로젝트에서는 gmail 인증만 진행하도록 함
		따라서, gamil이 아닌 경우에도 알림띄움 */
	if (email==""||!(email.endsWith("@gmail.com"))) {
		document.getElementById('modalText01').textContent='올바른 이메일을 입력해주세요.';
		$('#dangerModal').modal('show');
		return false;
	} else {
		$('#emailInput').attr('disabled', true);
		$('#authBtn').attr('disabled', true);
		$('#msg').show();
		document.getElementById('modalText01').textContent='잠시만 기다려주세요.';
		$('#dangerModal').modal('show');
		
		// 비동기 통신(POST: 데이터를 body에 담아서 보냄)
		$.ajax({
			url: "/signup",
			type: "POST",
			data: {
				// 이메일 입력 값 (전체 공백 제거)
				email:$("#emailInput").val().replace(/\s/gi,"")
			},
			success: function(data){
				$('#msg').hide();
				$('#codeInput').attr("disabled", false);
				$('#codeInput').show();
				document.getElementById('modalText02').textContent='인증번호가 전송되었습니다.';
				$('#primaryModal').modal('show');
				document.getElementById('codeInput').disabled=false;
				
				$('#authBtn').hide();
				$(".btncheck").show();
				
				//요청 후 회원가입 시 값 체크를 위해 아이디 값 저장.
			 	var user=$(".username").val();
				
				//인증버튼 활성화
			 	$(".btncheck").prop("disabled", false);
				
				$(".btncheck").on("click", function(){
					codeVerification=false;
					// 인증번호
					code=data;
					var codeInput=$('#codeInput').val();
					if(codeInput!=""||code!=""){
						if(codeInput==code){
							
							document.getElementById('modalText02').textContent='감사합니다. 인증에 성공하였습니다.';
							$('#primaryModal').modal('show');
							
							$("#codeInput").prop("readonly","readonly");
							
							//인증 성공 후 회원가입버튼 인증 요청 알림 기능 삭제
							$(".btnRegister").off('click');
							
							//회원가입 버튼 활성화
							$(".joinForm").append($(".btnRegister"));
							
							//닉네임 중복 검사 버튼 활성화
							$(".nickNameCheck").prop("disabled", false);
							$(".nickNameCheck").show();
							
							//인증 확인 버튼 비활성화
							$(".btncheck").prop("disabled", true);
							
							//비동기 통신 (닉네임 중복검사)
							var check=0;
							$(".nickNameCheck").click(function(){
								var memNickName = $('.memNickName').val();
								if(memNickName.length>10 || memNickName.length<2 || pattern_spc.test(memNickName)){
									document.getElementById('modalText01').textContent='공백 및 2자 이상 10자리 이하, 특수문자 사용 여부를 확인해주세요.';
									$('#dangerModal').modal('show');
								}else{
									$.ajax({
										url: "/nickNameCheck",
										type : "POST",
										data: {memNickName},
										contentType : "application/x-www-form-urlencoded; charset=UTF-8",
										dataType: "text",
										success: function(data){
													if(data=="Available"){
														document.getElementById('modalText02').textContent='사용가능한 닉네임입니다.';
														$('#primaryModal').modal('show');
														//닉네임을 바꾸지 못하게 readonly
														$(".memNickName").prop("readonly","readonly");
														check=1;
													}else{
														document.getElementById('modalText01').textContent='사용중인 닉네임입니다.';
														$('#dangerModal').modal('show');
													}
												 },
										error: function(){
											$('#error').modal('show');
											$('#emailInput').attr('disabled', false);
											$('#authBtn').attr('disabled', false);
										}
										
									});
								}
							});
							
							//회원가입 버튼 클릭 시 값 체크 후 회원가입 완료
							$(".btnRegister").click(function(){
								//닉네임 중복 검사 유무 및 중복 여부 확인
								if(check!=1){
									document.getElementById('modalText01').textContent='닉네임 중복 검사를 완료하시기 바랍니다.';
									$('#dangerModal').modal('show');
									return false;
								//이메일 인증 시 아이디 값과 현재 값이 다른지 체크 
								}else if(!(user==$(".username").val())){
									document.getElementById('modalText01').textContent='강제 변경된 아이디는 허용하지 않습니다.';
									$('#dangerModal').modal('show');
									return false;
								//패스워드 값 체크
									//1. 8~16자리 이내
								}else if($('.password1').val().length>16 || $('.password1').val().length<8){
									document.getElementById('modalText01').textContent='비밀번호는 8~16자리까지 입력해야합니다.';
									$('#dangerModal').modal('show');
									return false;
									
									//2. 숫자,영어,특수문자 모두 포함
								}else if(!(pattern_spc.test($('.password1').val())) ||
										!(pattern_num.test($('.password1').val())) ||
										!(pattern_eng.test($('.password1').val())) ){
									document.getElementById('modalText01').textContent='숫자,영어,특수문자를 포함하여 비밀번호를 입력해주세요.';
									$('#dangerModal').modal('show');
									return false;
									//3. 비밀번호 확인 번호와 일치 여부 체크
								}else if(!($('.password1').val()==$('.password2').val())){
									document.getElementById('modalText01').textContent='비밀번호와 확인번호가 서로 일치하지 않습니다.';
									$('#dangerModal').modal('show');
									return false;
									
								//이름 체크
									//1. 2자이상 10자 이하	
								}else if($('.memName').val().length>10 || $('.memName').val().length<2){
									document.getElementById('modalText01').textContent='이름은 2자 이상 10자리 이내로 입력해주세요.';
									$('#dangerModal').modal('show');
									return false;
									//2. $('.memName').val('이름')을 통한 특수문자, 숫자 입력 방어
								}else if(pattern_spc.test($('.memName').val()) || 
										 pattern_num.test($('.memName').val())){
									document.getElementById('modalText01').textContent='강제 입력한 이름은 허용하지 않습니다.';
									$('#dangerModal').modal('show');
									$('.memName').val("");
									return false;
								
								//닉네임 체크
									//1. 2자이상 10자 이하	
								}else if($('.memNickName').val().length>10 || $('.memNickName').val().length<2){
									document.getElementById('modalText01').textContent='닉네임은 2자 이상 10자리 이내로 입력해주세요.';
									$('#dangerModal').modal('show');
									return false;
									//2. $('.memNickName').val('닉네임')을 통한 특수문자 입력 방어
								}else if(pattern_spc.test($('.memNickName').val())){
									document.getElementById('modalText01').textContent='강제 입력은 허용하지 않습니다.';
									$('#dangerModal').modal('show');
									$('.memNickName').val("");
									return false;
								
								//부서 체크
									//1. 2자이상 20자 이하	
								}else if($('.dept').val().length>20 || $('.dept').val().length<2){
									document.getElementById('modalText01').textContent='부서는 2자 이상 20자리 이내로 입력해주세요.';
									$('#dangerModal').modal('show');
									$('.dept').focus();
									return false;
									//2. $('.dept').val('부서')을 통한 특수문자 입력 방어
								}else if(pattern_spc.test($('.dept').val())){
									document.getElementById('modalText01').textContent='강제 입력은 허용하지 않습니다.';
									$('#dangerModal').modal('show');
									$('.dept').val("");
									return false;
								
								//번호 체크
									//1. 9자이상 15자 이하	
								}else if($('.memPhone').val().length>15 || $('.memPhone').val().length<9){
									document.getElementById('modalText01').textContent='번호는 9자 이상 15자리 이내로 입력해주세요.';
									$('#dangerModal').modal('show');
									$('.memPhone').focus();
									return false;
									//2. $('.memPhone').val('번호')을 통한 문자,특수문자 입력 방어
								}else if(!(pattern_num.test($('.memPhone').val()))){
									document.getElementById('modalText01').textContent='강제 입력은 허용하지 않습니다.';
									$('#dangerModal').modal('show');
									$('.memPhone').val("");
									return false;
									
								}else{
									//값을 모두 체크 후 회원가입 신청 완료
									return true
								}
								
							});
							
							
						} else{
							document.getElementById('modalText01').textContent='인증번호가 일치하지 않습니다.';
							$('#dangerModal').modal('show');
							$(".btnRegister").click(function(){
								return false;
							});
						}
					}

				});
			},
			error: function(){
				$('#error').modal('show');
				$('#emailInput').attr('disabled', false);
				$('#authBtn').attr('disabled', false);
			}
		});
	}
});

$(function(){
	$('#msg').hide();
	$('#codeInput').hide();
	$('#authBtn').hide();
	$('#checkCertification').hide();
	$('#signUpNickNameCheck').hide();
	
	//아이디(이메일) 중복 검사 하기 전 이메일 인증번호 전송버튼 및 인증확인 버튼 닉네임 중복검사 버튼 비활성화
	$("#authBtn").prop('disabled',"true");
	$(".nickNameCheck").prop('disabled',"true");
	$(".btncheck").prop('disabled',"true");
	
	
	//비동기 통신 (아이디 중복검사)
	$(".userCheck").click(function(){
		var username = $(".username").val().replace(/\s/gi,"");
		if(username==""||!(username.endsWith("@gmail.com"))){
			document.getElementById('modalText01').textContent='공백 및 지메일 아이디를 확인해주세요';
			$('#dangerModal').modal('show');
		}else{
			$.ajax({
				url: "/usercheck",
				type : "POST",
				data: {username},
				contentType : "application/json; charset=utf-8",
				success: function(data){
							if(data=="Available"){
								document.getElementById('modalText02').textContent='사용가능한 아이디입니다.';
								$('#username').val(username);
								$('#primaryModal').modal('show');
								//인증버튼 활성화
								$("#authBtn").prop("disabled", false);
								//인증요청을 하였을 때 아이디를 바꾸지 못하게 readonly
								$(".username").prop("readonly","readonly");
								$(".userCheck").hide();
								$('#authBtn').show();
							}else{
								document.getElementById('modalText01').textContent='사용중인 아이디입니다.';
								$('#dangerModal').modal('show');
							}
						 },
				error: function(error){
					$('#error').modal('show');
					$('#emailInput').attr('disabled', false);
					$('#authBtn').attr('disabled', false);
				}
				
			});
		}
	});
	
	
	$(".btnRegister").on("click", function(){
		document.getElementById('modalText01').textContent='인증 먼저 부탁드립니다.';
		$('#dangerModal').modal('show');
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
		
		if(pattern_spc.test($(data).prop('key')) || pattern_num.test($(data).prop('key')) || window.event.keyCode==32){
			if($(data).prop('key')!='Backspace'){
				document.getElementById('modalText01').textContent='이름에 숫자 및 특수문자는 사용할 수 없습니다.';
				$('#dangerModal').modal('show');
				$('.memName').val("").focus();
			}
		}
	});
	
	//닉네임 10자 제한 및 특수문자 사용 제한
	$('.memNickName').keyup(function(data){
		if($('.memNickName').val().length>10){
			$('.memNickName').val($('.memNickName').val().substring(0,10));
		}
		
		if(pattern_spc.test($(data).prop('key')) || window.event.keyCode==32){
			if($(data).prop('key')!='Backspace'){
				document.getElementById('modalText01').textContent='닉네임에 특수문자는 사용할 수 없습니다.';
				$('#dangerModal').modal('show');
				$('.memNickName').val("").focus();
			}
		}
	});
	
	//부서 20자 제한 및 특수문자 사용 제한
	$(".dept").keyup(function(data){
		if($('.dept').val().length>20){
			$('.dept').val($('.dept').val().substring(0,20));
		}
		
		if(pattern_spc.test($(data).prop('key')) || window.event.keyCode==32){
			if($(data).prop('key')!='Backspace'){
				document.getElementById('modalText01').textContent='부서에 특수문자는 사용할 수 없습니다.';
				$('#dangerModal').modal('show');
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
				document.getElementById('modalText01').textContent='숫자만 입력 가능합니다.';
				$('#dangerModal').modal('show');
				$('.memPhone').val("").focus();
			}
		}
	});
	
});

</script>

<div class="content main">
	<div class="container register">
		<div class="row left-side">
			<div class="col-md-3 register-left">
				<img src="https://image.ibb.co/n7oTvU/logo_white.png" alt=""/>
				<h3>9 O' Clock</h3>
				<p>입주를 환영합니다.</p>
			</div>
			
			<div class="col-md-9 register-right">
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
						<h3 class="register-heading">회원 가입</h3>
							<div class="row register-form">
								<div class="col-md-11">
									<form action="/joinMember" method="post" class="joinForm">  
									<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
									<input type="hidden" name="username" id="username" />
									<div class="form-group">
										<input type="text" class="form-control memName"  placeholder="이름 *" value="" name="memName" />
									</div>
									<%/*emailInput에 이메일을 입력하고, 이메일 인증 버튼을 누르면,
										 input값을 넘겨서 이메일 전송 시 to로 받아서 그 이메일로 인증번호 발송*/%>
									 
									<div class="form-group">
										<input type="email" class="form-control username" placeholder="아이디(gmail) *" value="" id="emailInput" name="username"/>
										<input type="submit" class="btn" id="authBtn" value="인증" data-toggle="modal" data-target="#modal"/>
									</div>
									<div>
										<span id="msg">처리중입니다. 잠시만 기다려주세요.</span>
									</div>
                                    <div class="form-group">
										<input type="text" class="form-control" id="codeInput" placeholder="인증번호(6자리) *" value="" />
									</div>
									<div class="form-group">
										<input type="password" class="form-control password1" placeholder="비밀번호 *" value="" name="password" />
									</div>
									<div class="form-group" id="emailPart">
										<input type="password" class="form-control password2"  placeholder="비밀번호 확인 *" value="" />
									</div>
									<div class="form-group">
										<input type="text" class="form-control memNickName"  placeholder="닉네임 *" value="" name="memNickName"/>
									</div>
									<div class="form-group">
									<label id="selectComName">본인의 소속회사를 선택하시기 바랍니다.</label>
									<select name="comCode" class="form-control">      
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
									</form> 
									 <input type="submit" class="btnRegister"  value="회원가입"/>
									 
									 <input type="submit" class="btn userCheck" id="checkId" data-toggle="modal" data-target="#modal" value="중복검사"/>
									 <input type="submit" class="btn btncheck" id="checkCertification" data-toggle="modal" data-target="#modal" value="인증확인"/>
									 <input type="submit" class="btn nickNameCheck" id="signUpNickNameCheck" data-toggle="modal" data-target="#modal" value="닉네임중복검증"/>
									 
								</div>
							</div>
					</div>
				</div>
						<%//1. danger Modal%>
			<div class="modal fade" id="dangerModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<h5 class="modal-title" id="modalTitle">알림</h5>
						<div class="modal-body" id="modalText01"></div>
						<button type="button" class="btn btn-danger btn-block" data-dismiss="modal" id="closeBtn">확인</button>
					</div>
				</div>
			</div>
			
			<%//2. primary Modal%>
			<div class="modal fade" id="primaryModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<h5 class="modal-title" id="modalTitle">알림</h5>
						<div class="modal-body" id="modalText02"></div>
						<button type="button" class="btn btn-primary btn-block" data-dismiss="modal" id="closeBtn">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="template/footer.jspf" %>