<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ include file="./template/header.jspf" %>

<meta name="_csrf" content="${_csrf.token}"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
	.incorrectPw :{
		color:"red";
	}
	.correctPw:{
		color:"green";
	}
	

</style>

<script type="text/javascript">
	var csrfToken = $("meta[name='_csrf']").attr("content");
	$.ajaxPrefilter(function(options, originalOptions, jqXHR){
		if (options['type'].toLowerCase() === "post") {
			jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
		}
	});
	
	
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
	
	$(function(){
		//비밀번호 16자 제한 기능 활성화
		pwLength(".existingPw");
		pwLength(".newPw");
		pwLength(".newCheckPw");
		pwLength(".withdrawalPw");
		
	//비밀번호 변경 기능	start
		//포커스아웃 시 기존 비밀번호 비교 검증
		$(".existingPw").focusout(function(){
			existingPw=$('.existingPw').val();
			console.log(existingPw);
			var pw=existingPw;
			$.ajax({
				url: "/checkPw",
				type : "POST",
				data : {pw},
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "text",
				success: function(data){
						console.log("data",data);
						//기존 비밀번호 일치 시
						if(data == "correct"){
							$(".incorrectPw").remove();
							$(".correctPw").remove();
							$(".existingPw").after(' <span class="correctPw">비밀번호가 확인되었습니다</span>')
							$(".correctPw").css("color","blue");
							//기존 비밀번호 일치 기능 활성화
							booExPw=true;
						//기존 비밀번호와 일치하지 않을 시 
						}else{
							$(".incorrectPw").remove();
							$(".correctPw").remove();
							$(".existingPw").after(' <span class="incorrectPw">비밀번호가 일치하지 않습니다</span>');
							$(".incorrectPw").css("color","red");
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
				$(".usablePw").remove();
				$(".unusablePw").remove();
				$(".incorrectNewPw").remove();
				$('.newPw').after(' <span class="unusablePw">숫자,영어,특수문자를 포함하여 비밀번호를 입력해주세요</span>');
				$(".unusablePw").css("color","red");
			}else{
				$(".usablePw").remove();
				$(".unusablePw").remove();
				$(".incorrectNewPw").remove();
				$('.newPw').after(' <span class="usablePw">사용 가능한 비밀번호입니다</span>');
				$(".usablePw").css("color","blue");
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
				alert("기존 비밀번호 확인 및 변경할 비밀번호를 확인하세요");
				return false;
			//2.비밀번호 강제 값 변경 여부 확인
			}else if(existingPw!=$('.existingPw').val() || 
					 newPw!=$('.newPw').val() ||
					 newCheckPw!=$('.newCheckPw').val()
					){
				alert("비밀번호 강제 변경은 금지입니다");
				return false;
			//3. 기존 비밀번호와 새 비밀번호의 값이 같은 같은지 확인	
			}else if(existingPw==newCheckPw){
				alert("기존 비밀번호와 새 비밀번호가 일치합니다");
				return false;
			//4. 위 조건을 모두 충족할 경우 비밀번호 변경
			}else{
				$.ajax({
					url: "/updatePw",
					type : "POST",
					data : {newCheckPw},
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					dataType: "text",
					success: function(data){
								if(data=="success"){
									location.reload();
								}else{
									alert("변경 오류");
								}
							},
					error:function(request,status,error){
						 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
			console.log(withdrawalPw);
			var pw=withdrawalPw;
			$.ajax({
				url: "/checkPw",
				type : "POST",
				data : {pw},
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "text",
				success: function(data){
						console.log("data",data);
						//기존 비밀번호 일치 시
						if(data == "correct"){
							$(".incorrectWPw").remove();
							$(".correctWPw").remove();
							$(".withdrawalPw").after(' <span class="correctWPw">비밀번호가 확인되었습니다</span>')
							$(".correctWPw").css("color","blue");
							//기존 비밀번호 일치 기능 활성화
							booWPw=true;
						//기존 비밀번호와 일치하지 않을 시 
						}else{
							$(".incorrectWPw").remove();
							$(".correctWPw").remove();
							$(".withdrawalPw").after(' <span class="incorrectWPw">비밀번호가 일치하지 않습니다</span>');
							$(".incorrectWPw").css("color","red");
							//기존 비밀번호 일치 기능 비활성화
							booWPw=false;
						}
					 },
				
				error:function(request,status,error){
					 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					 }
			});
		});
		
	//회원탈퇴 기능 end
		
		
		
	});


</script>

<body>
<div class="content mypage"><!--content start-->
 <div class="row vartical-menu">
  <div class="left left-nav">
    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
      <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true"><img src="imgs/person-circle.svg"/><span>회원정보</span></a>
      <a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false"><img src="imgs/pencil.svg"/><span>비밀번호 변경</span></a>
      <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false"><img src="imgs/pencil-square.svg"/><span>내가 작성한글</span></a>
      <a class="nav-link" id="v-pills-settings-tab" data-toggle="pill" href="#v-pills-settings1" role="tab" aria-controls="v-pills-settings1" aria-selected="false"><img src="imgs/file-text.svg"/><span>예약내역</span></a>
      <!-- 마스터일 경우 멤버관리 탭-->
      <sec:authorize access="hasRole('MASTER')">
      <a class="nav-link" id="v-pills-settings2-tab" data-toggle="pill" href="#v-pills-settings2" role="tab" aria-controls="v-pills-settings2" aria-selected="false"><img src="imgs/inboxes.svg"/><span>맴버관리</span></a>
      </sec:authorize>
      <a class="nav-link" id="v-pills-settings3-tab" data-toggle="pill" href="#v-pills-settings3" role="tab" aria-controls="v-pills-settings3" aria-selected="false"><img src="imgs/inboxes.svg"/><span>회원탈퇴</span></a>
      
    </div>
  </div>
  <div class="right">
    <div class="tab-content" id="v-pills-tabContent">
      <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
        	<!-- 시큐리티 정보로 아이디 불러오기 -->
        	<div>아이디 <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal.username" var="user_id" />
                     ${user_id }
                </sec:authorize> 
            </div>
              
          	<form method="post">
			    <!-- 어드민일경우  -->
	      
	            <sec:authorize access="hasRole('ADMIN')">
	             <div>
	            	 <label for="adminNickName">닉네임</label>
	           		 <input type="text" name=adminNickName value="${admin.nickName }"/>
	           	 </div>
	           	 <div>
	           	 	<label for="adminBranchCode">브랜치코드</label>
	           	 	<c:if test="${admin.branchCode eq 1 }">
	           	 		<input type="text" name=adminBranchCode value="종로"/>
	           	 	</c:if>ㅎ
	           	 </div>
	           	 <div>
	           	 	<label for="adminProfile">닉네임</label>
	           	 	<input type="text" name=adminProfile value="${admin.profile }"/>
	           	 </div>
	            </sec:authorize>
	            
	            
	           
	            <!-- 마스터일경우  -->
	       
	            <sec:authorize access="hasRole('MASTER')">
	            <div>
	             <input type="text" name=masterComCode value="${master.companyInfo.comName }"/>
	            </div>
	           	<div>
	           	 <input type="text" name=masterSigndate value="${master.masteraccount.signdate }"/>
	           	</div> 
	            </sec:authorize>
	   
	            
	            <!-- 멤버일경우  -->
	               
	            <sec:authorize access="hasRole('MEMBER')">
	             <div>
	             이름 
	           	  <input type="text" name=memName value="${member.memberInfo.memName }" readonly="readonly"/>
	           	 </div>
	           	 <div>
	           	 닉네임 
	           	  <input type="text" name=memNickName value="${member.memberInfo.memNickName }" readonly="readonly"/>
	          	 </div>
	          	 <div>
	          	 회사이름 
	          	  <input type="text" name=comCode value="${member.companyInfo.comName }" readonly="readonly"/>
	          	 </div>
	          	 <div>
	          	 전화번호 
	          	  <input type="text" name=memPhone value="${member.memberInfo.memPhone }" readonly="readonly"/>
	          	 </div>
	          	 <div>
	          	 가입일자 
	          	  <input type="text" name=signdate value="${member.memberInfo.signdate }" readonly="readonly"/>
	          	 </div>
	            </sec:authorize>
			</form>
        
      </div>
      <div class="tab-pane fade updatePw" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
        <div>
        	기존 비밀번호
        	<input type="password" class="existingPw" />
       </div>
       <div>
       		새 비밀번호
        	<input type="password" class="newPw" />
       </div> 	
       <div>
       		새 비밀번호 확인
        	<input type="password" class="newCheckPw" />
       </div> 	
       <div>
       	<button type="button" class="updatePwBtn">변경하기</button>
       </div>
        	
       </div>
      <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
        잘있어요
      </div>
      <div class="tab-pane fade" id="v-pills-settings1" role="tabpanel" aria-labelledby="v-pills-settings-tab">
        저는 이만 갑니다
      </div>
      <sec:authorize access="hasRole('MASTER')">
      <div class="tab-pane fade" id="v-pills-settings2" role="tabpanel" aria-labelledby="v-pills-settings-tab">
        멤버관리란
      </div>
      </sec:authorize>
      <div class="tab-pane fade" id="v-pills-settings3" role="tabpanel" aria-labelledby="v-pills-settings-tab">
       	<div>
       		비밀번호 확인
       		<input type="password" class="withdrawalPw" />
       	</div>
       	<div>
       		<input type="checkbox"/> 회원 탈퇴와 함께 등록된 모든 개인정보는 삭제, 폐기 처리되며 복구되지 않습니다. (필수) 
       	</div>
       	<div>
       		탈퇴 후에도 게시판형 서비스에 등록한 게시물은 그대로 남아 있습니다.
       	</div>
      </div>
      
    </div>
  </div>
</div>   
</div>
<!--centent end-->

</body><!--body end-->
<!--body end-->
<%@ include file="./template/footer.jspf" %>
</html>



<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->