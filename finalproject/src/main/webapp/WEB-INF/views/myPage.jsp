<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%@ include file="./template/header.jspf" %>

<meta name="_csrf" content="${_csrf.token}"/>
<title>마이페이지</title>

<script type="text/javascript">
	//csrf 토큰 타입별 전송 기능
	var csrfToken = $("meta[name='_csrf']").attr("content");
	$.ajaxPrefilter(function(options, originalOptions, jqXHR){
		if (options['type'].toLowerCase() === "post" || options['type'].toLowerCase() === "put" || options['type'].toLowerCase() === "delete") {
			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
		}
	});
	
	//정보 수정 시 종합 검사용
	var booInfo=false;
	
	//멤버 닉네임 중복 검사용
	var memNickBoo=false;
	
	//닉네임 오류 검사용
	var nickNameLengthBoo=false;
	var nickNameCharacterBoo=false;
	
	//기존 비밀번호 확인 및 새 비밀번호 사용가능 확인
	var booExPw=false;
	var booNewPw=false;
	
	//회원탈퇴 기존 비밀번호 확인
	var booWPw=false;
	
	//비밀번호 변경 버튼 클릭 시 고의적인 값 변경을 막기 위한 값 체크
	var existingPw="none"; //기존 비밀번호 확인 값 저장
	var newPw="none"; //새 비밀번호 값 저장
	var newCheckPw="none"; //새 비밀번호 확인 값 저장
	
	//회원탈퇴 기능 기존 비밀번호 깂 체크
	var withdrawalPw="none"; //회원탈퇴 비밀번호 확인 값 저장
	
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
	
	//파라미터 받기 기능
	function getParameter(name) {
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
	
	//입력 수 제한 기능
	function lengthCheck(check, min, max){
		var name= $("."+check);
		var span= check + "Unavailable";
		if(name.val().length < min || name.val().length > max){
			document.getElementById('modalText01').textContent=min+"자리 이상 "+max+"자리 이내로 입력해주세요";
			$('#dangerModal').modal('show');
			booInfo = false;
			if(check=="memNickName"){
				nickNameLengthBoo=false;
			}
		}else{
			//$("."+span).remove();
			booInfo = true;
			if(check=="memNickName"){
				nickNameLengthBoo=true;
			}
		}
		
		if(name.val().length > max){
			name.val(name.val().substring(0,max));
		}
		
	}
	
	//숫자,문자,특수문자 사용 제한 기능
	function unavailableCharacter(data,check,u_Character){
		var name= $("."+check);
		var span= check + "Unavailable";
		var text="";
		if(u_Character==pattern_num){
			text="숫자는 사용할 수 없습니다";
		}else if(u_Character==pattern_eng){
			text="문자는 사용할 수 없습니다";
		}else{
			text="특수문자는 사용할 수 없습니다";
		}
		
		if(u_Character.test($(data).prop('key'))){
			if($(data).prop('key')!='Backspace'){
				document.getElementById('modalText01').textContent=text;
				$('#dangerModal').modal('show');
				booInfo = false;
				if(check=="memNickName"){
					nickNameCharacterBoo=false;
				}
				
			}
		}else if(window.event.keyCode==32){
			document.getElementById('modalText01').textContent='공백은 사용할 수 없습니다.';
			$('#dangerModal').modal('show')
			booInfo = false;
			if(check=="memNickName"){
				nickNameCharacterBoo=false;
			}	
		}else{
			if(check=="memNickName"){
				nickNameCharacterBoo=true;
			}
		}
	}
	
	
	$(function(){
		
		var bbsPaging = getParameter("currentPage");
		if(bbsPaging!=""){
			$('.bbsPagingClick').trigger('click');
		}
		
	//회원정보 수정 
		//수정 버튼 클릭 시 값 강제 변경 여부 확인용 값 저장
		var adminNickName=$(".adminNickName").val();
		var comName=$(".comName").val();
		var ceo=$(".ceo").val();
		var manager=$(".manager").val();
		var comPhone=$(".comPhone").val();
		var memNickName=$(".memNickName").val();
		var dept=$(".dept").val();
		var memPhone=$(".memPhone").val();
		
		
		
		
		
		
		//수정 버튼 한 번 클릭 여부 확인 기능
		var oneClick=false;
		
		//수정 버튼 기능 활성화
		$(".updateInfoBtn").click(function(){
			// 수정 버튼 한 번 먼저 눌렀는지 확인
			if(oneClick){
				//조건 1. 정보 값 체크한 결과 여부 확인
				if(booInfo==false){
					document.getElementById('modalText01').textContent="수정할 내용을 확인하세요";
					$('#dangerModal').modal('show');
					return false;
				//조건 2. 입력하면서 저장한 값들과 현재 값이 다른 지 확인(값 강제 변경 여부)
					//2-1 어드민인 경우
				}else if(adminNickName!= undefined){
						if(adminNickName != $(".adminNickName").val()){
							document.getElementById('modalText01').textContent='값 강제 변경은 허용하지 않습니다.';
							$('#dangerModal').modal('show');
							return false;
						}else if(pattern_spc.test($(".adminNickName").val())){
							document.getElementById('modalText01').textContent='닉네임에 특수문자는 사용할 수 없습니다.';
							$('#dangerModal').modal('show');
							return false;
						}
					//2-2 마스터인 경우
				}else if(comName!= undefined){
					if(comName != $(".comName").val() || 
					   ceo != $(".ceo").val() || 
					   manager != $(".manager").val() || 
					   comPhone != $(".comPhone").val() 
						){
						document.getElementById('modalText01').textContent='값 강제 변경은 허용하지 않습니다.';
						$('#dangerModal').modal('show');
						return false;
					}else if(pattern_spc.test($(".comName").val())){
						document.getElementById('modalText01').textContent='회사명에 특수문자는 사용할 수 없습니다.';
						$('#dangerModal').modal('show');
						return false;
					}else if(pattern_spc.test($(".ceo").val()) || pattern_num.test($(".ceo").val())){
						document.getElementById('modalText01').textContent='ceo에 특수문자 및 숫자는 사용할 수 없습니다.';
						$('#dangerModal').modal('show');
						return false;
					}else if(pattern_spc.test($(".manager").val()) || pattern_num.test($(".ceo").val())){
						document.getElementById('modalText01').textContent='매니저에 특수문자 및 숫자는 사용할 수 없습니다.';
						$('#dangerModal').modal('show');
						return false;
					}
					 $(".comPhone").val($(".comPhone").val().replace(/[^0-9]/g,""));
					
					//2-3 멤버인 경우
				}else{
					if(memNickName != $(".memNickName").val() || 
					   dept != $(".dept").val() || 
					   memPhone != $(".memPhone").val() 
						){
						document.getElementById('modalText01').textContent='값 강제 변경은 허용하지 않습니다.';
						$('#dangerModal').modal('show');
						return false;
					}
					//기존 닉네임을 변경하였을 경우 닉네임 중복검사 여부
					else if(memNickName!=$(".memNickName").attr("value")){
						if(memNickBoo==false){
							document.getElementById('modalText01').textContent='닉네임 중복을 확인해주세요.';
							$('#dangerModal').modal('show');
							return false;
						}
					}else if(pattern_spc.test($(".memNickName").val())){
						document.getElementById('modalText01').textContent='닉네임에 특수문자는 사용하실 수 없습니다.';
						$('#dangerModal').modal('show');
						return false;
					}else if(pattern_spc.test(dept)){
						document.getElementById('modalText01').textContent='부서에 특수문자는 사용하실 수 없습니다.';
						$('#dangerModal').modal('show');
						return false;
					}
					$(".memPhone").val($(".memPhone").val().replace(/[^0-9]/g,""));
				}
			}else{
				return false;
			}
		});
		
		//회원정보 수정 버튼 클릭 시 처음엔 readonly를 해제, 수정 버튼 기능 활성화
		$(".updateInfoBtn").one("click",function(){
			$('.updateInfoInput').removeAttr("readonly").css('background-color', '#FFFFE0');//.after('<span class="modifiable"> [수정 가능]</span>');
			oneClick=true;
			//어드민 계정 닉네임 2자 이상 10자 이내 입력 수 제한, 특수문자 사용 제한, 값 저장
			$(".adminNickName").keyup(function(data){
								   unavailableCharacter(data,"adminNickName",pattern_spc);
								   adminNickName=$(".adminNickName").val();
							   }).focusout(function(data){
								   lengthCheck("adminNickName",2,10);
							   });
			
			//마스터 계정 회사명 1자 이상 20자 이내 입력 수 제한, 특수문자 사용 제한, 값 저장
			$(".comName").keyup(function(data){
								   lengthCheck("comName",1,20);
								   unavailableCharacter(data,"comName",pattern_spc);
								   comName=$(".comName").val();
							   });
			
			//마스터 계정 ceo 2자 이상 10자 이내 입력 수 제한, 숫자, 특수문자 사용 제한, 값 저장
			$(".ceo").keyup(function(data){
								   unavailableCharacter(data,"ceo",pattern_num);
								   unavailableCharacter(data,"ceo",pattern_spc);
								   ceo=$(".ceo").val();
							   }).focusout(function(data){
								   lengthCheck("ceo",2,10);
							   });
			
			//마스터 계정 매니저 2자 이상 10자 이내 입력 수 제한, 숫자, 특수문자 사용 제한, 값 저장
			$(".manager").keyup(function(data){
								   unavailableCharacter(data,"manager",pattern_num);
								   unavailableCharacter(data,"manager",pattern_spc);
								   manager=$(".manager").val();
							   }).focusout(function(data){
								   lengthCheck("manager",2,10);
							   });
			
			//마스터 계정 전화번호 9자 이상 15자 이내 입력 수 제한, 문자, 특수문자 사용 제한, 값 저장
			$(".comPhone").keyup(function(data){
								   unavailableCharacter(data,"comPhone",pattern_eng);
								   unavailableCharacter(data,"comPhone",pattern_spc);
								   comPhone=$(".comPhone").val();
								   $(this).val($(this).val().replace(/[^0-9]/g,""));
						   }).focusout(function(data){
							   	   lengthCheck("comPhone",9,15);
							   	   $(this).val($(this).val().replace(/[^0-9]/g,""));
						   });
			
			//멤버 계정 닉네임 2자 이상 10자 이내 입력 수 제한, 특수문자 사용 제한, 값 저장
			$(".memNickName").keyup(function(data){
								   unavailableCharacter(data,"memNickName",pattern_spc);
								   memNickName=$(".memNickName").val();
							   }).focusout(function(){
								    lengthCheck("memNickName",2,10);
								    memNickName = $('.memNickName').val();
									if(memNickName.length>10 || memNickName.length<2 || pattern_spc.test(memNickName)){
										document.getElementById('modalText01').textContent="공백 및 2자 이상 10자리 이하, 특수문자 사용 여부를 확인해주세요";
										$('#dangerModal').modal('show');
									}else if(nickNameLengthBoo==true && nickNameCharacterBoo==true){
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
															memNickBoo=true;
														}else{
															if(memNickName==$(".memNickName").attr("value")){
																memNickBoo==true;
															}else{
																document.getElementById('modalText01').textContent='사용중인 닉네임입니다.';
																$('#dangerModal').modal('show');
																memNickBoo=false;
																$(".memNickName").focus();
															}
														}
													 },
											error: function(error){
												document.getElementById('modalText01').textContent='오류가 발생하였습니다.';
												$('#dangerModal').modal('show');
											}
											
										});
									}
								   
							   });
			
			//멤버 계정 부서 2자 이상 20자 이내 입력 수 제한, 특수문자 사용 제한, 값 저장
			$(".dept").keyup(function(data){
								   dept=$(".dept").val();
								   unavailableCharacter(data,"dept",pattern_spc);
							   }).focusout(function(data){
								   lengthCheck("dept",2,20);
							   });;
			//멤버 계정 전화번호 9자 이상 15자 이내 입력 수 제한, 문자, 특수문자 사용 제한, 값 저장
			$(".memPhone").keyup(function(data){
								   unavailableCharacter(data,"memPhone",pattern_eng);
								   unavailableCharacter(data,"memPhone",pattern_spc);
								   memPhone=$(".memPhone").val();
								   $(this).val($(this).val().replace(/[^0-9]/g,""));
						   }).focusout(function(data){
							   	   lengthCheck("memPhone",9,15);
							   	   $(this).val($(this).val().replace(/[^0-9]/g,""));
						   });;
			return false;
		});
		
		//비밀번호 16자 제한 기능 활성화
		pwLength(".existingPw");
		pwLength(".newPw");
		pwLength(".newCheckPw");
		pwLength(".withdrawalPw");
		
	//비밀번호 변경 기능	start
		//포커스아웃 시 기존 비밀번호 비교 검증
		$(".existingPw").focusout(function(){
			existingPw=$('.existingPw').val();
			var pw=existingPw;
			$.ajax({
				url: "/checkPw",
				type : "POST",
				data : {pw},
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "text",
				success: function(data){
						//기존 비밀번호 일치 시
						if(data == "correct"){
							
							document.getElementById('modalText02').textContent='비밀번호가 확인되었습니다.';
							$('#primaryModal').modal('show');
							
							//기존 비밀번호 일치 기능 활성화
							booExPw=true;
						//기존 비밀번호와 일치하지 않을 시 
						}else{
							document.getElementById('modalText01').textContent='비밀번호가 일치하지 않습니다.';
							$('#dangerModal').modal('show');
							//기존 비밀번호 일치 기능 비활성화
							booExPw=false;
						}
					 },
				
				error:function(request,status,error){
					 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					 }
			});
		});
		
		//포커스아웃 시 새 비밀번호 비교 검증 
		$(".newPw").focusout(function(){
			//1. 숫자, 영어, 특수문자 포함 여부
			if(!(pattern_spc.test($('.newPw').val())) ||
					!(pattern_num.test($('.newPw').val())) ||
					!(pattern_eng.test($('.newPw').val())) ){
				if($('.newPw').val()==null){
				document.getElementById('modalText01').textContent='숫자,영어,특수문자를 포함하여 비밀번호를 입력해주세요.';
				$('#dangerModal').modal('show');
				}
			}else if($('.newPw').val()==$(".existingPw").val()){
				document.getElementById('modalText01').textContent='기존 비밀번호와 다른 비밀번호를 입력해주세요.';
				$('#dangerModal').modal('show');
			}else{
				document.getElementById('modalText02').textContent='사용 가능한 비밀번호입니다.';
				$('#primaryModal').modal('show');
			}
			
			//2. 새 비밀번호를 변경할때마다 새 비밀번호 확인 인풋과 값이 다른지 확인 후 다르면 새 비밀번호 일치 기능 비활성화 
			if($(".newPw").val()!=$(".newCheckPw").val()){
				booNewPw=false;
			}else if(newCheckPw==""){
				booNewPw=false;
			}	
			
		});
		
		//새 비밀번호 확인 검증
		$(".newCheckPw").focusout(function(){
			newPw=$(".newPw").val();
			newCheckPw=$(".newCheckPw").val();
			//1. 공란일 경우 기능 비활성화 
			if(newCheckPw==""){
				booNewPw=false;
			//2. 새 비밀번호와 확인 값이 다른 경우 기능 비활성화
			}else if(newPw!=newCheckPw){
				booNewPw=false;
			//3. 확인 값에 숫자, 문자, 특수문자 세 가지가 모두 들어가 있는지 검증
			}else if(!(pattern_spc.test(newCheckPw)) ||
					!(pattern_num.test(newCheckPw)) ||
					!(pattern_eng.test(newCheckPw)) ){
				booNewPw=false;
			//4. 위 조건을 모두 충족할 경우 기능 활성화
			}else{
				booNewPw=true;
			}
		});
		
		//비밀번호 변경버튼 기능
		$(".updatePwBtn").click(function(){
			//1.기존 비밀번호 기능과 새 비밀번호 기능 활성화 여부 확인
			if(booExPw==false || booNewPw==false){
				document.getElementById('modalText01').textContent='기존 비밀번호 확인 및 변경할 비밀번호를 확인하세요.';
				$('#dangerModal').modal('show');
				return false;
			//2.비밀번호 강제 값 변경 여부 확인
			}else if(existingPw!=$('.existingPw').val() || 
					 newPw!=$('.newPw').val() ||
					 newCheckPw!=$('.newCheckPw').val()
					){
				document.getElementById('modalText01').textContent='비밀번호 강제 변경은 금지입니다.';
				$('#dangerModal').modal('show');
				return false;
			//3. 기존 비밀번호와 새 비밀번호의 값이 같은 같은지 확인	
			}else if(existingPw==newCheckPw){
				document.getElementById('modalText01').textContent='기존 비밀번호와 새 비밀번호가 일치합니다.';
				$('#dangerModal').modal('show');
				return false;
			//4. 위 조건을 모두 충족할 경우 비밀번호 변경
			}else{
				$.ajax({
					url: "/updatePw",
					type : "PUT",
					data : {newCheckPw},
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					dataType: "text",
					success: function(data){
								if(data=="success"){
									location.reload();
								}else{
									document.getElementById('modalText01').textContent='변경 오류.';
									$('#dangerModal').modal('show');
								}
							},
					error:function(request,status,error){
								document.getElementById('modalText01').textContent='변경 오류.';
								$('#dangerModal').modal('show');
						 }
				});
				
				return false;
			}
				
			
		});
		
	//비밀번호 변경 검증 기능 end	
		
	//회원탈퇴 기능 start
		//포커스아웃 시 기존 비밀번호 비교 검증
		$(".withdrawalPw").focusout(function(){
			withdrawalPw=$('.withdrawalPw').val();
			var pw=withdrawalPw;
			$.ajax({
				url: "/checkPw",
				type : "POST",
				data : {pw},
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "text",
				success: function(data){
						//기존 비밀번호 일치 시
						if(data == "correct"){
							document.getElementById('modalText02').textContent='비밀번호가 확인되었습니다.';
							$('#primaryModal').modal('show');
							//기존 비밀번호 일치 기능 활성화
							booWPw=true;
						//기존 비밀번호와 일치하지 않을 시 
						}else{
							document.getElementById('modalText01').textContent='비밀번호가 일치하지 않습니다.';
							$('#dangerModal').modal('show');
							//기존 비밀번호 일치 기능 비활성화
							booWPw=false;
						}
					 },
				
				error:function(request,status,error){
					 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					 }
			});
		});
		
		$(".withdrawBtn").click(function(){
			if(booWPw==false){
				document.getElementById('modalText01').textContent='비밀번호를 확인해주세요.';
				$('#dangerModal').modal('show');
				return false;
			}else if(withdrawalPw!=$(".withdrawalPw").val()){
				document.getElementById('modalText01').textContent='강제변경된 비밀번호는 허용하지 않습니다.';
				$('#dangerModal').modal('show');
				return false;
			}else if($(".acceptCb").is(":checked")==false){
				document.getElementById('modalText01').textContent='필수 동의란을 체크해주세요.';
				$('#dangerModal').modal('show');
				return false;
			}else{
				return true;
			}
		});
	
	
	//회원탈퇴 기능 end
	
	//멤버 로그인 권한 부여 기능 start
		$(".memberAdmission").click(function(){
			//현재 권한 허용, 비허용 여부
			var currAdmission = this.innerText;
			var curr=this;
			//선택한 멤버의 아이디
			var memberId = $(this).parent().parent().find(".memeberListId").text();
			
			$.ajax({
				url: "/updateMemberAdmission",
				type : "PUT",
				data : {currAdmission,memberId},
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "text",
				success: function(data){
							if(data=="updated"){
								if(currAdmission=="허용"){
									curr.innerText="비허용";
								}else{
									curr.innerText="허용";
								}
							}else{
								document.getElementById('modalText01').textContent='업데이트 실패';
								$('#dangerModal').modal('show');
							}
						},
				error:function(request,status,error){
						document.getElementById('modalText01').textContent='업데이트 실패';
						$('#dangerModal').modal('show');
					 }
			});
		})
		
	});
</script>
<script type="text/javascript">
//10,20,30개씩 selectBox 클릭 이벤트
function changeSelectBox(currentPage, countPerPage, pageSize){
    var selectValue = $("#cntSelectBox").children("option:selected").val();
    movePage(currentPage, selectValue, pageSize);
}
 
//페이지 이동
function movePage(currentPage, countPerPage, pageSize){
    
    var url = "/mypage";
    url = url + "?currentPage="+currentPage;
    url = url + "&countPerPage="+countPerPage;
    url = url + "&pageSize="+pageSize;
    
    location.href=url;
}


//만들어진 테이블에 페이지 처리

function page(table){ 
$('.'+table).each(function() {

var pagesu = 10;  //페이지 번호 갯수

var currentPage = 0;

var numPerPage = 10;  //목록의 수

var $table = $(this);    

var pagination = $("#pagination");


//length로 원래 리스트의 전체길이구함

var numRows = $table.find('tbody tr').length;


//Math.ceil를 이용하여 반올림

var numPages = Math.ceil(numRows / numPerPage);


//리스트가 없으면 종료

if (numPages==0) return;



//pager라는 클래스의 div엘리먼트 작성

var $pager = $('<div class="pager"></div>');

var nowp = currentPage;

var endp = nowp+10;


//페이지를 클릭하면 다시 셋팅

$table.bind('repaginate', function() {

//기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다

$table.find('tbody tr').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();

$("#pagination").html("");



if (numPages > 1) {     // 한페이지 이상이면

if (currentPage < 5 && numPages-currentPage >= 5) {   // 현재 5p 이하이면

nowp = 0;     // 1부터 

endp = pagesu;    // 10까지

}else{

nowp = currentPage -5;  // 6넘어가면 2부터 찍고

endp = nowp+pagesu;   // 10까지

pi = 1;

}

if (numPages < endp) {   // 10페이지가 안되면

endp = numPages;   // 마지막페이지를 갯수 만큼

nowp = numPages-pagesu;  // 시작페이지를   갯수 -10

}

if (nowp < 1) {     // 시작이 음수 or 0 이면

nowp = 0;     // 1페이지부터 시작

}

}else{       // 한페이지 이하이면

nowp = 0;      // 한번만 페이징 생성

endp = numPages;

}


// [처음]

$('<span class="pageNum first"><<</span>').bind('click', {newPage: page},function(event) {

currentPage = 0;   

$table.trigger('repaginate');  

$($(".pageNum")[2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');



// [이전]

$('<span class="pageNum back">&nbsp;<&nbsp;</span>').bind('click', {newPage: page},function(event) {

if(currentPage == 0) return; 


currentPage = currentPage-1;

$table.trigger('repaginate'); 

$($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');


// [1,2,3,4,5,6,7,8]

for (var page = nowp ; page < endp; page++) {

$('<span  style="cursor:pointer" class="pageNum"></span>').text(page + 1).append('&nbsp;').bind('click', {newPage: page}, function(event) {

currentPage = event.data['newPage'];

$table.trigger('repaginate');

$($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');

} 



// [다음]

$('<span class="pageNum next">>&nbsp;</span>').bind('click', {newPage: page},function(event) {

if(currentPage == numPages-1) return;


currentPage = currentPage+1;

$table.trigger('repaginate'); 

$($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');


// [끝]

$('<span class="pageNum last">>></span>').bind('click', {newPage: page},function(event) {

currentPage = numPages-1;

$table.trigger('repaginate');

$($(".pageNum")[endp-nowp+1]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');


$($(".pageNum")[2]).addClass('active');

});


$pager.insertAfter($table).find('span.pageNum:first').next().next().addClass('active');   

$pager.appendTo(pagination);

$table.trigger('repaginate');

});

}



$(function(){

// table pagination

page('paginated1');
page('paginated2');


});

</script>

<body>

<div class="content mypage"><!--content start-->
 <div class="row vartical-menu">
  <div class="left left-nav">
    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
      <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true"><img src="imgs/person-circle.svg"/><span>회원정보</span></a>
      <!-- 
      <a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false"><img src="imgs/pencil.svg"/><span>프로필 수정</span></a>
       -->
      <a class="nav-link" id="v-pills-password-tab" data-toggle="pill" href="#v-pills-password" role="tab" aria-controls="v-pills-password" aria-selected="false"><img src="imgs/pencil.svg"/><span>비밀번호 변경</span></a>
      <!-- 멤버일경우 내가 작성한글과 예약내역 -->
	  <sec:authorize access="hasRole('MEMBER')">
      <a class="nav-link bbsPagingClick" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false"><img src="imgs/pencil-square.svg"/><span>내가 작성한글</span></a>
      <a class="nav-link" id="v-pills-settings-tab" data-toggle="pill" href="#v-pills-settings1" role="tab" aria-controls="v-pills-settings1" aria-selected="false"><img src="imgs/file-text.svg"/><span>예약내역</span></a>
      </sec:authorize>
      <!-- 마스터일 경우 멤버관리 탭-->
      <sec:authorize access="hasRole('MASTER')">
      <a class="nav-link" id="v-pills-settings2-tab" data-toggle="pill" href="#v-pills-settings2" role="tab" aria-controls="v-pills-settings2" aria-selected="false"><img src="imgs/inboxes.svg"/><span>멤버관리</span></a>
      </sec:authorize>
      <a class="nav-link" id="v-pills-settings3-tab" data-toggle="pill" href="#v-pills-settings3" role="tab" aria-controls="v-pills-settings3" aria-selected="false"><img src="imgs/inboxes.svg"/><span>회원탈퇴</span></a>
      
    </div>
  </div>
  <div class="right"> 
    <div class="tab-content" id="v-pills-tabContent">
      <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
      <div id="mypageMargin">
        	<h5 class="mypageAccountInfo">계정정보</h5>
        	
        	<!-- 시큐리티 정보로 아이디 불러오기 -->
            <div class="input-group">
	              <label id="mypageLabel"  class="input-group-text">아이디</label>
	              <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal.username" var="user_id" />
                     <input type="text" class="form-control"  value=" ${user_id }" readonly="readonly"/>
                </sec:authorize> 
	         </div>
          	<form method="post" action="modifyInfo" class="formContents">
          		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> 
          		<input type="hidden" name="_method" value="PUT"/>
          		
			    <!-- 어드민일경우  -->
	      
	            <sec:authorize access="hasRole('ADMIN')">
	            <div class="input-group">
	            	 <label id="mypageLabel" class="input-group-text" for="adminNickName">닉네임</label>
	           		 <input type="text" name="adminNickName" class="form-control updateInfoInput adminNickName" value="${admin.adminAccount.nickName }" readonly="readonly"/>
	           	 </div>
	            <div class="input-group">
	           	 	<label id="mypageLabel" class="input-group-text" for="adminBranchCode">지점</label>
	           	 		<input type="text" class="form-control" name="adminBranchCode" value="${admin.branch.branchName }" readonly="readonly"/>
	           	 </div>
	           	 <div>
	           	  <input type="submit" class="btn btn-primary updateInfoBtn" value="수정하기"/>
	           	 </div>
	            </sec:authorize>
	            <!-- 마스터일경우  -->
	       
	            <sec:authorize access="hasRole('MASTER')">
	           	 <div class="input-group">
	           	 <label id="mypageLabel" class="input-group-text" for="masterSigndate">가입일자</label>
	           	 <input type="text" name="masterSigndate" class="form-control" value="${master.masteraccount.signdate }" readonly="readonly"/>
	           	</div><br>
	           	<h5 class="mypageComInfo">회사정보</h5>
	           	
	           	 <div class="input-group">
	             <label id="mypageLabel" class="input-group-text" for="comName">회사명</label>
	             <input type="text" name="comName" class="form-control updateInfoInput comName" value="${master.companyInfo.comName }" readonly="readonly"/>
	            </div>
	           	 <div class="input-group">
	             <label id="mypageLabel" class="input-group-text" for="ceo">ceo</label>
	             <input type="text" name="ceo" class="form-control updateInfoInput ceo" value="${master.companyInfo.ceo }" readonly="readonly"/>
	            </div>
	           	 <div class="input-group">
	             <label id="mypageLabel" class="input-group-text" for="manager">매니저</label>
	             <input type="text" name="manager" class="form-control updateInfoInput manager" value="${master.companyInfo.manager }" readonly="readonly"/>
	            </div>
	           	 <div class="input-group">
	             <label id="mypageLabel" class="input-group-text" for="comPhone">회사연락처</label>
	             <input type="text" name="comPhone" class="form-control updateInfoInput comPhone" value="${master.companyInfo.comPhone }" readonly="readonly"/>
	            </div>
	           	 <div class="input-group">
	             <label id="mypageLabel" class="input-group-text" for="point">포인트</label>
	             <input type="text" name="point" class="form-control" value="${master.companyInfo.point }" readonly="readonly"/>
	            </div>
	             <div class="input-group">
	             <label id="mypageLabel" class="input-group-text" for="contractDate">계약일자</label>
	             <input type="text" name="contractDate" class="form-control" value="${master.companyInfo.contractDate }" readonly="readonly"/>
	            </div>
	             <div class="input-group">
	             <label id="mypageLabel" class="input-group-text" for="rentStartDate">입주일자</label>
	             <input type="text" name="rentStartDate" class="form-control" value="${master.companyInfo.rentStartDate }" readonly="readonly"/>
	            </div>
	            <div class="input-group">
	             <label id="mypageLabel" class="input-group-text" for="rentFinishDate">만기일자</label>
	             <input type="text" name="rentFinishDate" class="form-control" value="${master.companyInfo.rentFinishDate }" readonly="readonly"/>
	            </div>
	            <div>
	           	  <input type="submit" class="btn btn-primary updateInfoBtn" value="수정하기"/>
	           	 </div>
	            </sec:authorize>
	   
	     
	            <!-- 멤버일경우  -->
	               
	            <sec:authorize access="hasRole('MEMBER')">
	             <div class="input-group">
	              <label id="mypageLabel" class="input-group-text" for="memName">이름</label>
	           	  <input type="text" name="memName" class="form-control" value="${member.memberInfo.memName }" readonly="readonly"/>
	           	 </div>
	           	 <div class="input-group">
	           	  <label id="mypageLabel" class="input-group-text" for="memNickName">닉네임</label>
	           	  <input type="text" name="memNickName" value="${member.memberInfo.memNickName }" class="form-control updateInfoInput memNickName" readonly="readonly"/>
	          	 </div>
	          	 <div class="input-group">
	          	  <label id="mypageLabel" class="input-group-text" for="dept">부서</label>
	          	  <input type="text" name="dept" value="${member.memberInfo.dept }" class="form-control updateInfoInput dept" readonly="readonly"/>
	          	 </div>
	          	 <div class="input-group">
	          	  <label id="mypageLabel" class="input-group-text" for="memPhone">전화번호</label>
	          	  <input type="text" name="memPhone" value="${member.memberInfo.memPhone }" class="form-control updateInfoInput memPhone" readonly="readonly"/>
	          	 </div>
	          	 <div class="input-group">
	          	  <label id="mypageLabel" class="input-group-text" for="signdate">가입일자</label>
	          	  <input type="text" name="signdate" class="form-control" value="${member.memberInfo.signdate }" readonly="readonly"/>
	          	 </div>
	          	 <div>
	           	  <input type="submit" class="btn btn-primary updateInfoBtn" value="수정하기"/>
	           	 </div>
		          	<h5 class="mypageComInfo">회사정보</h5>
		           	
		           	<div class="input-group">
		             <label id="mypageLabel" class="input-group-text" for="comName">회사명</label>
		             <input type="text" name="comName" class="form-control" value="${member.companyInfo.comName }" readonly="readonly"/>
		            </div>
		           		<div class="input-group">
		             <label id="mypageLabel" class="input-group-text" for="ceo">ceo</label>
		             <input type="text" name="ceo" class="form-control" value="${member.companyInfo.ceo }" readonly="readonly"/>
		            </div>
		           		<div class="input-group">
		             <label id="mypageLabel" class="input-group-text" for="manager">매니저</label>
		             <input type="text" name="manager" class="form-control" value="${member.companyInfo.manager }" readonly="readonly"/>
		            </div>
		           		<div class="input-group">
		             <label id="mypageLabel" class="input-group-text" for="comPhone">회사연락처</label>
		             <input type="text" name="comPhone" class="form-control" value="${member.companyInfo.comPhone }" readonly="readonly"/>
		            </div>
		           		<div class="input-group">
		             <label id="mypageLabel" class="input-group-text" for="point">포인트</label>
		             <input type="text" name="point" class="form-control" value="${member.companyInfo.point }" readonly="readonly"/>
		            </div>
		            	<div class="input-group">
		             <label id="mypageLabel" class="input-group-text" for="contractDate">계약일자</label>
		             <input type="text" name="contractDate" class="form-control" value="${member.companyInfo.contractDate }" readonly="readonly"/>
		            </div>
		            	<div class="input-group">
		             <label id="mypageLabel" class="input-group-text" for="rentStartDate">입주일자</label>
		             <input type="text" name="rentStartDate" class="form-control" value="${member.companyInfo.rentStartDate }" readonly="readonly"/>
		            </div>
		            	<div class="input-group">
		             <label id="mypageLabel" class="input-group-text" for="rentFinishDate">만기일자</label>
		             <input type="text" name="rentFinishDate" class="form-control" value="${member.companyInfo.rentFinishDate }" readonly="readonly"/>
		            </div>
	            </sec:authorize>
			</form>
		</div>
      </div>
      <div class="tab-pane fade updatePw" id="v-pills-password" role="tabpanel" aria-labelledby="v-pills-password-tab">
      	<div id="mypageMargin">
      	   <h5 class="mypagePw">비밀번호 변경</h5>
	       <div class="input-group">
        	<label id="mypageLabel2" class="input-group-text" for="existingPw">기존 비밀번호</label>
        	<input type="password" class="form-control existingPw" />
	       </div>
	       <div class="input-group">
       		<label id="mypageLabel2" class="input-group-text" for="newPw">새 비밀번호</label>
        	<input type="password" class="form-control newPw" />
	       </div> 	
	       <div class="input-group">
       		<label id="mypageLabel2" class="input-group-text" for="newCheckPw">새 비밀번호 확인</label>
        	<input type="password" class="form-control newCheckPw" />
	       </div> 	
	       <div class="input-group">
	       	<button type="button" class="btn btn-primary updatePwBtn">변경하기</button>
	       </div>
	      </div>
       </div>
      <!-- 멤버일 경우 내가 작성한글과 예약내역 탭 start-->
      <sec:authorize access="hasRole('MEMBER')">
      <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
      	<div id="mypageMargin">
        	<div class="content bbs myBbs"><!--content start-->
				<div class="container">
					<div class="row myBbsRow">
						    <div class="bottom">
						        <div class="bottom-left">
						            <select id="k" name="cntSelectBox"
						                onchange="changeSelectBox(${pagination.currentPage},${pagination.countPerPage},${pagination.pageSize});"
						                class="form-control" style="width: 100px;" hidden = "hidden">
						                <option value="10"
						                    <c:if test="${pagination.countPerPage == '10'}">selected</c:if>>10개씩</option>
						                <option value="20"
						                    <c:if test="${pagination.countPerPage == '20'}">selected</c:if>>20개씩</option>
						                <option value="30"
						                    <c:if test="${pagination.countPerPage == '30'}">selected</c:if>>30개씩</option>
						            </select>
						        </div>
						    </div>
						    
							<table id = "bbsTable" class="table table-bordered table-hover myPagBbsTable">
								<thead>
									<tr>
										<th class="myPagBbsTableNum">번호</th>
										<th>제목</th>
										<th class="myPagBbsTableDate">날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var = "list" items = "${boardList }">
										<tr>
											<td class="myPageBbsTableNumTd"><a href = "/board/detail?selectNum=${list.num }" style = "color:black">${list.num }</a></td>
											<td class="myPageBbsTableTitle"><a href = "/board/detail?selectNum=${list.num }" style = "color:black">${list.title }</a></td>
											<td class="myPageBbsTableDateTd"><a href = "/board/detail?selectNum=${list.num }" style = "color:black">${list.date }</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- 페이징 됨-->
							  <!--paginate -->
						    <div class="paginate mypageBbsPaginate">
						        <div class="paginaion">
						            <a class="direction prev" href="javascript:void(0);"
						                onclick="movePage(1,${pagination.countPerPage},${pagination.pageSize});">
						                &lt;&lt; </a> 
						            <a class="direction prev" href="javascript:void(0);"
						                onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasPreviousPage == true}">-1</c:if>,${pagination.countPerPage},${pagination.pageSize});">
						                &lt; </a>
						 
						            <c:forEach begin="${pagination.firstPageNum}"
						                end="${pagination.lastPageNum}" var="idx">
						                <a
						                    style="color:<c:out value="${pagination.currentPage == idx ? '#000000; font-weight:700; margin-bottom: 2px;' : ''}"/> "
						                    href="javascript:void(0);"
						                    onclick="movePage(${idx},${pagination.countPerPage},${pagination.pageSize});"><c:out
						                        value="${idx}" /></a>
						            </c:forEach>
						            
						            <a class="direction next" href="javascript:void(0);"
						                onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasNextPage == true}">+1</c:if>,${pagination.countPerPage},${pagination.pageSize});">
						                &gt; </a> 
						            <a class="direction next" href="javascript:void(0);"
						                onclick="movePage(${pagination.totalRecordCount},${pagination.countPerPage},${pagination.pageSize});">
						                &gt;&gt; </a>
						        </div>
						    </div>
							
					</div>
				</div>
			</div><!--centent end-->
        </div>
      </div>
      
      <div class="tab-pane fade" id="v-pills-settings1" role="tabpanel" aria-labelledby="v-pills-settings-tab">
      	<div id="mypageMargin">
        	<h4 class="mypageReservationTitle">예약내역</h4>
        	<table class="table paginated2">
        		<thead class="thead-light">
        			<tr>
        				<th>예약일</th>
        				<th>방번호</th>
        				<th>입실시간</th>
        				<th>퇴실시간</th>
        				<th>사용인원</th>
        			</tr>
        		</thead>
        		<tbody>
        			<c:forEach items="${myReservation }" var="myRevList">
        			<tr>
        				<td>${myRevList.reservationDay }</td>
        				<td>${myRevList.roomNum }호</td>
        				<td>${myRevList.useStartTime }</td>
        				<td>${myRevList.useFinishTime }</td>
        				<td>${myRevList.userCount }</td>
        			</tr>
        			</c:forEach>
        		</tbody>
        	</table>
        	<div class="btnContent">
			<div class="pagination mypagePaging2" id="pagination">&nbsp;</div>
			</div>
        </div>
      </div>
      </sec:authorize>
      <!-- 멤버일 경우 내가 작성한글이랑 예약내역 탭 end -->
      <sec:authorize access="hasRole('MASTER')">
      <div class="tab-pane fade" id="v-pills-settings2" role="tabpanel" aria-labelledby="v-pills-settings-tab">
        <div id="mypageMargin">
        	<table class="table paginated1">
        		<thead class="thead-light">
        			<tr>
	        			<th>이름</th>
	        			<th class="mypageTableId">ID</th>
	        			<th>닉네임</th>
	        			<th>부서</th>
	        			<th class="mypageTablePhone">전화번호</th>
	        			<th>가입일자</th>
	        			<th class="mypageTableAdmission">권한여부</th>
        			</tr>
        		</thead>
        		<tbody>
        				<c:forEach items="${comMemberList }" var="memberList">
        				<tr>
	        				<td>${memberList.memName }</td>
	        				<td class="memeberListId">${memberList.id }</td>
	        				<td>${memberList.memNickName }</td>
	        				<td>${memberList.dept }</td>
	        				<td>${memberList.memPhone }</td>
	        				<td>${memberList.signdate }</td>
	        				<td class="mypageTableAdmissionContent">
	        				<a href="#" class="memberAdmission">
	        				<c:if test="${memberList.admission == 1}">
	        					허용
	        				</c:if>
	        				<c:if test="${memberList.admission != 1}">
	        					비허용
	        				</c:if>
	        				</a>
	        				</td>
        				</tr>
        				</c:forEach>
        		</tbody>
        	</table>
        	<div class="btnContent">
			<div class="pagination mypagePaging" id="pagination">&nbsp;</div>
			</div>
        </div>
      </div>
      </sec:authorize>
      <div class="tab-pane fade" id="v-pills-settings3" role="tabpanel" aria-labelledby="v-pills-settings-tab">
	      <div id="mypageMargin">
	      	<h5 class="mypageWithdrawInfoTitle">탈퇴 안내</h5>
	      	<div class="mypageWithdrawInfo">회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.</div>
	      	
	      	<div><b>사용하고 계신 아이디(${user_id })는 탈퇴할 경우 재사용 및 복구가 불가능합니다.</b></div>
	      	<div class="mypageWithdrawGuidance"><font class="myPageRed">탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구가 불가</font>하오니 신중하게 선택하시기 바랍니다.</div>
				
	      	<div><b>탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.</b></div>
	      	<div class="mypageWithdrawGuidance">회원정보 등 개인형 서비스 이용기록은 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.<br>
				삭제되는 내용을 확인하시고 필요한 데이터는 미리 백업을 해주세요.</div>
	       
	       	<div><b>게시글 및 댓글은 탈퇴 시 자동 삭제되지 않고 그대로 남아 있습니다.</b></div>
	       	<div class="mypageWithdrawGuidance">
				삭제를 원하는 게시글이 있다면 <font class="myPageRed">반드시 탈퇴 전 삭제하시기 바랍니다.</font><br>
				탈퇴 후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없어, 게시글을 임의로<br> 삭제해드릴 수 없습니다.
	       	</div>
	       	<h5 class="mypageWithdrawInfoTitle">회원 탈퇴</h5>
	       	<div class="myPageRed">
	       		탈퇴 후에는 아이디와 데이터는 복구할 수 없습니다.<br>
				게시판형 서비스에 남아 있는 게시글은 탈퇴 후 삭제할 수 없습니다.<br>
	       	</div>
	       	<div class="mypageWithdrawBottom"><br>
	       		비밀번호 확인
	       		<input type="password" class="withdrawalPw" />
	       	</div>
	       	<div class="mypageWithdrawBottom">
	       		<input type="checkbox" class="acceptCb"/> &nbsp;안내 사항을 모두 확인하였으며, 이에 동의합니다.
	       	</div>
	       	<div>
	       		<form action="/withdraw" method="post">
	       			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> 
	       			<input type="hidden" name="_method" value="delete"/>
	       			<input type="submit" class="btn btn-primary withdrawBtn" value="회원탈퇴"/>
	       		</form>
	       	</div>
	      </div>
      </div>
    </div>
  </div>
</div>   
</div>
<!--centent end-->
<%@ include file="./template/footer.jspf" %>
<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->