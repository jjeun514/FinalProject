<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/navbar.jspf" %>
<title>입주문의</title>
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
			document.getElementById('modalText01').textContent='필수 항목을 모두 입력해주세요.';
			$('#dangerModal').modal('show');
			return false;
		} else{
			$('#submitApplication').attr('disabled',true);
			$("#yourName").attr('disabled',true);
			$("#yourCompany").attr('disabled',true);
			$("#yourPhone").attr('disabled',true);
			$("#yourEmail").attr('disabled',true);
			$("#yourCrew").attr('disabled',true);
			$("#yourBudget").attr('disabled',true);
			$("#yourMessage").attr('disabled',true);
			document.getElementById('modalText01').textContent='처리중입니다. 잠시만 기다려주세요.';
			$(document.body).css('pointer-events', 'none');
			$('.closeDangerModal').html('<img src="imgs/Hourglass.gif" style="height:50px">');
			$('.closeDangerModal').css('background-color','white').attr('disabled', true).css('height','70px').css('border','0');
			$('#dangerModal').css('color','red');
			$('#dangerModal').modal('show');
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
				success: function(){
					$('#submitApplication').attr('disabled',false);
					$('#dangerModal').modal('hide');
					document.getElementById('modalText02').textContent='상담 신청을 해주셔서 감사합니다. 곧 연락드리겠습니다.';
					$('#primaryModal').modal('show');
					$('#primaryModal').on('hidden.bs.modal',function(){
						location.reload();
					});
				},
				error: function(){
					document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
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
				<td>${priceList.floor}</td>
				<td>${priceList.officeName}</td>
				<td>${priceList.acreages}평</td>
				<td>${priceList.rent}원</td>
				<td>${priceList.max}명</td>
			<c:if test="${priceList.occupancy eq 1 }">
				<td>불가능</td>
			</c:if>
			<c:if test="${priceList.occupancy eq 0 }">
				<td>가능</td>
			</c:if>
		    </tr>
	    </c:forEach>
		</tbody>
	</table>

	<%//층별 이미지 %>	
	<div class="container t1" >
		<div class="box_t1">
			<img src="imgs/photo-1587702068694-a909ef4aa346.jpg">
			<span>1F</span>
		</div>

		<div class="box_t1">
			<img src="imgs/photo-1497366216548-37526070297c.jpg">
			<span>2F</span>
		</div>
	  
		<div class="box_t1">
			<img src="imgs/photo-1531973576160-7125cd663d86.jpg">
			<span>3F</span>
		  </div>
		  
		<div class="box_t1">
			<img src="imgs/photo-1497366412874-3415097a27e7.jpg">
			<span>4F</span>
		</div>
	</div>

	<%//입주 상담 신청서 %>
	<div id="application">
	<h1> 입주 상담 신청서 </h1>
	<p id="requiredP"> [필수*] 항목을 모두 입력해주세요. </p>
	<div class="form-row">
		<div class="form-group col-md-2">
			<label for="yourName" style="color:red">이름*</label>
	    </div>
	    <div class="form-group col-md-3">
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
	    <div class="form-group col-md-3">
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
	    <div class="form-group col-md-3">
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
	    <div class="form-group col-md-9">
			<textarea rows="10" cols="80" name="content" class="form-control" id="yourMessage"></textarea>
	    </div>
	  </div>

	  <button type="submit" class="btn btn-primary" id="submitApplication">상담 신청</button>
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