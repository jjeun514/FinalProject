<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <title>MEMBER : RESERVATION</title>
<%@ include file="../template/memberPageHeader.jspf" %>
<script>

$(document).ready(function() {
	$('#REZbtn').click(function() {
		$("#myModal").modal();
		roomInfo(); // 예약 신청 모달에 회의실 관련 정보를 불러오는 함수
	});
});

// 이 함수때문에 모달창이 안 띄워짐 ... 모르겠네
function roomInfo() {
	$.ajax({
		url : "/reservation/apply",
		type : "GET",
		data : {
			room : "${roomNum}",
			useStartTime : "${useStartTime}"
		},
		beforeSend : function() {
			alert("요청하신 ajax를 처리 시작했습니다.");
			console.log("ajax 호출");
		},
		success : function(data) { console.log("요청하신 ajax 요청이 성공했습니다."); },
		error : function() { alert("요청하신 ajax 방식이 잘못되었습니다."); }
	});
}
    
</script>
<body>
	<div class = "content bbs">
		<div class = "container">
			<div class = "row">
				<div class = "col-md-12">
					<table class = "table table-bordered">
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
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div>
						<button id = "REZbtn" type="button" class="btn btn-default">사용예약</button>
							<div class="modal fade" id = "myModal" tabindex="-1" role="dialog">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h4 class="modal-title">회의실 예약 신청</h4>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							      </div>
							      <!-- 회의실 예약 정보 입력란 -->
							      <div class="modal-body">

							        	<form class="form-horizontal">
										  <div class="form-group">
										    <label class="col-sm-10 control-label">예약하실 회의실을 선택해주세요</label>
										    <div class="col-sm-12">
											    <select name = "roomNum" class="form-control">
												  <option>회의실 정보 받아와야 함</option>
												</select>
											</div>
										  </div>
										  
										  <div class="form-group">
										    <label class="col-sm-10 control-label">예약하실 시작 시간을 선택해주세요</label>
										    <div class="col-sm-12">
											    <select name = "useStartTime" class="form-control">
												  <option>사용 가능한 시간 받아와야 함</option>
												</select>
											</div>
										  </div>
										  
										  <div class="form-group">
										    <label class="col-sm-10 control-label">사용하실 시간을 선택해주세요</label>
										    <div class="col-sm-12">
											    <select name = "useFinishTime" class="form-control">
												  <option value = "59">1시간</option>
												  <option value = "119">2시간</option>
												</select>
											</div>
										  </div>
										  
										  <div class="form-group">
										    <label class="col-sm-10 control-label">사용하실 인원을 선택해주세요</label>
										    <div class="col-sm-12">
											    <select name = "useCount" class="form-control">
												  <option value = "1">1명</option>
												  <option value = "2">2명</option>
												  <option value = "3">3명</option>
												  <option value = "4">4명</option>
												  <option value = "5">5명</option>
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