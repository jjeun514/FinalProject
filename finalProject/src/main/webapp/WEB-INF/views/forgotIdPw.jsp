<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./template/header.jspf" %>
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
</style>
<script>
$(document).on('click','#forgotIdBtn',function() {
	var idName=$("#idNameInput").val().replace(/\s/gi,"");
	var idPw=$("#idPwInput").val().replace(/\s/gi,"");
	if (idName==""||idPw=="") {
		console.log("이름/pw 공백");
		$('#errorModal').modal('show');
		console.log("id찾기 name: "+idName);
		console.log("pw찾기 pw: "+idPw);
		return false;
	} else {
		console.log("이름/비밀번호 입력됨");
		$.ajax({
			url: "forgotId",
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data: {
				name:idName,
				pw:idPw
			},
			success: function(result){
				$('#idModal').modal('show');
				console.log(idName);
				console.log(idPw);
			}
		})
	}
	/*
	$("#forgotPwBtn".click(function(){
		$.ajax({
			url: "forgotPw",
			type: "POST",
			data: {
				
			},
			success: function(result){
				$('#pwModal').modal('show');
			}
		})
	}))
	*/
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
	  <span class="input-group-text" id="idPw">비밀번호</span>
	  <input type="password" class="form-control" id="idPwInput">
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
	  <input type="password" class="form-control" id="pwIdInput">
	</div>
	<div class="input-group">
	  <span class="input-group-text" id="pwPhone">전화번호</span>
	  <input type="password" class="form-control" id="pwPhoneInput">
	</div>
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
	  <button class="btn btn-dark me-md-2" type="button" id="forgotPwBtn">비밀번호찾기</button>
	</div>
	
			<!-- 1. 아이디 찾기 했을 때 뜨는 Modal -->
			<div class="modal fade" id="idModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<h5 class="modal-title" id="modalTitle">아이디 찾기</h5>
						<div class="modal-body">아이디: </div>
						<button type="button" class="btn btn-danger btn-block" data-dismiss="modal" id="closeBtn">확인</button>
					</div>
				</div>
			</div>
			
			<!-- 2. 비밀번호 찾기 했을 때 뜨는 Modal -->
			<div class="modal fade" id="pwModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<h5 class="modal-title" id="modalTitle">비밀번호 찾기</h5>
						<div class="modal-body">입력하신 이메일로 임시비밀번호가 발급되었습니다.</div>
						<button type="button" class="btn btn-primary btn-block" data-dismiss="modal" id="closeBtn">확인</button>
					</div>
				</div>
			</div>
			
			<!-- 3. 공백으로 버튼 클릭 시 뜨는 Modal -->
			<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<h5 class="modal-title" id="modalTitle">알림</h5>
						<div class="modal-body">입력값을 확인해주세요.</div>
						<button type="button" class="btn btn-primary btn-block" data-dismiss="modal" id="closeBtn">확인</button>
					</div>
				</div>
			</div>
	
</div>
</body>
<%@ include file="./template/footer.jspf" %>
</html>