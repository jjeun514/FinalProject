<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>RESERVATION : PAYMENT</title>
<%@ include file="template/memberNavBar.jspf" %>
<%@ include file="template/cssForMember.jspf" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>

var csrfToken = $("meta[name='_csrf']").attr("content");
$.ajaxPrefilter(function(options, originalOptions, jqXHR){
   if (options['type'].toLowerCase() === "post" || options['type'].toLowerCase() === "put" || options['type'].toLowerCase() === "delete") {
      jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
   }
});

// 가맹점 코드
IMP.init('imp14656270');
	
$(document).ready(function() {
	
	$('#applyPay').click(function() { // 결제 버튼 눌렀을 때 실행되는 결제 기능 함수
	
		var payContent = {
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : $('#room').text()+' 회의실 예약 결제',				 // 121 회의실 예약 결제
			roomNum : $('#room').text(),							 // 121
			useStartTime : $('#startT').val(),						 // 9
			useFinishTime : $('#time').text().substring(0,1),		 // 1
			reservationDay : $('#REZ').text().substring(0,10),		 // 2021-04-26
			amount : $('#amount').text(),							 // 20000
			memNum : $('#memNum').val(),							 // luna
			userCount : $('#userCount').val(), 						 // 4
			etc : $('#etc').val()			 						 // 메모 테스트
		}

		IMP.request_pay({
		
		    pg : 'kakao',
		    pay_method : 'card',
		    merchant_uid : payContent.merchant_uid,
		    name : payContent.name,
		    amount : payContent.amount
		}, function(rsp) {
			if ( rsp.success ) {
			$.ajax({
				url : "/reservation/payment/" + rsp.imp_uid,
	        	type : "POST"
			}).done(function(data) {
				// 요청 결제 금액과 실제 결제 금액이 같은지 확인
	        	if(rsp.paid_amount == data.response.amount){
	        		
	        		$.ajax({
	        			url : "/reservation/success",
	        			type : "POST",
	        			data : payContent,
	        			dataType : "JSON",
	        			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        			success : function(data) {
							if ( data.resultCode == 0 ) { // 예약 성공
								alert(data.resultMessage);
								location.href = "/reservation" 
							} else if ( data.resultCode == 1 ) { // 예약 실패
								alert(data.resultMessage);
								location.href = "/reservation"
							}
						},
	        			error : function() {
							alert("회의실 예약이 정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.");
							location.href = "/reservation"
						}
	        		});
	        	
	        	} else {
	        		alert("결제하신 금액이 다릅니다. 다시 시도해주세요.");
	        	}
	        	
			});
			} else {
				alert("결제가 실패했습니다. 다시 시도해주세요.");
			}
		});
	});
});

</script>
<body>
	<div class="content bbs"><!--content start-->
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<form action="#" method="get">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
						<div class="input-group">
						
						
						</div>
					</form>
				</div>
				<div class="col-md-12">
					<h2>결제 내역</h2>
					<table id = "bbsTable" class="table table-bordered">
							<tr>
								<td>예약자명</td>
								<td id = "memName">${content.memName}</td>
								<input type="hidden" id = "memNum" name="memNum" value="${content.memNum}"/>
							</tr>
							
							<tr>
								<td>예약일시</td>
								<td id = "REZ">${content.reservationDay } ${content.useStartTime }:00:00</td>
							</tr>
							
							<tr>
								<td>예약 회의실</td>
								<td id = "room">${content.roomNum }</td>
							</tr>
							
							<tr>
								<td>예약시간</td>
								<td id = "time">${content.useFinishTime }시간</td>
							</tr>
							
							<tr>
								<td>결제금액</td>
								<td id = "amount">${content.amount }</td>
							</tr>
							<input id = "startT" value = "${content.useStartTime}" type = "hidden">
							<input id = "userCount" value = "${content.userCount}" type = "hidden">
							<input id = "etc" value = "${content.etc}" type = "hidden">
					
					</table>
					<input id = "checkPay" type = "checkbox">
					<label>결제하시겠습니까?</label>
					<div>
						<button id = "canclePay" type="button" class="btn btn-default" onclick = "location.href = '/reservation';">결제취소</button>
						<button id = "applyPay" type="button" class="btn btn-default">결제하기</button>
					</div>
				</div>
			</div>
		</div>
	</div><!--centent end-->
</body><!--body end-->
<%@ include file="./template/twoDepthFooter.jspf" %>
</html>

