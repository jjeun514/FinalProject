<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
<script type="text/javascript">
// 인증 버튼 제어
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
		var csrfToken = $("meta[name='_csrf']").attr("content");
		$.ajaxPrefilter(function(options, originalOptions, jqXHR){
			if (options['type'].toLowerCase() === "post") {
				jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
			}
		});
		
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
				$(".btnRegister").on("click", function(){
					codeVerification=false;
					// 인증번호
					code=data;
					var codeInput=$('#codeInput').val();
					if(codeInput!=""||code!=""){
						if(codeInput==code){
							console.log('인증코드 일치');
						} else{
							console.log('인증코드 불일치');
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
				<input type="submit" name="" value="로그인"/><br/>
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
									
									<!-- emailInput에 이메일을 입력하고, 이메일 인증 버튼을 누르면,
										 input값을 넘겨서 이메일 전송 시 to로 받아서 그 이메일로 인증번호 발송 -->
										<div class="form-group">
										<!-- name=서버로 전달되는 이름 -->
											<input type="email" class="form-control" placeholder="아이디(gmail) *" value="" id="emailInput" name="email"/>
											<input type="submit" class="btn" id="authBtn" value="인증" data-toggle="modal" data-target="#modal"/>
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