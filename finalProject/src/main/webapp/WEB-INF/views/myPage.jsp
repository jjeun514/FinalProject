<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ include file="template/navbar.jspf" %>
<div class="content main mypage">
 <div class="row vartical-menu">
  <div class="left left-nav">
    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
      <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true"><img src="imgs/person-circle.svg"/><span>회원정보</span></a>
      <a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false"><img src="imgs/pencil.svg"/><span>비밀번호 변경</span></a>
      <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false"><img src="imgs/pencil-square.svg"/><span>내가 작성한글</span></a>
      <a class="nav-link" id="v-pills-settings-tab" data-toggle="pill" href="#v-pills-settings1" role="tab" aria-controls="v-pills-settings1" aria-selected="false"><img src="imgs/file-text.svg"/><span>예약내역</span></a>
      <a class="nav-link" id="v-pills-settings2-tab" data-toggle="pill" href="#v-pills-settings2" role="tab" aria-controls="v-pills-settings2" aria-selected="false"><img src="imgs/inboxes.svg"/><span>맴버관리</span></a>
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
	             <input type="text" name=masterComCode value="${master.comCode }"/>
	           	 <input type="text" name=masterSigndate value="${master.signdate }"/>
	           	 <input type="text" name=masterProfile value="${master.profile }"/>
	          	 <input type="text" name=masterAdmission value="${master.admission }"/>
	            </sec:authorize>
	   
	            
	            <!-- 멤버일경우  -->
	               
	            <sec:authorize access="hasRole('MEMBER')">
	           	 <input type="text" name=memName value="${member.memName }"/>
	           	 <input type="text" name=memNickName value="${member.memNickName }"/>
	          	 <input type="text" name=comCode value="${member.comCode }"/>
	          	 <input type="text" name=memPhone value="${member.memPhone }"/>
	          	 <input type="text" name=signdate value="${member.signdate }"/>
	          	 <input type="text" name=admission value="${member.admission }"/>
	            </sec:authorize>
			</form>
        
      </div>
      <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
        반가워요
        </div>
      <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
        잘있어요
        </div>
      <div class="tab-pane fade" id="v-pills-settings1" role="tabpanel" aria-labelledby="v-pills-settings-tab">
        저는 이만 갑니다
      </div>
      <div class="tab-pane fade" id="v-pills-settings2" role="tabpanel" aria-labelledby="v-pills-settings-tab">
        모두들안녕..
      </div>
    </div>
  </div>
</div>   
</div>
<%@ include file="template/footer.jspf" %>