<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/navbar.jspf" %>
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
		document.getElementById('modalText01').innerHTML='입력값을 확인해주세요.';
		$('#dangerModal').modal('show');
		return false;
	} else {
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
				$.each(id, function(key, value){
					memberId=value;
				});
				if(memberId==null||memberId==""){
					document.getElementById('modalText02').innerHTML='아이디가 존재하지 않습니다.';
					$('#primaryModal').modal('show');
				} else{
					document.getElementById('modalText02').innerHTML='아이디: '+memberId;
					$('#primaryModal').modal('show');
				}
			},
			error: function(){
				memberId="";
				document.getElementById('modalText01').innerHTML='아이디가 존재하지 않습니다.';
				$('#dangerModal').modal('show');
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
		document.getElementById('modalText01').innerHTML='입력값을 확인해주세요.';
		$('#dangerModal').modal('show');
		return false;
	} else{
		document.getElementById('modalText01').innerHTML='잠시만 기다려주세요.';
		$('#dangerModal').modal('show');
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
				$('#primaryModal').modal('show');
					document.getElementById('modalText02').innerHTML='입력하신 이메일로 인증번호가 전송되었습니다.';
					$('#msg').hide();
					$('#forgotPwBtn').attr('id','verification');
					$('#codeDiv').show();
					//인증번호 일치 여부
					$("#verification").on("click", function(){
						codeVerification=false;
						$.each(codeSent, function(key, value){
							// 인증번호
							code=value;
						});
						var codeInput=$('#codeInput').val();
						if(codeInput!=""||code!=""){
							if(codeInput==code){
								$('#pwNameInput').attr("disabled",true);
								$('#pwIdInput').attr("disabled",true);
								$('#pwPhoneInput').attr("disabled",true);
								$('#codeInput').attr("disabled",true);
								$('#verification').attr("disabled",true);
								document.getElementById('modalText02').innerHTML='비밀번호 변경 페이지로 이동합니다.';
								$('#primaryModal').modal('show').click(function(){
									$(".hiddenInputId").val(pwId);
									$(".newPw").submit();
								});
							} else{
								document.getElementById('modalText01').innerHTML='인증코드가 일치하지 않습니다.';
								$('#dangerModal').modal('show');
							}
						}
					});
			},
			error: function(){
				$('#msg').hide();
				$('#forgotPwBtn').attr("disabled",false);
				$('#pwNameInput').attr("disabled",false);
				$('#pwIdInput').attr("disabled",false);
				$('#pwPhoneInput').attr("disabled",false);
				$('#codeInput').attr("disabled",true);
				memberpw="";
				document.getElementById('modalText01').innerHTML='입력하신 정보가 일치하지 않습니다.';
				$('#dangerModal').modal('show');
			}
		})
		
	}
});
});
</script>
<div class="content main">
<div class="content" id="forgotIdPw">
	<!-- 아이디 찾기 -->
	<h5 id="forgotIDTitle">아이디 찾기</h5>
	<div class="input-group">
	  <span class="input-group-text" id="idName">이름</span>
	  <input type="text" class="form-control" id="idNameInput">
	</div>
	<div class="input-group">
	  <span class="input-group-text" id="idPhone">전화번호</span>
	  <input type="tel" class="form-control" id="idPhoneInput">
	</div>
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
	  <button class="btn btn-dark me-md-2" type="submit" id="forgotIdBtn">아이디찾기</button>
	</div>
	
	<div>　</div>
	
	<!-- 비밀번호 찾기 -->
	<h5 id="forgotPwTitle">비밀번호 찾기</h5>
	<div class="input-group">
	  <span class="input-group-text" id="pwName">이름</span>
	  <input type="text" class="form-control" id="pwNameInput">
	</div>
	<div class="input-group">
	  <span class="input-group-text" id="pwId">아이디</span>
	  <input type="email" class="form-control" id="pwIdInput">
	</div>
	<div class="input-group">
	  <span class="input-group-text" id="pwPhone">전화번호</span>
	  <input type="tel" class="form-control" id="pwPhoneInput">
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
	<form action="newPw" method="post" class="newPw">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> 
		<input type="hidden" name="hiddenInputId" class="hiddenInputId"/>
	</form>
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
<%@ include file="template/footer.jspf" %>