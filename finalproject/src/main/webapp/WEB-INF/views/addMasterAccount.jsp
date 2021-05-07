<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>마스터계정추가</title>
<%@ include file="template/AdminNavbar.jspf" %>

<script type="text/javascript">
var pattern_num = /[0-9]/;	// 숫자 
var pattern_eng = /[a-zA-Z]/;	// 문자 
var pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글체크

//아이디 중복검사 여부
var check=-1;

//아이디 값 변경 여부
var username="";

$(function(){
	// 아이디 중복 검사
	$(".userCheck").click(function(){
		username=$(".username").val().replace(/\s/gi,"");
		console.log(username);
		if(username==""){
			document.getElementById('modalText01').innerHTML='아이디를 입력해주세요.';
			$('#dangerModal').modal('show');
		} else{
			$.ajax({
				url: "/usercheck",
				type : "POST",
				data: {username},
				contentType : "application/json; charset=utf-8",
				success: function(data){
					console.log("data: "+data);
					if(data=="Available"){
						document.getElementById('modalText02').innerHTML='사용가능한 아이디입니다.';
						$('#idInput').val(username);
						$('#primaryModal').modal('show');
						// 중복확인 후 아이디 변경 불가
						$(".username").attr("disabled", true);
						$("#checkBtn").attr("disabled", true);
						check=1;
					}else{
						document.getElementById('modalText01').innerHTML='사용중인 아이디입니다.';
						$('#dangerModal').modal('show');
						check=-1;
					}
				 },
				error: function(error){
					console.log("ajax 에러");
					document.getElementById('modalText01').innerHTML='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
				
			});
		}
	});
	
	// 확인(추가)버튼 눌렀을 때의 이벤트
	$(".addMasterBtn").click(function(){
		if(check != 1){
			document.getElementById('modalText01').innerHTML='아이디 중복 확인을 해주세요.';
			$('#dangerModal').modal('show');
			return false;
		//아이디 값과 현재 값이 다른지 체크 
		}else if(!(username==$(".username").val())){
			document.getElementById('modalText01').innerHTML='올바른 접근이 아닙니다.';
			$('#dangerModal').modal('show');
			return false;
		}else{
			if($('.comCode').val().replace(/\s/gi,"")==""||
			   $('.comName').val().replace(/\s/gi,"")==""||
			   $('.ceo').val().replace(/\s/gi,"")==""||
			   $('.manager').val().replace(/\s/gi,"")==""||
			   $('.comPhone').val().replace(/\s/gi,"")==""||
			   $('.contractDateInput').val().replace(/\s/gi,"")==""||
			   $('.branchSelected').val().replace(/\s/gi,"")==""||
			   $('.officeSelected').val().replace(/\s/gi,"")==""||
			   $('.MoveInDateInput').val().replace(/\s/gi,"")==""||
			   $('.MoveOutDateInput').val().replace(/\s/gi,"")==""){
				document.getElementById('modalText01').innerHTML='입력하지 않은 정보가 있습니다.';
				$('#dangerModal').modal('show');
				return false;
			} else{
				return true;
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
				<h3>9'o Clock</h3>
				<p>입주 계약이 완료된 회사의 마스터 계정을 추가해주세요.</p>
			</div>
			
			<div class="col-md-9 register-right">
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
						<h3 class="register-heading">마스터 계정 추가</h3>
						<form action="addMasterAccount" method="post" class="joinForm">
							<div class="row register-form">
								<div class="col-md-3">
									<div class="form-group">
										<input type="text" class="form-control comCode" placeholder="회사코드 *" id="comCodeInput" name="comCode"/>
									</div>
								</div>
								<div class="col-md-5">
									<div class="form-group">
										<input type="text" class="form-control comName" placeholder="회사명 *" id="comNameInput" name="comName"/>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<input type="text" class="form-control ceo" placeholder="대표 *" id="ceoInput" name="ceo"/>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<input type="text" class="form-control manager" placeholder="담당자 *" id="managerInput" name="manager"/>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<input type="number" class="form-control comPhone" placeholder="회사연락처 *" id="comPhoneInput" name="comPhone"/>
									</div>
								</div>
								
								<div class="col-md-12">
									<div class="form-group">
										<input type="text" class="form-control username" placeholder="아이디 *" id="usernameInput" name="username"/>
										<input type="hidden" class="form-control id" id="idInput" name="id"/>
										<input type="button" class="btn btn-primary userCheck" id="checkBtn" value="중복확인"/>
									</div>
								</div>
								
								<div class="col-md-12">
									<div class="form-group">
										<h3 class="officeInfoTitle">입주 정보 추가</h3>
									</div>
								</div>
								
								<div class="col-md-12">
									<div class="form-group">
										<label class="form-control contractDate">계약일 *: </label>
										<input type="date" class="form-control contractDateInput" name="contractDateInput"/>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<label class="form-control selectBranch">지점 *: </label>
										<select class="form-control branchSelected" name="branchSelected">      
								        	<option selected >지점선택</option>
											<c:forEach items="${branchList }" var="list">
									        	<option value="${list.branchName }" >${list.branchName }</option>
									        </c:forEach>
										</select>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<label class="form-control officeRented">입주공간 *: </label>
										<select class="form-control officeSelected" name="officeSelected">      
								        	<option selected >공간선택</option>
											<c:forEach items="${officeInfoList }" var="list">
												<option value="${list.officeName }" >${list.officeName }</option>
									        </c:forEach>
										</select>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<label class="form-control MoveInDate">입주일 *: </label>
										<input type="date" class="form-control MoveInDateInput" name="MoveInDateInput"/>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<label class="form-control MoveOutDate">퇴소일 *: </label>
										<input type="date" class="form-control MoveOutDateInput" name="MoveOutDateInput"/>
									</div>
								</div>
									
								<div class="col-md-12">
									<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
									<input type="submit" class="btnRegister addMasterBtn" value="확인"/>
								</div>
							</div>
						</form>
					</div>
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
<%@ include file="template/footer.jspf" %>