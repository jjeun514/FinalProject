<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>마스터계정추가</title>
<%@ include file="template/AdminNavbar.jspf" %>

<script type="text/javascript">
$('.spaceMgmtLink').attr('class','nav-link spaceMgmtLink');
$('.companyMgmtLink').attr('class','nav-link companyMgmtLink');
$('.masterMgmtLink').attr('class','nav-link masterMgmtLink active');
$('.meetingRoomMgmtLink').attr('class','nav-link meetingRoomMgmtLink');
$('.signUpMgmtLink').attr('class','nav-link signUpMgmtLink');

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
		console.log('username: '+username);
		if(username==""){
			document.getElementById('modalText01').textContent='아이디를 입력해주세요.';
			$('#dangerModal').modal('show');
		} else if((pattern_kor.test(username))){
			document.getElementById('modalText01').textContent='한글은 허용하지 않습니다.';
			$('#dangerModal').modal('show');
	    	return false;
		} else{
			console.log('ajax이전 username: '+username);
			$.ajax({
				url: "/masterIdCheck",
				type : "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				data: {username},
				success: function(data){
					console.log('ajax이후 username: '+username);
					console.log("data: "+data);
					if(data=="notallowed"){
						document.getElementById('modalText01').textContent='사용중인 아이디입니다.';
						$('#dangerModal').modal('show');
						check=-1;
					}else{
						document.getElementById('modalText02').textContent='사용가능한 아이디입니다.';
						$('#username').val(username);
						$('#primaryModal').modal('show');
						// 중복확인 후 아이디 변경 불가
						$(".username").attr("disabled", true);
						$("#checkBtn").attr("disabled", true);
						check=1;
					}
				 },
				error: function(error){
					console.log("ajax 에러");
					document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
			});
		}
	});
	
	// 1) 지점 선택
	$('.branchSelected').change(function(){
		console.log('지점 선택');
		$('.officeSelected').attr('disabled', true);
		$('.officeSelected').html('<option selected>공간선택</option>');
		$('.floorSelected').html('<option selected>층선택</option>');
		
		if($('.branchSelected').val()!='지점선택'){
			$.ajax({
				url: "/branchSelected",
				type : "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "JSON",
				data: {
					branchSelected:$('.branchSelected').val()
				},
				success: function(data){
					console.log('[ajax성공] data: '+JSON.stringify(data));
					$('.floorSelected').attr('disabled', false);
					$.each(data, function (floorsByBranch, item) {
						console.log("floorsByBranch : "+floorsByBranch);
						console.log("item : "+JSON.stringify(item.length));
						for(var index=0; index<item.length; index++){
							console.log("[반복문]floor : "+JSON.stringify(item[index].office.floor));
							if(index==0){
								$('.floorSelected').html('<option selected>층선택</option>');
								$('.floorSelected').append('<option>'+JSON.stringify(item[index].office.floor)+'</option>');
							} else{
								$('.floorSelected').append('<option>'+JSON.stringify(item[index].office.floor)+'</option>');
							}
						}
		            });
					
					// 2) 층 선택
					$('.floorSelected').change(function(){
						console.log('층 선택');
						if($('.floorSelected').val()!='층선택'){
							console.log('층 선택 ajax');
							$.ajax({
								url: "/floorSelected",
								type : "POST",
								contentType: "application/x-www-form-urlencoded; charset=UTF-8",
								dataType: "JSON",
								data: {
									branchSelected:$('.branchSelected').val(),
									floorSelected:$('.floorSelected').val()
								},
								success: function(data){
									console.log('[ajax성공] data: '+JSON.stringify(data));
									$('.officeSelected').attr('disabled', false);
									$.each(data, function (offices, item) {
										console.log("offices : "+offices);
										console.log("item : "+JSON.stringify(item.length));
										if(JSON.stringify(item.length)==0){
											document.getElementById('modalText01').textContent=$('.branchSelected').val()+'지점 '+$('.floorSelected').val()+'층에 입주 가능한 공간이 없습니다. 다른 곳을 선택해주세요.';
											$('#dangerModal').modal('show');
											$('.officeSelected').attr('disabled', true);
										} else {
											for(var index=0; index<item.length; index++){
												console.log("[반복문]offices : "+JSON.stringify(item[index].office.officeName));
												if(index==0){
													$('.officeSelected').html('<option selected>공간선택</option>');
													$('.officeSelected').append('<option>'+JSON.stringify(item[index].office.officeName).replaceAll("\"","")+'</option>');
												} else{
													$('.officeSelected').append('<option>'+JSON.stringify(item[index].office.officeName).replaceAll("\"","")+'</option>');
												}
											}
										}
						            });
									
									// 3) 입주공간 선택
									$('.officeSelected').change(function(){
										$('.MoveInDateInput').attr('disabled', false);
										if($('.MoveInDateInput').val()!=''){
											$('.MoveOutDateInput').attr('disabled', false);
										}
										console.log('입주공간 선택');
										if($('.officeSelected').val()!='공간선택'){
											console.log('공간 선택 ajax');
											var date=new Date();
											var today=date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0"+date.getDate()).slice(-2);
											console.log('today: '+today);
											var moveInDate=$('.MoveInDateInput').val();
											var moveOutDate;
											
											$('.MoveInDateInput').change(function(){
												moveInDate=$('.MoveInDateInput').val();
												var diff=Math.ceil(new Date(moveInDate).getTime()-new Date(today).getTime());
												diff=Math.ceil(diff/(1000*3600*24));
												console.log('오늘-입주일: '+diff);
												
												if(diff<0){
													console.log('오늘보다 이전');
												} else{
													console.log('오늘보다 이후');
													if(diff>7){
														document.getElementById('modalText01').textContent='입주일까지 '+diff+'일 남았습니다. 입주 7일 전 등록을 권장합니다.';
														$('#dangerModal').modal('show');
													} else{
														if(diff==0){
															document.getElementById('modalText02').textContent='오늘이 입주일 입니다.';
															$('#primaryModal').modal('show');
														} else{
															document.getElementById('modalText02').textContent='입주일까지 '+diff+'일 남았습니다.';
															$('#primaryModal').modal('show');
														}
													}
												}
												$('.MoveOutDateInput').attr('disabled', false);
											});
											
											$('.MoveOutDateInput').change(function(){
												moveOutDate=$('.MoveOutDateInput').val();
												var diff=Math.ceil(new Date(moveOutDate).getTime()-new Date(today).getTime());
												diff=Math.ceil(diff/(1000*3600*24));
												var diff2=Math.ceil(new Date(moveOutDate).getTime()-new Date(moveInDate).getTime());
												diff2=Math.ceil(diff2/(1000*3600*24));
												console.log('today-퇴소일: '+diff);
												console.log('입주일-퇴소일: '+diff2);
												if(diff<=0||diff2<=0){
													document.getElementById('modalText01').textContent='퇴소일이 잘못 입력되었습니다.';
													$('#dangerModal').modal('show');
													$('.MoveOutDateInput').val('');
												} else if(diff>0 && diff<31){
													document.getElementById('modalText01').textContent='입력하신 입주기간은 '+diff2+'일 입니다. 단기 계약이 맞는지 확인해주세요.';
													$('#dangerModal').modal('show');
												} else {
													console.log('퇴소일 정상');
													document.getElementById('modalText02').textContent='입력하신 입주기간은 '+diff2+'일 입니다.';
													$('#primaryModal').modal('show');
												}
											});
											
											$('.contractDateInput').change(function(){
												console.log('계약일 선택');
												$.contractCal();
											});
											
											$.contractCal=function(){
												if($('.contractDateInput').val()!=""){
													var contract=$('.contractDateInput').val();
													var diff=Math.ceil(new Date(contract).getTime()-new Date(today).getTime());
													diff=Math.ceil(diff/(1000*3600*24));
													var diff2=Math.ceil(new Date(contract).getTime()-new Date(moveInDate).getTime());
													diff2=Math.ceil(diff2/(1000*3600*24));
													var diff3=Math.ceil(new Date(contract).getTime()-new Date(moveOutDate).getTime());
													diff3=Math.ceil(diff3/(1000*3600*24));
													console.log('today-계약일: '+diff);
													console.log('입주일-계약일: '+diff2);
													console.log('퇴소일-계약일: '+diff3);
													if(diff>0||diff2>0||diff3>0){
														document.getElementById('modalText01').textContent='계약일이 잘못 입력되었습니다.';
														$('#dangerModal').modal('show');
														$('.contractDateInput').val('');
													} else if(diff==0){
														document.getElementById('modalText02').textContent='오늘 체결된 계약건입니다.';
														$('#primaryModal').modal('show');
													} else {
														console.log('계약일 정상');
														document.getElementById('modalText02').textContent=Math.abs(diff)+'일 전에 계약되었습니다.';
														$('#primaryModal').modal('show');
													}
													return false;
												}
											}
										} else {
											$('.MoveInDateInput').attr('disabled', true);
											$('.MoveOutDateInput').attr('disabled', true);
											$('.contractDateInput').attr('disabled', false);
										}
									});
								},
								error: function(error){
									console.log("ajax 에러");
									document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
									$('#dangerModal').modal('show');
								}
							});
						} else {
							$('.officeSelected').attr('disabled', true);
							$('.MoveInDateInput').attr('disabled', true);
							$('.MoveOutDateInput').attr('disabled', true);
							$('.contractDateInput').attr('disabled', false);
						}
					});
				},
				error: function(error){
					console.log("ajax 에러");
					document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
			});
		} else {
			$('.floorSelected').attr('disabled', true);
			$('.officeSelected').attr('disabled', true);
			$('.MoveInDateInput').attr('disabled', true);
			$('.MoveOutDateInput').attr('disabled', true);
			$('.contractDateInput').attr('disabled', false);
		}
	});
	
	// 확인(추가)버튼 눌렀을 때의 이벤트
	$(".addMasterBtn").click(function(){
		if(check != 1){
			document.getElementById('modalText01').textContent='아이디 중복 확인을 해주세요.';
			$('#dangerModal').modal('show');
			return false;
		//아이디 값과 현재 값이 다른지 체크 
		}else if(!(username==$(".username").val())){
			document.getElementById('modalText01').textContent='올바른 접근이 아닙니다.';
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
			   $('.floorSelected').val().replace(/\s/gi,"")==""||
			   $('.officeSelected').val().replace(/\s/gi,"")==""||
			   $('.MoveInDateInput').val().replace(/\s/gi,"")==""||
			   $('.MoveOutDateInput').val().replace(/\s/gi,"")==""){
				document.getElementById('modalText01').textContent='입력하지 않은 정보가 있습니다.';
				$('#dangerModal').modal('show');
				return false;
			} else{
				$.ajax({
					url: "/addMasterAccount",
					type : "POST",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					data: {
						username:username,
						branchSelected:$('.branchSelected').val(),
						floorSelected:$('.floorSelected').val(),
						officeSelected:$('.officeSelected').val(),
						comCode:$('#comCodeInput').val(),
						comName:$('#comNameInput').val(),
						ceo:$('#ceoInput').val(),
						manager:$('#managerInput').val(),
						comPhone:$('#comPhoneInput').val(),
						contractDateInput:$('.contractDateInput').val(),
						MoveInDateInput:$('.MoveInDateInput').val(),
						MoveOutDateInput:$('.MoveOutDateInput').val()						
					},
					success: function(data){
						console.log('[ajax성공] data: '+JSON.stringify(data));
						if(data=='중복'){
							console.log('입주 중복');
							document.getElementById('modalText01').textContent='선택하신 '+$('.branchSelected').val()+'지점 '+$('.floorSelected').val()+'층 '+$('.officeSelected').val()+' 사무실은 공실이 아닙니다.';
							$('#dangerModal').modal('show');
							return false;
						} else if(data=='가능') {
							console.log('입주 가능');
							document.getElementById('modalText01').textContent='처리중입니다. 잠시만 기다려주세요.';
							$('.closeDangerModal').hide();
							$(document.body).css('pointer-events', 'none');
							$('#dangerModal').css('color','red');
							$('#dangerModal').modal('show');
							location.href='masterMgmt';
						}
					},
					error: function(error){
						console.log("ajax 에러");
						document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
						$('#dangerModal').modal('show');
					}
				});
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
										<input type="hidden" name="username" id="username" />
										<input type="button" class="btn btn-primary userCheck" id="checkBtn" value="중복확인"/>
									</div>
								</div>
								
								<div class="col-md-12">
									<div class="form-group">
										<h3 class="officeInfoTitle">입주 정보 추가</h3>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<label class="form-control contractDate">계약일 *: </label>
										<input type="date" class="form-control contractDateInput" name="contractDateInput" disabled/>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<label class="form-control selectBranch">지점 *: </label>
										<select class="form-control branchSelected" name="branchSelected">      
								        	<option selected>지점선택</option>
											<c:forEach items="${branchList }" var="list">
									        	<option value="${list.branchName }" >${list.branchName }</option>
									        </c:forEach>
										</select>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<label class="form-control contractDate">층 *: </label>
										<select class="form-control floorSelected" name="floorSelected" disabled>      
								        	<option selected>층선택</option>
								        	<!-- 
											<c:forEach items="${floorList }" var="list">
									        	<option value="${list.floor }" >${list.floor }</option>
									        </c:forEach>
									        -->
										</select>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<label class="form-control officeRented">입주공간 *: </label>
										<select class="form-control officeSelected" name="officeSelected" disabled>      
								        	<option selected>공간선택</option>
											<c:forEach items="${officeInfoList }" var="list">
												<option value="${list.officeName }" >${list.officeName }</option>
									        </c:forEach>
										</select>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<label class="form-control MoveInDate">입주일 *: </label>
										<input type="date" class="form-control MoveInDateInput" name="MoveInDateInput" disabled/>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<label class="form-control MoveOutDate">퇴소일 *: </label>
										<input type="date" class="form-control MoveOutDateInput" name="MoveOutDateInput" disabled/>
									</div>
								</div>
									
								<div class="col-md-12">
									<input type="submit" class="btnRegister addMasterBtn" value="확인"/>
									<input type="button" class="btnRegister goBackBtn" onclick="location.href='masterMgmt'" value="취소"/>
								</div>
							</div>
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
				<button type="button" class="btn btn-danger btn-block closeDangerModal" data-dismiss="modal" id="closeBtn">확인</button>
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