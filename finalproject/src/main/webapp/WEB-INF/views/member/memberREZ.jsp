<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <title>MEMBER : RESERVATION</title>
<%@ include file="../template/memberPageHeader.jspf" %>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="/webjars/bootstrap/4.6.0-1/css/bootstrap.min.css" rel="stylesheet">
<script src="/webjars/bootstrap/4.6.0-1/js/bootstrap.min.js"></script>

 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <link rel="stylesheet" href="/resources/demos/style.css">
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>

$(document).ready(function() {
	
	 // 사용 예약 버튼을 눌렀을 때 발생하는 이벤트
	$('#REZbtn').click(function() {
		roomInfo(); // 예약 신청 모달에 회의실 관련 정보를 불러오는 함수 
		$("#REZModal").modal();
	});
	
	// 예약 신청 버튼을 눌렀을 때 발생하는 이벤트
	$('#REZapplyClick').click(function() { 
		console.log("예약 신청 버튼");

		// 서버에 전달할 회의실 예약 신청 내용 데이터 셋팅
		// 여기서 예약자 전달해줘야 함
		var applyContent = {
			roomNum : $("#roomNum").val(),
			useStartTime : $("#useStartTime").val(),
			useFinishTime : $("#useFinishTime").val(),
			userCount : $("#userCount").val(),
			reservationDay : $('#reservationDay').val()
		};
	
		$.ajax({
			url : "/reservation/applySubmit",
			type : "POST",
			data : applyContent,
			success : function(data) {
				// 예약 신청 완료 
				if ( data.resultCode == 0 ) { 
					if ( !confirm(data.resultMessage) ){
						// 여기서 신청한 쿼리 롤백해야 하는데 ...
						
						
						
						
						
						
					} else { // 결제 창으로 이동
						location.href = '/reservation/payment';
					}
				// 예약 신청 실패
				} else if ( data.resultCode == 1 ) { 
					alert(data.resultMessage);
				// 중복된 예약 존재로 인해 신청 실패
				} else if ( data.resultCode == -1 ) { 
					alert(data.resultMessage);
				}
			},
			error : function() { 
				alert("회의실 예약 신청 요청이 정상적으로 처리되지 않았습니다. 다시 시도해주세요.");
			}
		});
	});
	
	// 회의실 예약 확인 버튼을 눌렀을 때 발생하는 이벤트
	$('#checkbtn').click(function() {
		myREZ(); // 나의 예약 현황을 불러오는 함수
		$("#cancleModal").modal();
	});
	
	// 회의실 예약 취소 버튼을 눌렀을 때 발생하는 이벤트
	$('#applyCancleREZ').click(function() {
		
		var cancleContent = { myREZ : $('#myREZList').val() };
		
		$.ajax({
			url : "/reservation/cancleReservation",
			type : "POST",
			data : cancleContent,
			dataType : "json",
			success : function(data) { 
				// 예약 취소 성공
				if ( data.resultCode == 1 ) { 
					alert(data.resultMessage);
				// 예약 취소 실패
				} else if ( data.resultCode == 0 ) { 
					alert(data.resultMessage);
				}
			},
			error : function() { alert("회의실 취소 요청이 정상적으로 수행되지 않았습니다. 다시 시도해주세요."); }
		});
	});
});

//예약 신청 모달에서 보여줄 회의실 정보
function roomInfo() { 
	
	var day = $('#reservationDay').val();
	
	$.ajax({
		url : "/reservation/apply",
		type : "GET",
		data : null,
		dataType : "json",
		success : function(data) { 
			$('#roomNum *').remove();
			$('#day *').remove();
			$('#day').append("<p style=\"font:bold;\">신청하신 예약일 : "+day+"</p>");
			$('#roomNum').append("<option>선택해주세요</option>");
			for (var no = 0; no < data.roomData.length; no++ ) {
				$('#roomNum').append("<option value = "+data.roomData[no].roomNum+">"+data.roomData[no].roomNum+"</option>");
			}
		},
		error : function() { alert("예약이 가능한 회의실 정보를 불러오지 못했습니다. 다시 시도해주세요."); }
	});
}

// 나의 회의실 예약 내역 정보
function myREZ() {
	$.ajax({
		url : "/reservation/myReservationList",
		type : "GET",
		dataType : "json",
		success : function(data) {
			$('#myREZList *').remove(); 
			for ( var no = 0; no < data.myList.length; no++ ){
				$('#myREZList').append("<option value = "+data.myList[no].roomNum+"/"+data.myList[no].reservationDay+"/"+data.myList[no].useStartTime+">"+data.myList[no].roomNum+" | "+data.myList[no].reservationDay+" | "+data.myList[no].useStartTime+"시</option>");
			}
		},
		error : function () { alert("나의 회의실 예약 정보를 불러오지 못했습니다. 다시 시도해주세요."); }
	});
}

// 달력 불러오는 함수
$( function() {
	
	var branchCode = 1;
	
    $( "#reservationDay" ).datepicker({
    	dateFormat : 'yy-mm-dd',
    	daysOfWeekDisabled : [0,6], // 이거 왜 안 먹지..?
    	immediateUpdates: true,
    	todayHighlight : true,
    	
    	// 달력의 날자가 바뀌었을 때 해당 날자의 예약 현황 불러오기
    	onSelect : function(dateText, inst) {
			$.ajax({
				url : "/reservation/reservationList",
				type : "GET",
				data : {
					branchCode : branchCode,
					dateText : dateText
				},
				dataType : "json",
				success : function(data) {
					for ( no = 0; no < data.allList.length; no++ ){
						var item = data.allList[no];
						item.시작시간 = "10";
						var 중간시간 = "11";
						//if(종료시간 - 시작시간 > 1) {중간시간}
						
						//2시간 예약인 경우
						//시작시간 칠하기
						$("#"+item.roomNum+"_"+item.시작시간)[0].style = "background-color:rgba(187,240,237,1)";
						//중간시간 있으면
						$("#"+item.roomNum+"_"+중간시간)[0].style = "background-color:rgba(187,240,237,1)";
						
						//종료시간 - 시작시간 > 1 => 예약 2시간   시작시간, 중간시간(시작시간+1), 종료시간
						
						//$("#"+data.allList[no].roomNum+"_09")[0].style = "background-color:rgba(187,240,237,1)";
						
						//$('#reservationListTable').append("<p>"+data.allList[no].roomNum+" | "+data.allList[no].memNum+"</p>");
						// 여기서 해당 시간에 해당 예약 내역을 꽂아줘야 하는데 ....
					}
				},
				error : function () { alert("회의실 예약 현황을 불러오지 못했습니다. 다시 시도해주세요."); }
			});
		}
    })
  } );

</script>
<body>
	<div class = "content bbs">
		<div class = "container">
			<div class = "row">
			<div id = "reservationDate" class = "com-md-12">
				<input type = "text" id="reservationDay" class="form-control" value="">
			</div>
				<div class = "col-md-12">
					<table id = "reservationListTable" class = "table table-bordered">
						<thead>
							<tr>
								<th></th>
								<c:forEach var = "time" begin = "09" end = "22">
								<th id = "REZTimeCell"><c:out value = "${time }"/>시</th>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
							<c:forEach var = "list" items = "${roomList }">
								<tr>
									<td id = "roomCell">${list.roomNum }</td>
									<td id ="${list.roomNum }_09">여</td>
									<td id ="${list.roomNum }_10">기</td>
									<td id ="${list.roomNum }_11">에</td>
									<td id ="${list.roomNum }_12">값</td>
									<td>을</td>
									<td>뿌</td>
									<td>려</td>
									<td>야</td>
									<td>하</td>
									<td>는</td>
									<td>데</td>
									<td>어</td>
									<td>쩌</td>
									<td>지</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div>
						<button id = "REZbtn" type="button" class="btn btn-default">사용예약</button>
						<button id = "checkbtn" type="button" class="btn btn-default">예약취소</button>
						
							<!-- 예약 신청 모달 -->
							<div class="modal fade" id = "REZModal" tabindex="-1" role="dialog">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h4 class="modal-title">회의실 예약 신청</h4>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							      </div>
							      <!-- 회의실 예약 정보 입력란 -->
							      <div class="modal-body">

							        	<form id = "REZApply" class="form-horizontal">
							        	
							        	  <div class="form-group">
							        		<label id = "day" class="col-sm-12 control-label"></label>
							        	  </div>
							        	  
										  <div class="form-group">
										    <label class="col-sm-10 control-label">예약하실 회의실을 선택해주세요</label>
										    <div class="col-sm-12">
											    <select id = "roomNum" class="form-control">
												</select>
											</div>
										  </div>
										  
										  <div class="form-group">
										    <label class="col-sm-10 control-label">예약하실 시작 시간을 선택해주세요</label>
										    <div class="col-sm-12">
											    <select id = "useStartTime" class="form-control">
											    	<option>선택해주세요</option>
												    <c:forEach var = "t" begin = "09" end = "22">
													  <option value = "${t }">${t }시</option>
													</c:forEach>
												</select>
											</div>
										  </div>
										  
										  <div class="form-group">
										    <label class="col-sm-10 control-label">사용하실 시간을 선택해주세요</label>
										    <div class="col-sm-12">
											    <select id = "useFinishTime" class="form-control">
											      <option>선택해주세요</option>
												  <option value = "1">1시간</option>
												  <option value = "2">2시간</option>
												  <!-- 여기서 쿼리를 고려해서 value를 어떻게 줄 지 생각해봐야 함 -->
												</select>
											</div>
										  </div>
										  
										  <div class="form-group">
										    <label class="col-sm-10 control-label">사용하실 인원을 선택해주세요</label>
										    <div class="col-sm-12">
											    <select id = "useCount" class="form-control">
											    <option>선택해주세요</option>
											    	<c:forEach var = "user" begin = "1" end = "5">
													  <option value = "${user }">${user }명</option>
											    	</c:forEach>
												</select>
											</div>
										  </div>
										  
										</form>
							        
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-default" data-dismiss="modal">뒤로가기</button>
							        <button type="button" class="btn btn-default" id = "REZapplyClick">예약 신청</button>
							      </div>
							    </div><!-- /.modal-content -->
							  </div><!-- /.modal-dialog -->
							</div><!-- /.modal -->
							
							<!-- 예약 취소 모달 -->
							<div class="modal fade" id = "cancleModal" tabindex="-1" role="dialog">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h4 class="modal-title">회의실 예약 취소</h4>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							      </div>
							      <!-- 회의실 취소 입력란 -->
							      <div class="modal-body">

							        	<form id = "cancleREZ" class="form-horizontal">
										  <div class="form-group">
										    <label class="col-sm-10 control-label">취소하실 예약 내역을 선택해주세요</label>
										    <div class="col-sm-12">
											    <select id = "myREZList" class="form-control">
												</select>
											</div>
										  </div>
										  
										</form>
							        
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-default" data-dismiss="modal">뒤로가기</button>
							        <button type="button" class="btn btn-default" id = "applyCancleREZ">예약 취소</button>
							      </div>
							    </div><!-- /.modal-content -->
							  </div><!-- /.modal-dialog -->
							</div><!-- /.modal -->
					</div>
				</div>
			</div>
			<p></p>
			<p>* 회의실 예약은 최대 2시간까지 가능합니다.</p>
			<p>* 회의실 예약은 결제가 완료되어야 확정됩니다.</p>
			<p>* 문의 : 112</p>
		</div>
	</div>
</body>
<!--body end-->
<%@ include file="../template/footer.jspf" %>
</html>



<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->