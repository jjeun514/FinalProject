<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <title>MEMBER : RESERVATION</title>
<%@ include file="template/memberNavBar.jspf" %>
<%@ include file="template/cssForMember.jspf" %>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="/webjars/bootstrap/4.6.0-1/css/bootstrap.min.css" rel="stylesheet">
<script src="/webjars/bootstrap/4.6.0-1/js/bootstrap.min.js"></script>

 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>

var csrfToken = $("meta[name='_csrf']").attr("content");
$.ajaxPrefilter(function(options, originalOptions, jqXHR){
   if (options['type'].toLowerCase() === "post" || options['type'].toLowerCase() === "put" || options['type'].toLowerCase() === "delete") {
      jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
   }
});

$(document).ready(function() {
	
	 // 사용 예약 버튼을 눌렀을 때 발생하는 이벤트
	$('#REZbtn').click(function() {
		
		// 날짜를 선택하지 않았을 경우
		if ( $('#reservationDay').val() == "" ) {
			document.getElementById('showAlertForChoice').innerHTML="<b><font color='red'>날짜를 선택해주세요</font><b>";
			return false;
		}
		
		roomInfo(); // 예약 신청 모달에 회의실 관련 정보를 불러오는 함수 
		$("#REZModal").modal();
	});
	
	// 예약 신청 버튼을 눌렀을 때 발생하는 이벤트
	$('#REZapplyClick').click(function() { 

		var roomNum = $("#roomNum").val();
		var useStartTime = $("#useStartTime").val();
		var useFinishTime = $("#useFinishTime").val();
		var userCount = $("#userCount").val();
		var reservationDay = $('#reservationDay').val();
		
//		if ( $("#roomNum").text() == "" ) {
//			alert("회의실을 선택해주세요");
//			return false;
//		}
//		
//		if ( $("#useStartTime").text() == "" ) {
//			alert("시작 시간을 선택해주세요");
//			return false;
//		}
//		
//		if ( $("#useStartTime").text() == "" ) {
//			alert("사용 시간을 선택해주세요");
//			return false;
//		}
//		
//		if ( $("#userCount").text() == "" ) {
//			alert("인원을 선택해주세요");
//			return false;
//		}
		
		// 서버에 전달할 회의실 예약 신청 내용 데이터 셋팅
		// 여기서 예약자 전달해줘야 함
		var applyContent = {
			roomNum : roomNum,
			useStartTime : useStartTime,
			useFinishTime : useFinishTime,
			userCount : userCount,
			reservationDay : reservationDay
		};
		
		$.ajax({
			url : "/reservation/applySubmit",
			type : "POST",
			data : applyContent,
			dataType : "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(data) {
				// 예약 신청 완료 
				if ( data.resultCode == 0 ) { 
					if ( !confirm(data.resultMessage) ){ // 예약신청을 하고 취소를 누르면 다시 예약 페이지로 이동
						location.href = '/reservation';
					} else { // 결제 창으로 이동
						paymentApplyFunction(data);
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
				// 취소하고자 하는 예약 내역이 없음
				} else if ( data.resultCode == -1 ) {
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

// 결제 정보 POST 방식으로 보내는 함수
function paymentApplyFunction2(data) {
	
	var formdata = new FormData();
	
	formdata.append("roomNum", data.room);
	formdata.append("day", data.day);
	formdata.append("useStartTime", data.startT);
	formdata.append("useFinishTime", data.useT);
	formdata.append("userCount", data.userCount);
	formdata.append("amount", data.amount);
	
	/*
	formData는 
	*/
	for (let key of formdata.keys()) { console.log(key); }
	for (let value of formdata.values()) { console.log(value); }
	
	$.ajax({
		url : "/reservation/payment",
		type : "POST",
		dataType : "json",
		processData : false,
		data : JSON.stringify(formdata),
		success : function(data) {
			alert("펑션으로 호출 성공");
		}
	});
}

// 결제 정보 POST 방식으로 보내는 함수
function paymentApplyFunction(data) {
	
	var form = document.createElement('form');
	data["_csrf"] = $("meta[name='_csrf']").attr("content");
	
	for(var key in data) {
		form.appendChild(createInputEle({"key":key,"value":data[key]}));
	}
	
	form.setAttribute('method', 'post');
	form.setAttribute('action', '/reservation/payment');
	form.setAttribute('method', 'post');
	document.body.appendChild(form);
	form.submit();
}

function createInputEle(data) {
	var inputObj = document.createElement('input');
	inputObj.setAttribute('type', 'hidden');
	inputObj.setAttribute('name', data.key);
	inputObj.setAttribute('value', data.value);
	
	return inputObj;
}

// 달력 불러오는 함수
$( function() {
	
	var branchCode = 1;
	
    $( "#reservationDay" ).datepicker({
    	dateFormat : 'yy-mm-dd',
    	immediateUpdates: true,
    	todayHighlight : true,
    	minDate : 0,
    	firstDay : 1,
    	beforeShowDay: noWeekend,
    	
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
					
					$("#content *").css("background-color", "");
					
					for ( no = 0; no < data.allList.length; no++ ){
						
						var list = data.allList[no];
						
						if ( list.memNum == 1 ) {
							if ( list.finishT-list.startT > 1 ) {
								$("#"+list.roomNum+"_"+list.startT).eq(0).css("background-color", "rgba(0,0,0,0.6)");
								$("#"+list.roomNum+"_"+(parseInt(list.startT)+1)).eq(0).css("background-color", "rgba(0,0,0,0.6)");
							} else {
								$("#"+list.roomNum+"_"+list.startT).eq(0).css("background-color", "rgba(0,0,0,0.6)");
							}
						} else if ( list.memNum != 1 ) {
							if ( list.finishT-list.startT > 1 ) {
								$("#"+list.roomNum+"_"+list.startT).eq(0).css("background-color", "rgba(0,0,0,0.2)");
								$("#"+list.roomNum+"_"+(parseInt(list.startT)+1)).eq(0).css("background-color", "rgba(0,0,0,0.2)");
							} else {
								$("#"+list.roomNum+"_"+list.startT).eq(0).css("background-color", "rgba(0,0,0,0.2)");
							}
						}
					}
				},
				error : function () { alert("회의실 예약 현황을 불러오지 못했습니다. 다시 시도해주세요."); }
			});
		}
    })
  } );
  
// 데이트피커 주말 비활성화
function noWeekend(date) { 
	  return [date.getDay() != 0 && date.getDay() != 6]; 
}  

</script>

<script type="text/javascript">

</script>
<body>
	<div class = "content bbs">
		<div class = "container">
			<div class = "row">
			<div id = "reservationDate" class = "com-md-12">
				<input type = "text" id="reservationDay" class="form-control" value="">
			</div>
				<div class = "col-md-12">
				<div id = "showAlertForChoice"></div>
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
								<tr id = "content">
									<td id = "roomCell">${list.roomNum }</td>
									<td id ="${list.roomNum }_09"></td>
									<td id ="${list.roomNum }_10"></td>
									<td id ="${list.roomNum }_11"></td>
									<td id ="${list.roomNum }_12"></td>
									<td id ="${list.roomNum }_13"></td>
									<td id ="${list.roomNum }_14"></td>
									<td id ="${list.roomNum }_15"></td>
									<td id ="${list.roomNum }_16"></td>
									<td id ="${list.roomNum }_17"></td>
									<td id ="${list.roomNum }_18"></td>
									<td id ="${list.roomNum }_19"></td>
									<td id ="${list.roomNum }_20"></td>
									<td id ="${list.roomNum }_21"></td>
									<td id ="${list.roomNum }_22"></td>
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
							        	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
							        	<input type="hidden" name="memNum" value="${member.memNum}"/>
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
<%@ include file="./template/footer.jspf" %>
</html>



<!--
justify-content-center= 가운데 정렬
my-2= 높이주기
mr-3= 너비주기
m-3= 전체적인 간격주기
fixed-top= 위로고정
-->