<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>MEMBER : BOARD</title>
<%@ include file="../template/memberPageHeader.jspf" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>

// 가맹점 코드

// 결제 실행 함수
function requestPay() {
	
	IMP.init('imp14656270');
	IMP.request_pay({
	    pg : 'kakao',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(), // 주문번호
	    /*
	    주문 정보를 전달하고 서버가 생성한 주문 번호를 merchant_uid속성에 지정
	    결제 완료 후 결제 위변조 여부를 검증하는 단계에서 신뢰도있는 검증을 위해
	    서버에서 주문정보를 조회해야 하기 때문
	    */
	    name : '주문명:결제테스트',
	    amount : '100', //판매 가격
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    m_redirece_url : ''
	}, function(rsp) {
	    if ( rsp.success ) {
	    	alert("결제 성공");
//	        $.ajax({
//	        	url : "",
//	        	method : "POST",
//	        	headers : { "Content-Type": "application/json" },
//	        	data : {
//	        		imp_uid: rsp.imp_uid,
//	                merchant_uid: rsp.merchant_uid
//	        	}
//	        }).done(function (data) {
//				// 가맹점 서버 결제 API 성공시 로직
//			})
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
	
}

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
						<button id = "applyPay" onclick = "requestPay()" type="button" class="btn btn-default">결제하기</button>
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