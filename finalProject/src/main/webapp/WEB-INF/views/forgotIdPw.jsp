<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./template/header.jspf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="/webjars/bootstrap/4.6.0-1/css/bootstrap.min.css" rel="stylesheet">
<script src="/webjars/bootstrap/4.6.0-1/js/bootstrap.min.js"></script>
<style type="text/css">
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
#authBtn,#authBtn:link,#authBtn:visited,#authBtn:hover,#authBtn:active{
	background-color: darkblue;
	color: white;
	border: #dee2ee 1px solid;
	text-align: center;
	width: 20%;
}
#msg{
	color: red;
	font-size: 100%;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
var csrfToken = $("meta[name='_csrf']").attr("content");
$.ajaxPrefilter(function(options, originalOptions, jqXHR){
	if (options['type'].toLowerCase() === "post") {
		jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	}
});
$('input').val('');
history.pushState(null, null, location.href);
window.onpopstate = function () {
    history.go(1);
};
$('#codeDiv').hide();
$('#msg').hide();
// 아이디 찾기
$(document).on('click','#forgotIdBtn',function() {
	var idName=$("#idNameInput").val().replace(/\s/gi,"");
	var idPhone=$("#idPhoneInput").val().replace(/\s/gi,"");
	var memberId="";
	if (idName==""||idPhone=="") {
		console.log("이름/pw 공백");
		document.getElementById('modalText').innerHTML='입력값을 확인해주세요.';
		$('#errorModal').modal('show');
		console.log("[id찾기 input] name: "+idName);
		console.log("[id찾기 input] phone: "+idPhone);
		return false;
	} else {
		console.log("이름/비밀번호 입력됨");
		console.log("[id찾기 input] "+idName);
		console.log("[id찾기 input] "+idPhone);
		
		$.ajax({
			url: "/forgotId",
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "JSON",
			data: {
				name:idName,
				phone:idPhone
			},
			success: function(id){
				$('#idModal').modal('show');
				console.log('[ajax성공] name: '+idName);
				console.log('[ajax성공] phone: '+idPhone);
				$.each(id, function(key, value){
					memberId=value;
				});
				console.log('[ajax성공] memberId: '+memberId);
				if(memberId==null||memberId==""){
					console.log('정보일치, but 아이디 없음');
					document.getElementById('yourId').innerHTML='아이디가 존재하지 않습니다.';
				} else{
					document.getElementById('yourId').innerHTML='아이디: '+memberId;
				}
			},
			error: function(request, status, error){
				memberId="";
				console.log("ajax 에러");
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				$('#idModal').modal('show');
				document.getElementById('yourId').innerHTML='아이디가 존재하지 않습니다.';
			}
		})
	}
});
// 비밀번호 찾기
$(document).on('click','#forgotPwBtn',function() {
	var pwName=$("#pwNameInput").val().replace(/\s/gi,"");
	var pwId=$("#pwIdInput").val().replace(/\s/gi,"");
	var pwPhone=$("#pwPhoneInput").val().replace(/\s/gi,"");
	var memberInfo;
	var code='';
	var codeVerification=false;
	if (pwName==""||pwId==""||!(pwId.endsWith("@gmail.com"))||pwPhone=="") {
		console.log("이름/id/pw/인증번호 공백");
		document.getElementById('modalText').innerHTML='입력값을 확인해주세요.';
		$('#errorModal').modal('show');
		console.log("[pw찾기 input] name: "+pwName);
		console.log("[pw찾기 input] id: "+pwId);
		console.log("[pw찾기 input] phone: "+pwPhone);
		return false;
	} else{
		console.log("이름/아이디/비밀번호 입력됨");
		console.log("[pw찾기 input] name: "+pwName);
		console.log("[pw찾기 input] id: "+pwId);
		console.log("[pw찾기 input] phone: "+pwPhone);
		document.getElementById('modalText').innerHTML='잠시만 기다려주세요.';
		$('#errorModal').modal('show');
		$('#msg').show();
		$('#pwNameInput').attr("disabled",true);
		$('#pwIdInput').attr("disabled",true);
		$('#pwPhoneInput').attr("disabled",true);
		$('#codeInput').attr("disabled",true);
		$('#forgotPwBtn').attr("disabled",true);
		$.ajax({
			url: "/forgotPw",
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "JSON",
			data: {
				name:pwName,
				id:pwId,
				phone:pwPhone
			},
			success: function(codeSent){
				$('#codeInput').attr("disabled",false);
				$('#forgotPwBtn').attr("disabled",false);
				$('#pwModal').modal('show');
				console.log('[ajax성공] name: '+pwName);
				console.log('[ajax성공] id: '+pwId);
				console.log('[ajax성공] phone: '+pwPhone);
					document.getElementById('pwAuth').innerHTML='입력하신 이메일로 인증번호가 전송되었습니다.';
					$('#msg').hide();
					$('#forgotPwBtn').attr('id','verification');
					$('#codeDiv').show();
					//인증번호 일치 여부
					$("#verification").on("click", function(){
						codeVerification=false;
						$.each(codeSent, function(key, value){
							console.log('[json parsed] key: '+key+', value: '+value);
							// 인증번호
							code=value;
						});
						var codeInput=$('#codeInput').val();
						if(codeInput!=""||code!=""){
							if(codeInput==code){
								console.log('인증코드 일치');
								$('#pwNameInput').attr("disabled",true);
								$('#pwIdInput').attr("disabled",true);
								$('#pwPhoneInput').attr("disabled",true);
								$('#codeInput').attr("disabled",true);
								$('#verification').attr("disabled",true);
								location.href='signup';
							} else{
								console.log('인증코드 불일치');
								document.getElementById('modalText').innerHTML='인증코드가 일치하지 않습니다.';
								$('#errorModal').modal('show');
							}
						}
					});
			},
			error: function(request, status, error){
				$('#msg').hide();
				$('#pwNameInput').attr("disabled",false);
				$('#pwIdInput').attr("disabled",false);
				$('#pwPhoneInput').attr("disabled",false);
				$('#codeInput').attr("disabled",true);
				memberpw="";
				console.log("ajax 에러");
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				document.getElementById('modalText').innerHTML='입력하신 정보가 일치하지 않습니다.';
				$('#errorModal').modal('show');
			}
		})
		
	}
});
});
</script>
<body>
<!-- content -->
<div class="content" id="forgotIdPw">
	<!-- 아이디 찾기 -->
	<h5>아이디 찾기</h5>
	<div class="input-group">
	  <span class="input-group-text" id="idName">이름</span>
	  <input type="text" class="form-control" id="idNameInput">
	</div>
	<div class="input-group">
	  <span class="input-group-text" id="idPhone">전화번호</span>
	  <input type="password" class="form-control" id="idPhoneInput">
	</div>
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
	  <button class="btn btn-dark me-md-2" type="submit" id="forgotIdBtn">아이디찾기</button>
	</div>
	
	<div>　</div>
	
	<!-- 비밀번호 찾기 -->
	<h5>비밀번호 찾기</h5>
	<div class="input-group">
	  <span class="input-group-text" id="pwName">이름</span>
	  <input type="text" class="form-control" id="pwNameInput">
	</div>
	<div class="input-group">
	  <span class="input-group-text" id="pwId">아이디</span>
	  <input type="text" class="form-control" id="pwIdInput">
	  <!-- <input type="submit" class="btn" id="authBtn" value="인증" data-toggle="modal" data-target="#modal"/> -->
	</div>
	<div class="input-group">
	  <span class="input-group-text" id="pwPhone">전화번호</span>
	  <input type="text" class="form-control" id="pwPhoneInput">
	</div>
	<div class="input-group" id="codeDiv">
	  <span class="input-group-text" id="code">인증번호</span>
	  <input type="text" class="form-control" id="codeInput" placeholder="인증번호(6자리) *"/>
	</div>
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
	  <button class="btn btn-dark me-md-2" type="button" id="forgotPwBtn">비밀번호찾기</button>
	</div>
	<div>
	  <span id="msg">처리중입니다. 잠시만 기다려주세요.</span>
	</div>
	
			<!-- 1. 아이디 찾기 했을 때 뜨는 Modal -->
			<div class="modal fade" id="idModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<h5 class="modal-title" id="modalTitle">아이디 찾기</h5>
							<div class="modal-body" id="yourId"></div>
						<button type="button" class="btn btn-primary btn-block" data-dismiss="modal" id="closeBtn">확인</button>
					</div>
				</div>
			</div>
			
			<!-- 2. 비밀번호 찾기 했을 때 뜨는 Modal -->
			<div class="modal fade" id="pwModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<h5 class="modal-title" id="modalTitle">비밀번호 찾기</h5>
						<div class="modal-body" id="pwAuth"></div>
						<button type="button" class="btn btn-primary btn-block" data-dismiss="modal" id="closeBtn">확인</button>
					</div>
				</div>
			</div>
			
			<!-- 3. 에러 Modal -->
			<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<h5 class="modal-title" id="modalTitle">알림</h5>
						<div class="modal-body" id="modalText"></div>
						<button type="button" class="btn btn-danger btn-block" data-dismiss="modal" id="closeBtn">확인</button>
					</div>
				</div>
			</div>
</div>
</body>
<%@ include file="./template/footer.jspf" %>
</html>