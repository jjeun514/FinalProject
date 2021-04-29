<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>RESERVATION : PAYMENT</title>
<%@ include file="../template/memberPageHeader.jspf" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>

// 가맹점 코드
	IMP.init('imp14656270');
	
$(document).ready(function() {
	$('#applyPay').click(function() { // 결제 버튼 눌렀을 때 실행되는 결제 기능 함수
		IMP.request_pay({
		    pg : 'kakao',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(), // 주문번호
		    name : '주문명:결제테스트',
		    amount : '100', //판매 가격
		    buyer_email : 'dichotomy.bgm@gmail.com',
		    buyer_name : 'LUNA'
		}, function(rsp) {
			console.log(rsp);
			if ( rsp.success ) {
			$.ajax({
				url : "/reservation/payment/" + rsp.imp_uid,
	        	type : "POST",
			}).done(function(data) {
				console.log(data);
				
				// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
	        	if(rsp.paid_amount == data.response.amount){
		        	alert("결제 및 결제검증완료");
	        	} else {
	        		alert("결제 실패");
	        	}
			});
			} else {
				alert("결제 요청이 실패");
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
						<div class="input-group">
						
						
						</div>
					</form>
				</div>
				<div class="col-md-12">
					<h2>결제 내역</h2>
					<table id = "bbsTable" class="table table-bordered">
						
						<tr>
							<td>예약자명</td>
							<td></td>
						</tr>
						
						<tr>
							<td>예약일시</td>
							<td></td>
						</tr>
						
						<tr>
							<td>예약 회의실</td>
							<td></td>
						</tr>
						
						<tr>
							<td>예약시간</td>
							<td></td>
						</tr>
						
						<tr>
							<td>결제금액</td>
							<td></td>
						</tr>
					
					</table>
					<input id = "checkPay" type = "checkbox">
					<label>결제하시겠습니까?</label>
					<div>
						<button id = "applyPay" type="button" class="btn btn-default">결제하기</button>
					</div>
				</div>
			</div>
		</div>
	</div><!--centent end-->
</body><!--body end-->
<%@ include file="../template/footer.jspf" %>
</html>



<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->