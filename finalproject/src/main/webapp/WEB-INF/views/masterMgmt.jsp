<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<title>마스터계정관리</title>
<script type="text/javascript">
$('.spaceMgmtLink').attr('class','nav-link spaceMgmtLink');
$('.companyMgmtLink').attr('class','nav-link companyMgmtLink');
$('.masterMgmtLink').attr('class','nav-link masterMgmtLink active');
$('.meetingRoomMgmtLink').attr('class','nav-link meetingRoomMgmtLink');

$(function(){
	var comName;
	var comCode="";
	$('#accountDetail').on('show.bs.modal', function(event) {
		event.stopImmediatePropagation();
		$('#accountDetail').css('margin-top',$(window).height()/4.5);
		comName=$(event.relatedTarget).data('comname');
		comCode=$(event.relatedTarget).data('comcode');
		var ceoValue=$(event.relatedTarget).data('ceo');
		var comPhoneValue=$(event.relatedTarget).data('comphone');
		var managerValue=$(event.relatedTarget).data('manager');
		var joinedAt=$(event.relatedTarget).data('joinedat');
		var masterAccount=$(event.relatedTarget).data('id');
		console.log(comName+", "+comCode+", "+ceoValue+", "+comPhoneValue+", "+managerValue+", "+joinedAt+", "+masterAccount);
		$('.masterAccountTitle').html('['+comName+']의 계정 정보');
		$('#comCode').html(comCode);
		$('#comName').html(comName);
		$('#ceoValue').val(ceoValue);
		$('#comPhoneValue').val(comPhoneValue);
		$('#managerValue').val(managerValue);
		$('#joinedAt').html(joinedAt);
		$('#masterAccount').html(masterAccount);
		
		$(document).on('click','.editBtn', function(e){
			e.stopImmediatePropagation();
			console.log('수정버튼누름');
			$('.masterAccountTitle').html('['+comName+']의 계정 <font style="color:red;">수정</font>');
			$('.valueSetting').attr('readonly', false);
			$('#comCode, #comName, #joinedAt, #masterAccount').css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
			$('.closeBtn').attr('class', 'btn btn-secondary cancleBtn').attr('data-dismiss','none').html('취소');
			$('.editBtn').attr('class', 'btn btn-primary okBtn').html('확인');
			
			$(document).on('click','.okBtn', function(e){
				e.stopImmediatePropagation();
				console.log('수정>확인버튼 누름');
				$('input').change(function(e){
					e.stopImmediatePropagation();
					console.log('input변경됨');
					$.ajax({
						url: "/updateCompanyInfo",
						type: "POST",
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						data: {
							ceoValue:$('#ceoValue').val(), 
							managerValue:$('#managerValue').val(), 
							comPhoneValue:$('#comPhoneValue').val(),
							comCode:comCode,
							comName:comName
						},
						statusCode: {
							406: function(){
								document.getElementById('modalText01').textContent='해당 대표번호는 이미 사용중입니다.';
								$('#dangerModal').modal('show');
							}
						},
						success: function(data) {
							console.log('수정 완료');
							document.getElementById('modalText02').textContent='수정이 완료되었습니다.';
							$('#primaryModal').modal('show');
							$('#primaryModal').on('hidden.bs.modal',function(){
								location.reload();
							});
							$.cssBack();
						},
						error: function(error) {
							console.log("ajax 에러");
							document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
							$('#dangerModal').modal('show');
						}
					});
				});
				$.cssBack();
			});
		});
	});
	
	$(document).on('click', '.cancleBtn', function(e){
		e.stopImmediatePropagation();
		$.cssBack();
	});
	
	$(document).on('click', '.deleteBtn', function(e){
		e.stopImmediatePropagation();
		console.log('삭제누름');
		console.log('id: '+$('#masterAccount').text()+', comCode: '+$('#comCode').text());
		$.ajax({
			url: "/deleteMaster",
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data: {
				id:$('#masterAccount').text(),
				comCode:$('#comCode').text()
			},
			success: function() {
				console.log('수정 완료');
				document.getElementById('modalText02').textContent='수정이 완료되었습니다.';
				$('#primaryModal').modal('show');
				$('#primaryModal').on('hidden.bs.modal',function(){
					location.reload();
				});
				$.cssBack();
			},
			error: function(error) {
				console.log("ajax 에러");
				document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
				$('#dangerModal').modal('show');
			}
		});
	});
	
	$('#accountDetail').on('hide.bs.modal', function(e) {
		e.stopImmediatePropagation();
		$.cssBack();
	});
	
	$.cssBack=function(){
		$('.masterAccountTitle').html('['+comName+']의 계정 정보');
		$('.valueSetting').attr('readonly', true);
		$('#comCode, #comName, #joinedAt, #masterAccount').css('background-color', 'transparent').css('color', 'black');
		$('.cancleBtn').attr('class', 'btn btn-secondary closeBtn').attr('data-dismiss','modal').html('목록');
		$('.okBtn').attr('class', 'btn btn-primary editBtn').html('수정');
	}
});
</script>

<div class="content main">
	<h1> 마스터계정 관리 </h1>
	<table class="table masterMgmtTable">
		<thead class="thead-light">
			<tr>
				<td colspan="8" id="addMasterBtn">
					<button type="button" class="btn btn-primary addMasterBtn" onclick="location.href='addMasterAccount'">추가</button>
				</td>
			</tr>
		    <tr>
				<th scope="col">회사코드</th>
				<th scope="col">회사명</th>
				<th scope="col">대표</th>
				<th scope="col">담당자</th>
				<th scope="col">대표번호</th>
				<th scope="col">마스터계정</th>
				<th scope="col">가입일</th>
		    </tr>
		</thead>
		<tbody>
		<c:forEach items="${masterList}" var="list">
			<tr id="masterAccounts" data-toggle="modal" data-target="#accountDetail" data-comcode="${list.companyInfo.comCode}" data-comname="${list.companyInfo.comName}" data-ceo="${list.companyInfo.ceo}" data-manager="${list.companyInfo.manager}" data-comphone="${list.companyInfo.comPhone}" data-id="${list.masteraccount.id}" data-joinedat="${list.masteraccount.signdate}">
				<td><a href="#" onclick="return false;">${list.companyInfo.comCode}</a></td>
				<td><a href="#" onclick="return false;">${list.companyInfo.comName}</a></td>
				<td><a href="#" onclick="return false;">${list.companyInfo.ceo}</a></td>
				<td><a href="#" onclick="return false;">${list.companyInfo.manager}</a></td>
				<td><a href="#" onclick="return false;">${list.companyInfo.comPhone}</a></td>
				<td><a href="#" onclick="return false;">${list.masteraccount.id}</a></td>
				<td><a href="#" onclick="return false;">${list.masteraccount.signdate}</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
<%//상세 Modal %>
<div class="modal fade" id="accountDetail" tabindex="-1" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="ModalTitle">마스터계정 상세 정보</h5>
			</div>
			
			<div class="modal-body">
				<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
					<table class="table spaceTable" >
			      		<tr colspan="4"><h3 class="masterAccountTitle"></h3></tr>
						<tr>
							<th>회사코드</th>
							<td id="comCode"></td>
							<th>회사명</th>
							<td id="comName"></td>
						</tr>
						<tr>
							<th>대표</th>
							<td id="ceo"><input type="text" name="ceoValue" id="ceoValue" class="valueSetting" readonly></td>
							<th>대표변호</th>
							<td id="comPhone"><input type="text" name="comPhoneValue" id="comPhoneValue" class="valueSetting" readonly></td>
						</tr>
						<tr>
							<th>담당자</th>
							<td id="manager"><input type="text" name="managerValue" id="managerValue" class="valueSetting" readonly></td>
							<th>가입일</th>
							<td id="joinedAt"></td>
						</tr>
						<tr>
							<th>마스터계정</th>
							<td colspan="3" id="masterAccount"></td>
						</tr>
					</table>
				</div>
			</div>
		
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary closeBtn" data-dismiss="modal">목록</button>
				<button type="button" class="btn btn-primary editBtn">수정</button>
				<button type="button" class="btn btn-danger deleteBtn">삭제</button>
			</div>
		</div>
	</div>
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