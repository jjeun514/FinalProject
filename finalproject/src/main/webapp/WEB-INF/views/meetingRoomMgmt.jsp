<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<title>회의실관리</title>
<script type="text/javascript">
$('.homeLink').attr('class','nav-link homeLink');
$('.spaceMgmtLink').attr('class','nav-link spaceMgmtLink');
$('.companyMgmtLink').attr('class','nav-link companyMgmtLink');
$('.masterMgmtLink').attr('class','nav-link masterMgmtLink');
$('.meetingRoomMgmtLink').attr('class','nav-link meetingRoomMgmtLink active');
//10,20,30개씩 selectBox 클릭 이벤트
function changeSelectBox(currentPage, countPerPage, pageSize){
    var selectValue = $("#cntSelectBox").children("option:selected").val();
    movePage(currentPage, selectValue, pageSize);
}
 
//페이지 이동
function movePage(currentPage, countPerPage, pageSize){
    
    var url = "/mypage";
    url = url + "?currentPage="+currentPage;
    url = url + "&countPerPage="+countPerPage;
    url = url + "&pageSize="+pageSize;
    
    location.href=url;
}


//만들어진 테이블에 페이지 처리

function page(table){ 
$('.'+table).each(function() {

var pagesu = 10;  //페이지 번호 갯수

var currentPage = 0;

var numPerPage = 10;  //목록의 수

var $table = $(this);    

var pagination = $("#pagination");


//length로 원래 리스트의 전체길이구함

var numRows = $table.find('tbody tr').length;


//Math.ceil를 이용하여 반올림

var numPages = Math.ceil(numRows / numPerPage);


//리스트가 없으면 종료

if (numPages==0) return;



//pager라는 클래스의 div엘리먼트 작성

var $pager = $('<div class="pager"></div>');

var nowp = currentPage;

var endp = nowp+10;


//페이지를 클릭하면 다시 셋팅

$table.bind('repaginate', function() {

//기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다

$table.find('tbody tr').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();

$("#pagination").html("");



if (numPages > 1) {     // 한페이지 이상이면

if (currentPage < 5 && numPages-currentPage >= 5) {   // 현재 5p 이하이면

nowp = 0;     // 1부터 

endp = pagesu;    // 10까지

}else{

nowp = currentPage -5;  // 6넘어가면 2부터 찍고

endp = nowp+pagesu;   // 10까지

pi = 1;

}

if (numPages < endp) {   // 10페이지가 안되면

endp = numPages;   // 마지막페이지를 갯수 만큼

nowp = numPages-pagesu;  // 시작페이지를   갯수 -10

}

if (nowp < 1) {     // 시작이 음수 or 0 이면

nowp = 0;     // 1페이지부터 시작

}

}else{       // 한페이지 이하이면

nowp = 0;      // 한번만 페이징 생성

endp = numPages;

}


// [처음]

$('<span class="pageNum first"><<</span>').bind('click', {newPage: page},function(event) {

currentPage = 0;   

$table.trigger('repaginate');  

$($(".pageNum")[2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');



// [이전]

$('<span class="pageNum back">&nbsp;<&nbsp;</span>').bind('click', {newPage: page},function(event) {

if(currentPage == 0) return; 


currentPage = currentPage-1;

$table.trigger('repaginate'); 

$($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');


// [1,2,3,4,5,6,7,8]

for (var page = nowp ; page < endp; page++) {

$('<span  style="cursor:pointer" class="pageNum"></span>').text(page + 1).append('&nbsp;').bind('click', {newPage: page}, function(event) {

currentPage = event.data['newPage'];

$table.trigger('repaginate');

$($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');

} 



// [다음]

$('<span class="pageNum next">>&nbsp;</span>').bind('click', {newPage: page},function(event) {

if(currentPage == numPages-1) return;


currentPage = currentPage+1;

$table.trigger('repaginate'); 

$($(".pageNum")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');


// [끝]

$('<span class="pageNum last">>></span>').bind('click', {newPage: page},function(event) {

currentPage = numPages-1;

$table.trigger('repaginate');

$($(".pageNum")[endp-nowp+1]).addClass('active').siblings().removeClass('active');

}).appendTo(pagination).addClass('clickable');


$($(".pageNum")[2]).addClass('active');

});


$pager.insertAfter($table).find('span.pageNum:first').next().next().addClass('active');   

$pager.appendTo(pagination);

$table.trigger('repaginate');

});

}



$(function(){
var revList = $("<div class='content main revervationManage'>").append($(".meetingRoomManage").html());
var mrList = $("<div class='content main meetingRoomManage'>").append($(".meetingRoomManage").html());
var mrModal = $(".mrModal").html();
//각 tr 클릭시마다 데이터 저장
var reservationDay;
var memNickName;
var useStartTime;

//$('.revervationManage').hide();

// table pagination

page('paginatedRev');

$(".meetingRoomManage").remove();
$(".mrModal").remove();


//예약 tr 클릭시 셀렉트 
$('.revTrClick').click(function(){
	reservationDay = $(this).find(".trReservationDay").text();
	memNickName = $(this).find(".trMemNickName").text();
	useStartTime = reservationDay+ " " +$(this).find(".trUseStartTime").text()+ ":00.0";
	
	var selectRev = {
			reservationDay : reservationDay,
			memNickName : memNickName,
			useStartTime : useStartTime
		};
	
	//
	$.ajax({
		url: "/selectRevOne",
		type : "POST",
		data: selectRev,
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		success: function(data){
					$("#memName").text(data.memName);
					$("#id").text(data.id);
					$("#roomNumValue").val(data.roomNum+"호");
					$("#reservationDayValue").val(data.reservationDay);
					$("#useStartTimValue").val(data.useStartTime);
					$("#useFinishTimeValue").val(data.useFinishTime);
					$("#userCountValue").val(data.userCount+"명");
					$("#feeValue").val(data.fee);
					$("#comCode").text(data.comCode);
					$("#comName").text(data.comName);
					$("#ceo").text(data.ceo);
					$("#manager").text(data.manager);
					$("#comPhone").text(data.comPhone);
					$("#dept").text(data.dept);
					$("#memPhone").text(data.memPhone);
					$("#merchant_uid").text(data.merchant_uid);
				},			 
		error: function(error){
			document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
			$('#dangerModal').modal('show');
		}
		
	});
		
	
});

$('.mgmtModal').find('.editBtn').click(function(){
	//수정 버튼 클릭 이벤트
	$(document).on('click','.editBtn', function(){
		$('.valueSetting').attr('readonly', false);
		$('.pencil').attr('hidden', false);
		
		$("#memName").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
		$("#id").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
		$("#comCode").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
		$("#comName").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
		$("#ceo").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
		$("#manager").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
		$("#comPhone").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
		$("#dept").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
		$("#memPhone").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
		$("#merchant_uid").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
		
		$('.closeBtn').attr('class', 'btn btn-secondary cancleBtn').attr('data-dismiss','none').html('취소').click(function(){
				window.location.reload();
		});
		$('.editBtn').attr('class', 'btn btn-primary okBtn').html('확인');
		
		$(document).on('click','.okBtn', function(){
			var updateRoomNum = $("#roomNumValue").val().replace("호","");
			var updateReservationDay = $("#reservationDayValue").val();
			var updateUseStartTimValue = updateReservationDay + " " + $("#useStartTimValue").val() + ":00";
			var updateUseFinishTimeValue = updateReservationDay + " " + $("#useFinishTimeValue").val() + ":00";
			var updateUserCountValue = $("#userCountValue").val().replace("명","");
			var updateFeeValue = $("#feeValue").val();
				$.ajax({
					url: "/updateReservation",
					type: "PUT",
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					data: {reservationDay, memNickName, useStartTime,
						   updateRoomNum,updateReservationDay,updateUseStartTimValue,
						   updateUseFinishTimeValue,updateUserCountValue,updateFeeValue
					},
					dataType: "text",
					success: function(data) {
						if(data=="updated"){
							$('#primaryModal').find('#closeBtn').click(function(){
								window.location.reload();
							});
							document.getElementById('modalText02').textContent='수정이 완료되었습니다.';
							$('#primaryModal').modal('show');
							
							
						}else{
							document.getElementById('modalText01').textContent='잘못된 요청이거나 수정된 내용이 없습니다.';
							$('#dangerModal').modal('show');
						}
						$.cssBack(); 
					},
					error: function(error) {
						document.getElementById('modalText01').textContent='중복된 예약시간이 존재하지 않는지 확인하시기 바랍니다.';
						$('#dangerModal').modal('show');
					}
				});
			$.cssBack();
		});
	});
});


$('.mgmtModal').find('.deleteBtn').click(function(){
	var roomNum=$("#roomNumValue").val().replace("호","");
	$.ajax({
		url: "/deleteReservation",
		type: "delete",
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		data: {roomNum,reservationDay, useStartTime},
		dataType: "text",
		success: function(data) {
			if(data=="deleted"){
				$('#primaryModal').find('#closeBtn').click(function(){
					window.location.reload();
				});
				document.getElementById('modalText02').textContent='삭제가 완료되었습니다.';
				$('#primaryModal').modal('show');
			}else{
				document.getElementById('modalText01').textContent='잘못된 요청이거나 수정된 내용이 없습니다.';
				$('#dangerModal').modal('show');
			}
			$.cssBack(); 
		},
		error: function(error) {
			document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
			$('#dangerModal').modal('show');
		}
	});
});


$(document).on('click', '.cancleBtn', function(){
	$.cssBack();
});

$('#accountDetail').on('hide.bs.modal', function() {
	$.cssBack();
});

$.cssBack=function(){
	$('.valueSetting').attr('readonly', true);
	
	$("#memName").css('background-color', 'transparent').css('color', 'black');
	$("#id").css('background-color', 'transparent').css('color', 'black');
	$("#comCode").css('background-color', 'transparent').css('color', 'black');
	$("#comName").css('background-color', 'transparent').css('color', 'black');
	$("#ceo").css('background-color', 'transparent').css('color', 'black');
	$("#manager").css('background-color', 'transparent').css('color', 'black');
	$("#comPhone").css('background-color', 'transparent').css('color', 'black');
	$("#dept").css('background-color', 'transparent').css('color', 'black');
	$("#memPhone").css('background-color', 'transparent').css('color', 'black');
	$("#merchant_uid").css('background-color', 'transparent').css('color', 'black');
	$("#branchName").css('background-color', 'transparent').css('color', 'black');
	$("#roomNum").css('background-color', 'transparent').css('color', 'black');
	$('.pencil').attr('hidden', true);
	
	
	$('.cancleBtn').attr('class', 'btn btn-secondary closeBtn').attr('data-dismiss','modal').html('목록');
	$('.okBtn').attr('class', 'btn btn-primary editBtn').html('수정');
}


//회의실 관리모드 변경
function mrChange(){
	$(".revervationManage").remove();
	$(".changeContent").append(mrList);
	page('paginatedMr');
}

//예약 관리모드 변경
function revChange(){
	$(".meetingRoomManage").remove();
	$(".changeContent").append(revList);
	page('paginatedRev');
	
}


//모달 폼체인지(회의실 상세정보, 회의실 추가)
var changeMrModal='<tr><th>지점</th><td id="branchName"></td><th>방번호</th><td id="roomNum">'+
				  '</td></tr><tr><th>면적</th><td id="acreages"><img src="imgs/pencil.png" class="pencil" hidden><input type="text" name="acreagesValue" id="acreagesValue" class="valueSetting" readonly></td>'+
				  '<th>비용</th><td id="rent"><img src="imgs/pencil.png" class="pencil" hidden><input type="text" name="rentValue" id="rentValue" class="valueSetting" readonly></td></tr>'+
				  '<tr><th>수용인원</th><td id="max" class="max2" colspan="3"><div id="forImg2"><img src="imgs/pencil.png" class="pencil" hidden></div><input type="text" name="maxValue" id="maxValue" class="valueSetting" readonly></td></tr>';

var changeAddMrModal='<tr><th>지점</th><td id="branchName"><select class="mrselect" name="branchNameValue" ><c:forEach items="${branchList }" var="bean"><option value="${bean.branchCode }" >${bean.branchName }</option></c:forEach></select></td>'
					 +'<th>방번호</th><td id="roomNum"><input type="text" name="roomNumValue" id="roomNumValue" class="valueSetting" placeholder="(방번호 입력)"></td></tr>'
					 +'<tr><th>면적</th><td id="acreages"><input type="text" name="acreagesValue" id="acreagesValue" class="valueSetting" placeholder="(면적 입력)"></td>'
					 +'<th>비용</th><td id="rent"><input type="text" name="rentValue" id="rentValue" class="valueSetting" placeholder="(비용 입력)"></td></tr>'
					 +'<tr><th>수용인원</th><td id="max" colspan="3"><input type="text" name="maxValue" id="maxValue" class="valueSetting" placeholder="(인원 입력)"></td></tr>';

//회의실 관리모드 변경
$('.changeMrManage').click(function(){
	mrChange();
	$('.changeMrManage').off('click');
	$(".changeRevManage").click(function(){
		window.location.reload();
	});
	
	$("#ModalTitle").text("회의실 상세 정보");
	$(".spaceTable").html(changeMrModal);
	
	//셀렉트 
	$('.mrTrClick').click(function(){
		$("#branchName").text($(this).find(".trBranchName").text());
		$("#roomNum").text($(this).find(".trRoomNum").text());
		$("#acreagesValue").val($(this).find(".trAcreages").text());
		$("#rentValue").val($(this).find(".trRent").text());
		$("#maxValue").val($(this).find(".trMax").text());
	});
	
	$('.mgmtModal').find('.editBtn').click(function(){
		//수정 버튼 클릭 이벤트
		$(document).on('click','.editBtn', function(){
			$('.valueSetting').attr('readonly', false);
			
			$('.pencil').attr('hidden', false);
			$("#branchName").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
			$("#roomNum").css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
			
			$('.closeBtn').attr('class', 'btn btn-secondary cancleBtn').attr('data-dismiss','none').html('취소')
			$('.editBtn').attr('class', 'btn btn-primary okBtn').html('확인');
			
			var branchName = $("#branchName").text();
			var roomNum = $("#roomNum").text().replace("호","");
			
			$(document).off('click',".okBtn");
			$(document).on('click','.okBtn', function(){
				var acreagesValue = $("#acreagesValue").val();
				var rentValue = $("#rentValue").val();
				var maxValue = $("#maxValue").val().replace("명","");
					$.ajax({
						url: "/updateMeetingRoom",
						type: "PUT",
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						data: {branchName, roomNum, acreagesValue, rentValue, maxValue},
						dataType: "text",
						success: function(data) {
							if(data=="updated"){
								$('#primaryModal').find('#closeBtn').click(function(){
									window.location.reload();
								});
								document.getElementById('modalText02').textContent='수정이 완료되었습니다.';
								$('#primaryModal').modal('show');
							}else{
								document.getElementById('modalText01').textContent='잘못된 요청이거나 수정된 내용이 없습니다.';
								$('#dangerModal').modal('show');
							}
							$.cssBack(); 
						},
						error: function(error) {
							document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
							$('#dangerModal').modal('show');
						}
					});
				$.cssBack();
			});

		});
	});
	$('.mgmtModal').find('.deleteBtn').off('click');
	$('.mgmtModal').find('.deleteBtn').click(function(){
		var branchName = $("#branchName").text();
		var roomNum = $("#roomNum").text().replace("호","");
		$.ajax({
			url: "/deleteMeetingRoom",
			type: "delete",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data: {roomNum,branchName},
			dataType: "text",
			success: function(data) {
				if(data=="deleted"){
					$('#primaryModal').find('#closeBtn').click(function(){
						window.location.reload();
					});
					document.getElementById('modalText02').textContent='삭제가 완료되었습니다.';
					$('#primaryModal').modal('show');
				}else{
					document.getElementById('modalText01').textContent='잘못된 요청이거나 삭제할 내용이 없습니다.';
					$('#dangerModal').modal('show');
				}
				$.cssBack(); 
			},
			error: function(error) {
				document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
				$('#dangerModal').modal('show');
			}
		});
	});
	
	
	$(".addMasterBtn").click(function(){
		$('.mgmtModal').find('.editBtn').removeClass('editBtn').addClass('addBtn').text("추가");
		$('.mgmtModal').find('.deleteBtn').remove();
		$('.mgmtModal').find('.closeBtn').text("취소").on('click',function(){
			window.location.reload();
		});
		$("#ModalTitle").text("회의실 추가");
		$(".spaceTable").html(changeAddMrModal);
		
		$('.mgmtModal').find('.addBtn').on('click',function(){
			var branchNameValue = $("select[name='branchNameValue']").val();
			var roomNumValue = $('#roomNumValue').val().replace("호","");
			var acreagesValue = $('#acreagesValue').val();
			var rentValue = $('#rentValue').val().replace("원","");
			var maxValue = $('#maxValue').val().replace("명","");
			
			$.ajax({
				url: "/addMeetingRoom",
				type: "post",
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				data: {branchNameValue,roomNumValue,acreagesValue,rentValue,maxValue},
				dataType: "text",
				success: function(data) {
					if(data=="added"){
						$('#primaryModal').find('#closeBtn').click(function(){
							window.location.reload();
						});
						document.getElementById('modalText02').textContent='추가가 완료되었습니다.';
						$('#primaryModal').modal('show');
					}else{
						document.getElementById('modalText01').textContent='잘못된 요청이거나 추가된 내용이 없습니다.';
						$('#dangerModal').modal('show');
					}
					$.cssBack(); 
				},
				error: function(error) {
					document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
			});
			
		});
	});
	
	
});


});
</script>

<title>회의실관리</title>
<div class="changeContent">
<div class="content main revervationManage">
	<button type="button" class="btn btn-dark changeMrManage">회의실 관리 모드</button>
	<h1 class="revervationManageText"> 예약 관리</h1> 
	<table class="table mrMgmtTable paginatedRev">
		<thead class="thead-light">
			<tr>
				<td colspan="12" id="addMasterBtn">
				</td>
			</tr>
			<tr>
				<td colspan="12" id="addMasterBtn">
				</td>
			</tr>
		    <tr>
				<th scope="col">번호</th>
				<th scope="col">예약일</th>
				<th scope="col">예약자</th>
				<th scope="col">아이디</th>
				<th scope="col">회사</th>
				<th scope="col">방번호</th>
				<th scope="col">입실시간</th>
				<th scope="col">퇴실시간</th>
				<th scope="col">사용인원</th>
				<th scope="col">결제금액</th>
				<th scope="col">주문번호</th>
		    </tr>
		</thead>
		<tbody>
			<c:forEach items="${revList }" var="revAllList" varStatus="status">
			<tr id="masterAccounts" data-toggle="modal" data-target="#accountDetail" class="revTrClick">
				<td><a href="#" onclick="return false;">${status.index + 1}</a></td>
				<td class="trReservationDay"><a href="#" onclick="return false;">${revAllList.reservation.reservationDay }</a></td>
				<td class="trMemNickName"><a href="#" onclick="return false;">${revAllList.memberInfo.memNickName }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.memberInfo.id }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.companyInfo.comName }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.reservation.roomNum }호</a></td>
				<td class="trUseStartTime"><a href="#" onclick="return false;">${revAllList.reservation.useStartTime }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.reservation.useFinishTime }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.reservation.userCount }</a></td>
				<td><a href="#" onclick="return false;">${revAllList.reservation.amount }</a></td>
				<c:if test="${revAllList.reservation.merchant_uid == null}">
				<td><a href="#" onclick="return false;">미결제</a></td>
				</c:if>
				<c:if test="${revAllList.reservation.merchant_uid != null}">
				<td><a href="#" onclick="return false;">${revAllList.reservation.merchant_uid }</a></td>
				</c:if>
			</tr>
				</c:forEach>
		</tbody>
	</table>
	<div class="btnContent meetingRoomPaging">
		<div class="pagination" id="pagination">&nbsp;</div>
	</div>
</div>

<div class="content main meetingRoomManage">
	<button type="button" class="btn btn-dark changeRevManage">예약 관리 모드</button>
	<h1 class="mrManageText"> 회의실 관리 </h1>
	<table class="table masterMgmtTable paginatedMr">
		<thead class="thead-light">
			<tr>
				<td colspan="8" id="addMasterBtn">
					<button type="button" class="btn btn-primary addMasterBtn" data-toggle="modal" data-target="#accountDetail">추가</button>
				</td>
			</tr>
		    <tr>
				<th scope="col">번호</th>
				<th scope="col">지점</th>
				<th scope="col">방번호</th>
				<th scope="col">면적</th>
				<th scope="col">비용</th>
				<th scope="col">수용인원</th>
		    </tr>
		</thead>
		<tbody>
			<c:forEach items="${mrList }" var="mrAllList" varStatus="status">
			<tr id="masterAccounts" data-toggle="modal" data-target="#accountDetail" class="mrTrClick">
				<td><a href="#" onclick="return false;">${status.index + 1}</a></td>
				<td><a href="#" onclick="return false;" class="trBranchName">${mrAllList.branch.branchName}</a></td>
				<td><a href="#" onclick="return false;" class="trRoomNum">${mrAllList.meetingRoom.roomNum}호</a></td>
				<td><a href="#" onclick="return false;" class="trAcreages">${mrAllList.meetingRoom.acreages}</a></td>
				<td><a href="#" onclick="return false;" class="trRent">${mrAllList.meetingRoom.rent}</a></td>
				<td><a href="#" onclick="return false;" class="trMax">${mrAllList.meetingRoom.max}명</a></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="btnContent meetingRoomPaging">
		<div class="pagination" id="pagination">&nbsp;</div>
	</div>
</div>
</div>

<%//예약 상세 Modal %>
<div class="modal fade mgmtModal" id="accountDetail" tabindex="-1" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="ModalTitle">예약 상세 정보</h5>
			</div>
			<div class="modal-body">
				<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
					<table class="table spaceTable" >
						<tr>
							<th>예약자</th>
							<td id="memName"></td>
							<th>아이디</th>
							<td id="id"></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td id="memPhone"></td>
							<th>부서</th>
							<td id="dept"></td>
						</tr>
						<tr>
							<th>방번호</th>
							<td id="roomNum"><img src="imgs/pencil.png" class="pencil" hidden><input type="text" name="roomNumValue" id="roomNumValue" class="valueSetting" readonly></td>
							<th>예약일</th>
							<td id="reservationDay"><img src="imgs/pencil.png" class="pencil" hidden><input type="text" name="reservationDayValue" id="reservationDayValue" class="valueSetting" readonly></td>
						</tr>
						<tr>
							<th>입실시간</th>
							<td id="useStartTime"><img src="imgs/pencil.png" class="pencil" hidden><input type="text" name="useStartTimValue" id="useStartTimValue" class="valueSetting" readonly></td>
							<th>퇴실시간</th>
							<td id="useFinishTime"><img src="imgs/pencil.png" class="pencil" hidden><input type="text" name="useFinishTimeValue" id="useFinishTimeValue" class="valueSetting" readonly></td>
						</tr>
						<tr>
							<th>인원</th>
							<td id="userCount"><img src="imgs/pencil.png" class="pencil" hidden><input type="text" name="userCountValue" id="userCountValue" class="valueSetting" readonly></td>
							<th>요금</th>
							<td id="fee"><img src="imgs/pencil.png" class="pencil" hidden><input type="text" name="feeValue" id="feeValue" class="valueSetting" readonly></td>
						</tr>
						<tr>
							<th>회사코드</th>
							<td id="comCode"></td>
							<th>회사명</th>
							<td id="comName"></td>
						</tr>
						<tr>
							<th>대표</th>
							<td id="ceo"></td>
							<th>매니저</th>
							<td id="manager"></td>
						</tr>
						<tr>
							<th>대표번호</th>
							<td id="comPhone"></td>
							<th>주문번호</th>
							<td id="merchant_uid"></td>
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

<%@ include file="template/footer.jspf" %>