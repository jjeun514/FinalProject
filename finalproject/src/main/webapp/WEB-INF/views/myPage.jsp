<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ include file="./template/header.jspf" %>
<body>
<div class="content mypage"><!--content start-->
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
              
          	<form >
			    <!-- 어드민일경우  -->
	      
	            <sec:authorize access="hasRole('ADMIN')">
		            <p> ${admin.nickName }</p>
		            <p> ${admin.branchCode }</p>
	             	<p> ${admin.profile }</p>
	            </sec:authorize>
	            
	           
	            <!-- 마스터일경우  -->
	       
	            <sec:authorize access="hasRole('MASTER')">
		            <p> ${master.comCode }</p>
		            <p> ${master.signdate }</p>
	             	<p> ${master.profile }</p>
	             	<p> ${master.admission }</p>
	            </sec:authorize>
	   
	            
	            <!-- 멤버일경우  -->
	               
	            <sec:authorize access="hasRole('MEMBER')">
		            <p> ${member.id }</p>
		            <p> ${member.comCode }</p>
	             	<p> ${member.signdate }</p>
	             	<p> ${member.profile }</p>
	             	<p> ${member.admission }</p>
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
</div><!--centent end-->
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