<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>회원가입</title>
<%@ include file="template/navbar.jspf"%>
<script type="text/javascript">
<%//인증 버튼 제어%>
$(document).ready(function(){
	$('#msg').hide();
	$('#codeInput').hide();
	$(document).on('click','#authBtn',function() {
		console.log("인증 버튼 누름");
		var code='';
		var codeVerification=false;
		var email=$('#emailInput').val().replace(/\s/gi, '');
		<%  /*이메일 입력하지 않고 인증버튼 누르면 알림 modal 띄우기
			이 프로젝트에서는 gmail 인증만 진행하도록 함
			따라서 gamil이 아닌 경우에도 알림띄움 */ %>
		if (email==""||!(email.endsWith("@gmail.com"))) {
			console.log("공백/지메일 아님");
			document.getElementById('modalText01').innerHTML='올바른 이메일을 입력해주세요.';
			$('#dangerModal').modal('show');
			return false;
		} else {
			$('#emailInput').attr('disabled', true);
			$('#authBtn').attr('disabled', true);
			$('#msg').show();
			document.getElementById('modalText01').innerHTML='잠시만 기다려주세요.';
			$('#dangerModal').modal('show');
			console.log("이메일 넘겨서 인증번호 전송될 차례");
			<%/*ajax 403 error
				Spring Security 4.2.13으로 인해, 클라이언트에서 서버에 접근하면
				csrf 토큰 검사를 하게 되는데 ajax header에 csrf 토큰이 없으면
				403 에러 발생 */ %>
			var csrfToken = $("meta[name='_csrf']").attr("content");
			$.ajaxPrefilter(function(options, originalOptions, jqXHR){
				if (options['type'].toLowerCase() === "post") {
					jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
				}
			});
			
			<%// 비동기 통신(POST: 데이터를 body에 담아서 보냄)%>
			$.ajax({
				url: "/signup",
				type: "POST",
				data: {
					<%// 이메일 입력 값 (전체 공백 제거)%>
					email:$("#emailInput").val().replace(/\s/gi,"")
				},
				success: function(data){
					console.log("ajax 성공");
					console.log("인증번호 전송 완료");
					console.log("email: "+email);
					$('#msg').hide();
					$('#codeInput').attr("disabled", false);
					$('#codeInput').show();
					document.getElementById('modalText02').innerHTML='인증번호가 전송되었습니다.';
					$('#primaryModal').modal('show');
					<%/*1. 생각해 볼 부분
							emailInput을 전달해서, 이메일을 발송하는 로직이 수행되는 시간이
							생각보다 길어서 사용자 입장에서 인증 버튼을 누르고 기다려야함
					
						2. 나중에 추가 구현할 부분
							인증 버튼을 disabled 시키고, 5분 타이머 작동
							5분 후에 다시 인증 버튼 보낼 수 있음
							타이머가 끝나면 인증 번호도 invalid 상태로 바꿔야함	*/%>
					document.getElementById('codeInput').disabled=false;
					<%/*인증번호 일치 여부
						1. 일치 여부를 input박스 하단에 표기 등
						2. 회원가입 버튼을 눌렀을 때 검증*/%>
					$(".btnRegister").on("click", function(){
						codeVerification=false;
						<%// 인증번호%>
						code=data;
						var codeInput=$('#codeInput').val();
						if(codeInput!=""||code!=""){
							if(codeInput==code){
								console.log('인증코드 일치');
								document.getElementById('modalText02').innerHTML='감사합니다. 관리자 승인 후 이용하실 수 있습니다.';
								$('#primaryModal').modal('show').click(function(){
									location.href='index';
								});
							} else{
								console.log('인증코드 불일치');
								document.getElementById('modalText01').innerHTML='인증번호가 일치하지 않습니다.';
								$('#dangerModal').modal('show');
							}
						}
					});
				},
				error: function(){
					console.log("ajax 에러");
					$('#error').modal('show');
					$('#emailInput').attr('disabled', false);
					$('#authBtn').attr('disabled', false);
				}
			});
		}
	});
});
</script>

<div class="content main">
	<div class="container register">
		<div class="row left-side">
			<div class="col-md-3 register-left">
				<img src="https://image.ibb.co/n7oTvU/logo_white.png" alt=""/>
				<h3>9'o Clock</h3>
				<p>입주를 환영합니다.</p>
			</div>
			
			<div class="col-md-9 register-right">
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
						<h3 class="register-heading">회원 가입</h3>
							<div class="row register-form">
								<div class="col-md-11">
									<div class="form-group">
										<input type="text" class="form-control" placeholder="이름 *" value="" />
									</div>
									
									<%/*emailInput에 이메일을 입력하고, 이메일 인증 버튼을 누르면,
										 input값을 넘겨서 이메일 전송 시 to로 받아서 그 이메일로 인증번호 발송*/%>
										<div class="form-group">
										<!-- name=서버로 전달되는 이름 -->
											<input type="email" class="form-control" placeholder="아이디(gmail) *" value="" id="emailInput" name="email"/>
											<input type="submit" class="btn" id="authBtn" value="인증" data-toggle="modal" data-target="#modal"/>
										</div>
										<div>
											<span id="msg">처리중입니다. 잠시만 기다려주세요.</span>
										</div>
                                    <div class="form-group">
										<input type="text" class="form-control" id="codeInput" placeholder="인증번호(6자리) *" value="" disabled/>
									</div>
									<div class="form-group">
										<input type="password" class="form-control" placeholder="비밀번호 *" value="" />
									</div>
									<div class="form-group" id="emailPart">
										<input type="password" class="form-control"  placeholder="비밀번호 확인 *" value="" />
									</div>
									 <input type="submit" class="btnRegister"  value="회원가입"/>
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
</div>
<%@ include file="template/footer.jspf" %>