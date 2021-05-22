<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<title>마스터계정관리</title>
<script type="text/javascript">
$('.homeLink').attr('class','nav-link homeLink');
$('.spaceMgmtLink').attr('class','nav-link spaceMgmtLink');
$('.companyMgmtLink').attr('class','nav-link companyMgmtLink');
$('.masterMgmtLink').attr('class','nav-link masterMgmtLink active');
$('.meetingRoomMgmtLink').attr('class','nav-link meetingRoomMgmtLink');

// 페이징
// 10,20,30개씩 selectBox 클릭 이벤트
function changeSelectBox(currentPage, countPerPage, pageSize){
    var selectValue = $("#cntSelectBox").children("option:selected").val();
    movePage(currentPage, selectValue, pageSize);
}
 
// 페이지 이동
function movePage(currentPage, countPerPage, pageSize){
    var url="/masterMgmt";
    url=url+"?currentPage="+currentPage;
    url=url+"&countPerPage="+countPerPage;
    url=url+"&pageSize="+pageSize;
    location.href=url;
}

// 만들어진 테이블에 페이지 처리
function page(){
	$('.masterMgmtTable').each(function() {
		var pagesu=10;  // 페이지 번호 갯수
		var currentPage=0;
		var numPerPage=10;  // 목록의 수
		var $table=$(this);    
		var pagination=$('.pagingSection');
	
		// length로 원래 리스트의 전체길이구함
		var numRows=$table.find('tbody tr').length;
		
		// Math.ceil를 이용하여 반올림
		var numPages=Math.ceil(numRows/numPerPage);
		
		// 리스트가 없으면 종료
		if (numPages==0) return;
		
		// pager라는 클래스의 div엘리먼트 작성
		var $pager=$('<div class="pager"></div>');
		var nowp=currentPage;
		var endp=nowp+10;
		
		// 페이지를 클릭하면 다시 셋팅
		$table.bind('repaginate', function() {
			// 기본적으로 모두 hide하고, (현재페이지+1)*(현재페이지)까지 보여준다
			$table.find('tbody tr').hide().slice(currentPage*numPerPage, (currentPage+1)*numPerPage).show();
			$('.pagingSection').html('');
			if (numPages>1) {     // 한페이지 이상이면
				if (currentPage < 5 && numPages-currentPage >= 5) {   // 현재 5p 이하이면
					nowp = 0;     // 1부터 
					endp = pagesu;    // 10까지
				} else {
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
			} else {       // 한페이지 이하이면
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
				$($('.pageNum')[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
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
	page();
});

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
			$('.pencil').attr('hidden', false);
			$('.masterAccountTitle').html('['+comName+']의 계정 <font style="color:red;">수정</font>');
			$('.valueSetting').attr('readonly', false);
			$('#comCode, #comName, #joinedAt, #masterAccount').css('background-color', 'rgba(230, 230, 230, 0.4)').css('color', 'darkgray');
			$('.closeBtn').attr('class', 'btn btn-secondary cancleBtn').attr('data-dismiss','none').html('취소');
			$('.editBtn').attr('class', 'btn btn-primary okBtn').html('확인');
			
			$(document).on('click','.okBtn', function(e){
				e.stopImmediatePropagation();
				$('input').change(function(e){
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
							document.getElementById('modalText02').textContent='수정이 완료되었습니다.';
							$('#primaryModal').modal('show');
							$('#primaryModal').on('hidden.bs.modal',function(){
								location.reload();
							});
							$.cssBack();
						},
						error: function() {
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
		$.ajax({
			url: "/deleteMaster",
			type: "POST",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data: {
				id:$('#masterAccount').text(),
				comCode:$('#comCode').text()
			},
			success: function() {
				document.getElementById('modalText02').textContent='삭제가 완료되었습니다.';
				$('#primaryModal').modal('show');
				$('#primaryModal').on('hidden.bs.modal',function(){
					location.reload();
				});
				$.cssBack();
			},
			error: function() {
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
		$('.pencil').attr('hidden', true);
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
	<div class="masterMgmtPaging">
		<div class="pagingSection">page</div>
	</div>
	
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
							<td id="ceo"><img src="imgs/pencil.png" class="pencil" hidden><input type="text" name="ceoValue" id="ceoValue" class="valueSetting" readonly></td>
							<th>대표변호</th>
							<td id="comPhone"><img src="imgs/pencil.png" class="pencil" hidden><input type="text" name="comPhoneValue" id="comPhoneValue" class="valueSetting" readonly></td>
						</tr>
						<tr>
							<th>담당자</th>
							<td id="manager"><img src="imgs/pencil.png" class="pencil" hidden><input type="text" name="managerValue" id="managerValue" class="valueSetting" readonly></td>
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