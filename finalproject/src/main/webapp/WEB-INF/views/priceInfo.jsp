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
	// 상담 신청 버튼 클릭
	$(document).on('click','#submitApplication',function() {
		if($('#yourName').val()==""||$('#yourCompany').val()==""||$('#yourPhone').val()==""||$('#yourEmail').val()==""||$('#yourCrew').val()==""||$('#yourBudget').val()==""){
			console.log('이름/회사명/연락처/이메일/인원/금액 공백임');
			document.getElementById('modalText01').innerHTML='필수 항목을 모두 입력해주세요.';
			$('#dangerModal').modal('show');
			return false;
		} else{
			$.ajax({
				url: "/priceInfo",
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				data: {
					name:$("#yourName").val(),
					company:$("#yourCompany").val(),
					phone:$("#yourPhone").val(),
					email:$("#yourEmail").val(),
					crew:$("#yourCrew").val(),
					budget:$("#yourBudget").val(),
					msg:$("#yourMessage").val()
				},
				success: function(data){
					console.log('[ajax성공] name: '+name);
					console.log('[ajax성공] company: '+company);
					console.log('[ajax성공] phone: '+phone);
					console.log('[ajax성공] email: '+email);
					console.log('[ajax성공] crew: '+crew);
					console.log('[ajax성공] budget: '+budget);
					console.log('[ajax성공] msg: '+msg);
					document.getElementById('modalText02').innerHTML='상담 신청을 해주셔서 감사합니다. 곧 연락드리겠습니다.';
					$('#primaryModal').modal('show');
				},
				error: function(request, status, error){
					console.log("ajax 에러");
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					document.getElementById('modalText01').innerHTML='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
			})
		}
	});
	
});
</script>
<div class="content main">
<%//최상단 배너 carousel %>
	<div id="carouselIndicators" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselIndicators" data-slide-to="0" class="active"></li>
			<li data-target="#carouselIndicators" data-slide-to="1"></li>
			<li data-target="#carouselIndicators" data-slide-to="2"></li>
			<li data-target="#carouselIndicators" data-slide-to="3"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="imgs/2.jpg" class="d-block w-100">
			</div>
			<div class="carousel-item">
				<img src="imgs/3.jpg" class="d-block w-100">
			</div>
			<div class="carousel-item">
				<img src="imgs/4.jpg" class="d-block w-100">
			</div>
			<div class="carousel-item">
				<img src="imgs/5.jpg" class="d-block w-100">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselIndicators" role="button" data-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="sr-only"></span>
		</a>
		<a class="carousel-control-next" href="#carouselIndicators" role="button" data-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="sr-only"></span>
		</a>
	</div>
	
<%//입주절차 이미지 %>
	<p id="process">
		<img src="imgs/process.png">
	</p>

<%//가격표 %>	
	<h1> 가격 안내 </h1>
	<table class="table priceInfo">
		<thead class="thead-light">
		    <tr>
				<th scope="col">층</th>
				<th scope="col">사무실</th>
				<th scope="col">평수</th>
				<th scope="col">월세</th>
				<th scope="col">인원</th>
				<th scope="col">계약 가능 여부</th>
		    </tr>
		</thead>
		<tbody>
		<c:forEach items="${priceItems }" var="priceList">
		    <tr id="priceData">
				<td><a href="#">${priceList.floor}</a></td>
				<td><a href="#">${priceList.officeNum}</a></td>
				<td><a href="#">${priceList.acreages}평</a></td>
				<td><a href="#">${priceList.rent}원</a></td>
				<td><a href="#">${priceList.max}명</a></td>
			<c:if test="${priceList.occupancy eq 1 }">
				<td><a href="#">불가능</a></td>
			</c:if>
			<c:if test="${priceList.occupancy eq 0 }">
				<td><a href="#">가능</a></td>
			</c:if>
		    </tr>
	    </c:forEach>
		</tbody>
	</table>

<%//층별 이미지 %>	
	<div class="container t1" >
		<div class="box_t1" data-toggle="modal" data-target="#exampleModal-1">
			<img src="https://source.unsplash.com/1000x800">
			<span>1F</span>
		</div>

		<div class="box_t1" data-toggle="modal" data-target="#exampleModal-2">
			<img src="https://source.unsplash.com/1000x802">
			<span>2F</span>
		</div>
	  
		<div class="box_t1" data-toggle="modal" data-target="#exampleModal-3">
			<img src="https://source.unsplash.com/1000x804">
			<span>3F</span>
		  </div>
		  
		<div class="box_t1" data-toggle="modal" data-target="#exampleModal-4">
			<img src="https://source.unsplash.com/1000x806">
			<span>4F</span>
		</div>
	</div>

<%//입주 상담 신청서 %>
	<div id="application">
	<h1> 입주 상담 신청서 </h1>
	<p id="required"> [필수*] 항목을 모두 입력해주세요. </p>
	<form id="formContents">
	  <div class="form-row">
	    <div class="form-group col-md-2">
	      <label for="yourName" style="color:red">이름*</label>
	    </div>
	    <div class="form-group col-md-4">
	      <input type="text" class="form-control" id="yourName">
	    </div>
	    <div class="form-group col-md-2">
	      <label for="yourCompany" style="color:red">회사명*</label>
	    </div>
	    <div class="form-group col-md-4">
	      <input type="text" class="form-control" id="yourCompany">
	    </div>
	  </div>
	  
	  <div class="form-row">
	    <div class="form-group col-md-2">
	      <label for="yourPhone" style="color:red">연락처*</label>
	    </div>
	    <div class="form-group col-md-4">
	      <input type="tel" class="form-control" id="yourPhone">
	    </div>
	    <div class="form-group col-md-2">
	      <label for="yourEmail" style="color:red">이메일*</label>
	    </div>
	    <div class="form-group col-md-4">
	      <input type="email" class="form-control" id="yourEmail">
	    </div>
	  </div>
	  
	  <div class="form-row">
	    <div class="form-group col-md-2">
	      <label for="yourCrew" style="color:red">입주 예정인원*</label>
	    </div>
	    <div class="form-group col-md-4">
	      <input type="number" class="form-control" id="yourCrew">
	    </div>
	    <div class="form-group col-md-2">
	      <label for="yourBudget" style="color:red">희망 금액대*</label>
	    </div>
	    <div class="form-group col-md-4">
	      <input type="text" class="form-control" id="yourBudget">
	    </div>
	  </div>
	  
	  <div class="form-row">
	    <div class="form-group col-md-2">
	      <label for="yourMessage" id="msgLabel">추가 메세지</label>
	    </div>
	    <div class="form-group col-md-10">
		  <textarea rows="10" cols="80" name="content" class="form-control" id="yourMessage"></textarea>
	    </div>
	  </div>

	  <button type="submit" class="btn btn-primary" id="submitApplication">상담 신청</button>
	</form>
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

<%//1층 클릭 시 상세 Modal %>
  <div class="modal fade" id="exampleModal-1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
     <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLabel">Modal-1</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
       <span aria-hidden="true">&times;</span>
      </button>
     </div>
     <div class="modal-body">
      <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
       <ol class="carousel-indicators">
        <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
        <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
       </ol>
       <div class="carousel-inner"><!--모달안에 캐러셀 start-->
        <div class="carousel-item active">
         <img src="imgs/2.jpg" class="d-block w-100">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/3.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/4.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Third slide label</h5>
          <p>Some representative placeholder content for the third slide.</p>
         </div>
        </div>
       </div><!--모달안에 캐러셀 end-->
       
       <table class="table"><!--모달안에 테이블 start-->
          <thead>
           <tr>
            <th scope="col">#</th>
            <th scope="col">First</th>
            <th scope="col">Last</th>
            <th scope="col">Handle</th>
           </tr>
          </thead>
          <tbody>
           <tr>
            <th scope="row">1</th>
            <td>Mark</td>
            <td>Otto</td>
            <td>@mdo</td>
           </tr>
           <tr>
            <th scope="row">2</th>
            <td>Jacob</td>
            <td>Thornton</td>
            <td>@fat</td>
           </tr>
           <tr>
            <th scope="row">3</th>
            <td>Larry</td>
            <td>the Bird</td>
            <td>@twitter</td>
           </tr>
          </tbody>
         </table><!--모달안에 테이블 end-->

       <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
       </a>
       <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
       </a>
      </div>
     </div>
     <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      <button type="button" class="btn btn-primary">Save changes</button>
     </div>
    </div>
   </div>
  </div>

<%//2층 클릭 시 상세 Modal %>  
  <div class="modal fade" id="exampleModal-2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
     <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLabel">Modal-2</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
       <span aria-hidden="true">&times;</span>
      </button>
     </div>
     <div class="modal-body">
      <div id="carouselExampleCaptions-2" class="carousel slide" data-ride="carousel">
       <ol class="carousel-indicators">
        <li data-target="#carouselExampleCaptions-2" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleCaptions-2" data-slide-to="1"></li>
        <li data-target="#carouselExampleCaptions-2" data-slide-to="2"></li>
       </ol>
       <div class="carousel-inner"><!--모달안에 캐러셀 start-->
        <div class="carousel-item active">
         <img src="imgs/2.jpg" class="d-block w-100">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/3.jpg" class="d-block w-100">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/4.jpg" class="d-block w-100">
         <div class="carousel-caption d-none d-md-block">
          <h5>Third slide label</h5>
          <p>Some representative placeholder content for the third slide.</p>
         </div>
        </div>
       </div><!--모달안에 캐러셀 end-->
       
       <table class="table"><!--모달안에 테이블 start-->
          <thead>
           <tr>
            <th scope="col">#</th>
            <th scope="col">First</th>
            <th scope="col">Last</th>
            <th scope="col">Handle</th>
           </tr>
          </thead>
          <tbody>
           <tr>
            <th scope="row">1</th>
            <td>Mark</td>
            <td>Otto</td>
            <td>@mdo</td>
           </tr>
           <tr>
            <th scope="row">2</th>
            <td>Jacob</td>
            <td>Thornton</td>
            <td>@fat</td>
           </tr>
           <tr>
            <th scope="row">3</th>
            <td>Larry</td>
            <td>the Bird</td>
            <td>@twitter</td>
           </tr>
          </tbody>
         </table><!--모달안에 테이블 end-->

       <a class="carousel-control-prev" href="#carouselExampleCaptions-2" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
       </a>

       <a class="carousel-control-next" href="#carouselExampleCaptions-2" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
       </a>
      </div>
     </div>
     <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      <button type="button" class="btn btn-primary">Save changes</button>
     </div>
    </div>
   </div>
  </div><!-- 모달 end--> 
  <!-- 모달-3 start-->
  <div class="modal fade" id="exampleModal-3" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
     <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLabel">Modal-3</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
       <span aria-hidden="true">&times;</span>
      </button>
     </div>
     <div class="modal-body">
      <div id="carouselExampleCaptions-3" class="carousel slide" data-ride="carousel">
       <ol class="carousel-indicators">
        <li data-target="#carouselExampleCaptions-3" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleCaptions-3" data-slide-to="1"></li>
        <li data-target="#carouselExampleCaptions-3" data-slide-to="2"></li>
       </ol>
       <div class="carousel-inner"><!--모달안에 캐러셀 start-->
        <div class="carousel-item active">
         <img src="imgs/2.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/3.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/4.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Third slide label</h5>
          <p>Some representative placeholder content for the third slide.</p>
         </div>
        </div>
       </div><!--모달안에 캐러셀 end-->
       
       <table class="table"><!--모달안에 테이블 start-->
          <thead>
           <tr>
            <th scope="col">#</th>
            <th scope="col">First</th>
            <th scope="col">Last</th>
            <th scope="col">Handle</th>
           </tr>
          </thead>
          <tbody>
           <tr>
            <th scope="row">1</th>
            <td>Mark</td>
            <td>Otto</td>
            <td>@mdo</td>
           </tr>
           <tr>
            <th scope="row">2</th>
            <td>Jacob</td>
            <td>Thornton</td>
            <td>@fat</td>
           </tr>
           <tr>
            <th scope="row">3</th>
            <td>Larry</td>
            <td>the Bird</td>
            <td>@twitter</td>
           </tr>
          </tbody>
         </table><!--모달안에 테이블 end-->

       <a class="carousel-control-prev" href="#carouselExampleCaptions-3" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
       </a>

       <a class="carousel-control-next" href="#carouselExampleCaptions-3" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
       </a>
      </div>
     </div>
     <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      <button type="button" class="btn btn-primary">Save changes</button>
     </div>
    </div>
   </div>
  </div>

<%//4층 클릭 시 상세 Modal %>
  <div class="modal fade" id="exampleModal-4" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
     <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLabel">Modal-4</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
       <span aria-hidden="true">&times;</span>
      </button>
     </div>
     <div class="modal-body">
      <div id="carouselExampleCaptions-4" class="carousel slide" data-ride="carousel">
       <ol class="carousel-indicators">
        <li data-target="#carouselExampleCaptions-4" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleCaptions-4" data-slide-to="1"></li>
        <li data-target="#carouselExampleCaptions-4" data-slide-to="2"></li>
       </ol>
       <div class="carousel-inner"><!--모달안에 캐러셀 start-->
        <div class="carousel-item active">
         <img src="imgs/2.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>First slide label</h5>
          <p>Some representative placeholder content for the first slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/3.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Second slide label</h5>
          <p>Some representative placeholder content for the second slide.</p>
         </div>
        </div>
        <div class="carousel-item">
         <img src="imgs/4.jpg" class="d-block w-100" alt="...">
         <div class="carousel-caption d-none d-md-block">
          <h5>Third slide label</h5>
          <p>Some representative placeholder content for the third slide.</p>
         </div>
        </div>
       </div><!--모달안에 캐러셀 end-->
       
       <table class="table"><!--모달안에 테이블 start-->
          <thead>
           <tr>
            <th scope="col">#</th>
            <th scope="col">First</th>
            <th scope="col">Last</th>
            <th scope="col">Handle</th>
           </tr>
          </thead>
          <tbody>
           <tr>
            <th scope="row">1</th>
            <td>Mark</td>
            <td>Otto</td>
            <td>@mdo</td>
           </tr>
           <tr>
            <th scope="row">2</th>
            <td>Jacob</td>
            <td>Thornton</td>
            <td>@fat</td>
           </tr>
           <tr>
            <th scope="row">3</th>
            <td>Larry</td>
            <td>the Bird</td>
            <td>@twitter</td>
           </tr>
          </tbody>
         </table><!--모달안에 테이블 end-->

       <a class="carousel-control-prev" href="#carouselExampleCaptions-4" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
       </a>

       <a class="carousel-control-next" href="#carouselExampleCaptions-4" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
       </a>
      </div>
     </div>
     <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      <button type="button" class="btn btn-primary">Save changes</button>
     </div>
    </div>
   </div>
  </div>  
<%@ include file="template/footer.jspf" %>