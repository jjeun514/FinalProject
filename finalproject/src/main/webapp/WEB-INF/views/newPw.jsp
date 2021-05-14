<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/navbar.jspf" %>
<script type="text/javascript">
	//비밀번호 변경 버튼 클릭 시 고의적인 값 변경을 막기 위한 값 체크
	var newPw="none"; //새 비밀번호 값 저장
	var newPwConfirm="none"; //새 비밀번호 확인 값 저장
	
	//비밀번호 검증 기능
	var booNewPw=false;
	var booPattern=false;
	
	//패스워드 16자 제한 기능
	function pwLength(pw){
		$(pw).keyup(function(){
			if($(pw).val().length>16){
				$(pw).val($(pw).val().substring(0,16));
		}});
	}
	
	var pattern_num = /[0-9]/;	// 숫자 

	var pattern_eng = /[a-zA-Z]/;	// 문자 

	var pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
	
	$(function(){
		//비밀번호를 변경할 아이디 저장
		var hiddenInputId=$(".hiddenInputId").text();
		console.log(hiddenInputId);
		//아이디 저장 후 값을 불러오는 용도였던 div삭제
		$(".hiddenInputId").remove();
		
		//비밀번호 16자 제한 기능 활성화
		pwLength("#newPw");
		pwLength("#newPwConfirm");
		
		
		//포커스아웃 시 새 비밀번호 비교 검증 
		$("#newPw").focusout(function(){
			//1. 공백, 숫자, 영어, 특수문자 포함 여부
			if($('#newPw').val()==""){
				booPattern=false;
			}else if(!(pattern_spc.test($('#newPw').val())) ||
					!(pattern_num.test($('#newPw').val())) ||
					!(pattern_eng.test($('#newPw').val())) ){
				document.getElementById('modalText01').textContent ='숫자,영어,특수문자를 포함하여 비밀번호를 입력해주세요.';
				$('#dangerModal').modal('show');
				booPattern=false;
			}else{
				booPattern=true;
			}
			
			//2. 새 비밀번호를 변경할때마다 새 비밀번호 확인 인풋과 값이 다른지 확인 후 다르면 새 비밀번호 일치 기능 비활성화 
			if($("#newPw").val()!=$("#newPwConfirm").val()){
				booNewPw=false;
			}else if(newPwConfirm==""){
				booNewPw=false;
			}	
			
		});
		
		//새 비밀번호 확인 검증
		$("#newPwConfirm").focusout(function(){
			newPw=$("#newPw").val();
			newPwConfirm=$("#newPwConfirm").val();
			//1. 공란일 경우 기능 비활성화 
			if(newPwConfirm==""){
				booNewPw=false;
			//2. 새 비밀번호와 확인 값이 다른 경우 기능 비활성화
			}else if(newPw!=newPwConfirm){
				booNewPw=false;
			//3. 확인 값에 숫자, 문자, 특수문자 세 가지가 모두 들어가 있는지 검증
			}else if(!(pattern_spc.test(newPwConfirm)) ||
					!(pattern_num.test(newPwConfirm)) ||
					!(pattern_eng.test(newPwConfirm)) ){
				booNewPw=false;
			//4. 위 조건을 모두 충족할 경우 기능 활성화
			}else{
				booNewPw=true;
			}
		});
		
		
		//비밀번호 변경버튼 기능
		$("#newPwBtn").click(function(){
			//1.새 비밀번호 기능 활성화 여부 확인
			if(booPattern==false || booNewPw==false){
				document.getElementById('modalText01').textContent ='변경할 비밀번호 확인하세요.';
				$('#dangerModal').modal('show');
				return false;
			//2.비밀번호 강제 값 변경 여부 확인
			}else if(newPw!=$('#newPw').val() ||
					newPwConfirm!=$('#newPwConfirm').val()
					){
				document.getElementById('modalText01').textContent ='비밀번호 강제 변경은 금지입니다.';
				$('#dangerModal').modal('show');
				return false;
			//3. 위 조건을 모두 충족할 경우 비밀번호 변경
			}else{
				$.ajax({
					url: "/forgotUpdatePw",
					type : "PUT",
					data : {hiddenInputId,newPwConfirm},
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					dataType: "text",
					success: function(data){
								if(data=="success"){
									document.getElementById('modalText02').textContent ='비밀번호가 변경되었습니다.';
									$('#primaryModal').modal('show').click(function(){
										location.href="index";
									});
									
								}else{
									document.getElementById('modalText01').textContent ='변경 오류.';
									$('#dangerModal').modal('show');
								}
							},
					error:function(request,status,error){
						 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						 console.log(error);
						 }
				});
				
				return false;
			}
				
			
		});
		
		//비밀번호 변경 검증 기능 end	
		
	});
	
</script>
<div class="content main">
<div class="content" id="forgotIdPw">
	<!-- 비밀번호 변경 -->
	<h5 id="forgotPwTitle">비밀번호 변경</h5>
	<div class="input-group">
	  <span class="input-group-text" id="newPwName">새 비밀번호</span>
	  <input type="password" class="form-control" id="newPw">
	</div>
	<div class="input-group">
	  <span class="input-group-text" id="newPwConfirmName">비밀번호 확인</span>
	  <input type="password" class="form-control" id="newPwConfirm">
	</div>
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
	  <button class="btn btn-dark me-md-2" type="button" id="newPwBtn">비밀번호변경</button>
	</div>
	<div class="hiddenInputId"><%= request.getParameter("hiddenInputId") %></div>
	
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