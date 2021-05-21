<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<title>입주사관리</title>
<script type="text/javascript">
$('.homeLink').attr('class','nav-link homeLink');
$('.spaceMgmtLink').attr('class','nav-link spaceMgmtLink');
$('.companyMgmtLink').attr('class','nav-link companyMgmtLink active');
$('.masterMgmtLink').attr('class','nav-link masterMgmtLink');
$('.meetingRoomMgmtLink').attr('class','nav-link meetingRoomMgmtLink');

//페이징
//10,20,30개씩 selectBox 클릭 이벤트
function changeSelectBox(currentPage, countPerPage, pageSize){
 var selectValue = $("#cntSelectBox").children("option:selected").val();
 movePage(currentPage, selectValue, pageSize);
}

//페이지 이동
function movePage(currentPage, countPerPage, pageSize){
 var url="/tenantsMgmt";
 url=url+"?currentPage="+currentPage;
 url=url+"&countPerPage="+countPerPage;
 url=url+"&pageSize="+pageSize;
 location.href=url;
}

//만들어진 테이블에 페이지 처리
function page(){
	$('.companyMgmtTable').each(function() {
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

$(document).ready(function(){
	$('#detail').on('show.bs.modal', function(event) {
		event.stopImmediatePropagation();
		var comName=$(event.relatedTarget).data('comname');
		var comCode=$(event.relatedTarget).data('comcode');
		var ceo=$(event.relatedTarget).data('ceo');
		var manager=$(event.relatedTarget).data('manager');
		var comPhone=$(event.relatedTarget).data('comphone');
		var branchName=$(event.relatedTarget).data('branchname');
		var floor=$(event.relatedTarget).data('floor');
		var officeName=$(event.relatedTarget).data('officename');
		var contractDate=$(event.relatedTarget).data('contractdate');
		var rentStartDate=$(event.relatedTarget).data('rentstartdate');
		var rentFinishDate=$(event.relatedTarget).data('rentfinishdate');
		var masterAccount=$(event.relatedTarget).data('masteraccount');
		$('.tenantsTitle').html(comName+' 상세 정보');
		$('#comCode').html(comCode);
		$('#ceo').html(ceo);
		$('#manager').html(manager);
		$('#comPhone').html(comPhone);
		$('#masterAccount').html(masterAccount);
		$('.branchName').val(branchName);
		$('#officeName').html(officeName);
		$('.officeName').html('<option>'+officeName+'</option>');
		$('#contractDate').val(contractDate);
		$('#rentStartDate').val(rentStartDate);
		$('#rentEndDate').val(rentFinishDate);
		$('#floor').html(floor);
		$('.floor').html('<option>'+floor+'</option>');
		
		$(document).on('click','.editSpace', function(e){
			e.stopImmediatePropagation();
			$('.pencil').attr('hidden', false);
			$('.spaceTitle').html('입주 공간 정보 수정').css('color','red');
			$('#comCode, #ceo, #manager, #comPhone, #masterAccount').css('background-color','rgba(230, 230, 230, 0.4)').css('color','darkgray');
			$('.closeBtn').attr('class', 'btn btn-secondary cancleBtn').attr('data-dismiss','none').html('취소');
			$('.editSpace').attr('class', 'btn btn-primary okBtn').html('확인');
			$('.branchName').attr('disabled',false).attr('class', 'form-control editBranch');
			$('.branchName').val(branchName).attr('selected', 'selected');
			$('#contractDate, #rentStartDate, #rentEndDate').attr('disabled', false);
			$.selectFloor();
		});
		
		$('#branch>select').change(function(){
			$.selectFloor();
		});
		
		$('.floor').change(function(){
			$.selectOffice();
		});
		
		$(document).on('click','.okBtn', function(e){
			e.stopImmediatePropagation();
			if($('.officeName').val()=='공간 선택'){
				document.getElementById('modalText01').textContent='공간을 선택해주세요.';
				$('#dangerModal').modal('show');
			} else {
				if($('#contractDate').val()>$('#rentStartDate').val()){
					document.getElementById('modalText01').textContent='계약일을 확인해주세요.';
					$('#dangerModal').modal('show');
				} else {
					if($('#rentStartDate').val()>=$('#rentEndDate').val()){
						document.getElementById('modalText01').textContent='입주일과 퇴소일을 확인해주세요.';
						$('#dangerModal').modal('show');
					} else {
						if(branchName==$('.editBranch').val() && floor==$('.floor').val() && officeName==$('.officeName').val() && contractDate==$('#contractDate').val() && rentStartDate==$('#rentStartDate').val() && rentFinishDate==$('#rentEndDate').val()){
							$.cssBack();
							document.getElementById('modalText02').textContent='변경된 값이 없습니다.';
							$('#primaryModal').modal('show');
						} else {
							$.ajax({
								url: "/editSpaceInfo",
								type : "POST",
								contentType: "application/x-www-form-urlencoded; charset=UTF-8",
								data: {
									comCode:$('#comCode').text(),
									branchSelected:$('.editBranch').val(),
									officeSelected:$('.officeName').val(),
									contractDateInput:$('#contractDate').val(),
									MoveInDateInput:$('#rentStartDate').val(),
									MoveOutDateInput:$('#rentEndDate').val(),
									floor:$('.floor').val()
								},
								success: function(data){
									document.getElementById('modalText02').textContent='수정이 완료되었습니다';
									$('#primaryModal').modal('show');
									$('#primaryModal').on('hidden.bs.modal',function(){
										location.reload();
									});
									
									branchName=$('.editBranch').val();
									floor=$('.floor').val();
									officeName=$('.officeName').val();
									contractDate=$('#contractDate').val();
									rentStartDate=$('#rentStartDate').val();
									rentFinishDate=$('#rentEndDate').val();
									$('.editBranch').val(branchName);
									$('.officeName').html('<option>'+officeName+'</option>');
									$('.floor').html('<option>'+floor+'</option>');
									$('#contractDate').val(contractDate);
									$('#rentStartDate').val(rentStartDate);
									$('#rentEndDate').val(rentFinishDate);
									
									$.cssBack();
								},
								statusCode: {
									403: function(data){
										document.getElementById('modalText01').textContent='입력하신 기간은 공실이 아닙니다.';
										$('#dangerModal').modal('show');
									},
									406: function(data){
										document.getElementById('modalText01').textContent='입력하신 공간은 선택할 수 없습니다.';
										$('#dangerModal').modal('show');
									}
								},
								error: function(){
									document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
									$('#dangerModal').modal('show');
								}
							});
						}
					}
				}
			}
		});
		
		$(document).on('click', '.cancleBtn', function(e){
			e.stopImmediatePropagation();
			$.cssBack();
			$.dataBack();
		});
		
		$('#detail').on('hide.bs.modal', function(event) {
			$.cssBack();
		});
		
		$.cssBack=function(){
			$('#comCode, #ceo, #manager, #comPhone, #masterAccount').css('background-color','transparent').css('color','black');
			$('.spaceTitle').html('입주 공간 정보').css('color','black');
			$('.cancleBtn').attr('class', 'btn btn-secondary closeBtn').attr('data-dismiss','modal').html('목록');
			$('.okBtn').attr('class', 'btn btn-primary editSpace').html('수정');
			$('.editBranch').attr('disabled',true).attr('class', 'form-control branchName');
			$('#contractDate, #rentStartDate, #rentEndDate, .officeName, .floor').attr('disabled', true);
			$('.pencil').attr('hidden', true);
		}
		
		$.dataBack=function(){
			$('.branchName').val(branchName);
			$('.officeName').html('<option>'+officeName+'</option>');
			$('.floor').html('<option>'+floor+'</option>');
			$('#contractDate').val(contractDate);
			$('#rentStartDate').val(rentStartDate);
			$('#rentEndDate').val(rentFinishDate);
		}
		
		$.selectFloor=function(){
			$.ajax({
				url: "/selectFloor",
				type : "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "JSON",
				data:{
					branchName:$('.editBranch').val()
				},
				success: function(data){
					$.each(data, function(key, value){
						$('.officeName').attr('disabled',false);
						$('.floor').attr('disabled',false);
						$('.floor').html('');
						for(var index=0; index<value.length; index++){
							if($('.editBranch').val()==value[index].branch.branchName){
								$('.floor').val('<option selected>'+floor+'</option>');
								$('.floor').append('<option>'+value[index].office.floor+'</option>');
								$('.officeName').val('<option>'+officeName+'</option>');
							}
						}
						$('.floor').val(floor).attr('selected','selected');
						if($('.floor').val()==null){
							$('.floor').prepend('<option>층 선택</option>');
							$('.floor').val('층 선택').attr('selected','selected');
						}
					});
					$.selectOffice();
				},
				error: function(){
					document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
			});
		}
		
		$.selectOffice=function(){
			$.ajax({
				url: "/selectOffices",
				type : "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "JSON",
				data:{
					floor:$('.floor').val(),
					branchName:$('.editBranch').val()
				},
				success: function(data){
					$.each(data, function(key, value){
						$('.officeName').attr('disabled',false);
						$('.officeName').html('');
						for(var index=0; index<value.length; index++){
							if($('.editBranch').val()==value[index].branch.branchName){
								$('.officeName').append('<option>'+value[index].office.officeName+'</option>');
								if(officeName==value[index].office.officeName){
									$('.officeName').val('<option selected>'+officeName+'</option>');
								}
							}
						}
						$('.officeName').val(officeName).attr('selected','selected');
						if($('.officeName').val()==null){
							$('.officeName').prepend('<option>공간 선택</option>');
							$('.officeName').val('공간 선택').attr('selected','selected');
						}
					});
				},
				error: function(){
					document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
			});
		}
		
		// 삭제
		$(document).on('click', '.deleteBtn', function(e){
			e.stopImmediatePropagation();
			var branchValue=$('.branchName').val();
			if(branchValue=='undefined' || branchValue=='' || branchValue==null){
				branchValue=$('.editBranch').val();
			}
			$.ajax({
				url: "/deleteOffices",
				type : "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				data: {
					comCode:$('#comCode').text(),
					branchInput:branchValue,
					officeNameInput:$('.officeName').val(),
					floorInput:$('.floor').val()
				},
				success: function(){
					document.getElementById('modalText02').textContent='삭제가 완료되었습니다';
					$('#primaryModal').modal('show');
					$('#primaryModal').on('hidden.bs.modal',function(){
						location.reload();
					});
				},
				error: function(){
					document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
			});
		});
	});
});
</script>

<div class="content main">
	<h1> 입주사 관리 </h1>
	<table class="table companyMgmtTable">
		<thead class="thead-light">
			<tr>
				<td colspan="11" id="emptySpace"></td>
			</tr>
		    <tr>
				<th scope="col">회사코드</th>
				<th scope="col">회사명</th>
				<th scope="col">대표</th>
				<th scope="col">담당자</th>
				<th scope="col">대표번호</th>
				<th scope="col">지점</th>
				<th scope="col">층</th>
				<th scope="col">입주공간</th>
				<th scope="col">계약일</th>
				<th scope="col">입주기간</th>
				<th scope="col">마스터계정</th>
		    </tr>
		</thead>
		<tbody>
		<c:forEach items="${tenantsList}" var="tenantsList">
			<tr id="highlight" data-toggle="modal" data-target="#detail" data-comcode="${tenantsList.companyInfo.comCode}" data-comname="${tenantsList.companyInfo.comName}" data-ceo="${tenantsList.companyInfo.ceo}" data-manager="${tenantsList.companyInfo.manager}"  data-comphone="${tenantsList.companyInfo.comPhone}" data-branchname="${tenantsList.branch.branchName}" data-officename="${tenantsList.office.officeName}" data-contractdate="${tenantsList.companyInfo.contractDate}" data-rentstartdate="${tenantsList.companyInfo.rentStartDate}" data-rentfinishdate="${tenantsList.companyInfo.rentFinishDate}" data-masteraccount="${tenantsList.masterAccount.id}" data-floor="${tenantsList.office.floor}">
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.comCode}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.comName}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.ceo}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.manager}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.comPhone}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.branch.branchName}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.office.floor}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.office.officeName}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.contractDate}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.rentStartDate} ~ ${tenantsList.companyInfo.rentFinishDate}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.masterAccount.id}</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="tenantsMgmtPaging">
		<div class="pagingSection">page</div>
	</div>
	
<%//상세 Modal %>
<div class="modal fade" id="detail" tabindex="-1" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="ModalTitle">입주사 상세 정보</h5>
			</div>
			
			<div class="modal-body">
				<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
					<table class="table spaceTable">
			      		<tr colspan="4"><h3 class="tenantsTitle"></h3></tr>
						<tr>
							<th>회사코드</th>
							<td id="comCode" class="valueSetting">-</td>
							<th>대표</th>
							<td id="ceo" class="valueSetting">-</td>
						</tr>
						<tr>
							<th>담당자</th>
							<td id="manager" class="valueSetting">-</td>
							<th>회사연락처</th>
							<td id="comPhone" class="valueSetting">-</td>
						</tr>
						<tr>
							<th>마스터계정</th>
							<td colspan="3" id="masterAccount">-</td>
						</tr>
					</table>

					<table class="table spaceTable">
						<tr colspan="4"><h3 class="spaceTitle">입주 공간 정보</h3></tr>	       
						<tr>
							<th>지점</th>
							<td class="valueSetting" id="branch">
							<div id="forImg">
								<img src="imgs/pencil.png" class="pencil" hidden>
							</div>
							<select class="form-control branchName" name="branch" disabled>  
								<c:forEach items="${branchList }" var="list">
						        	<option id="branchName" value="${list.branchName }" >${list.branchName }</option>
						        </c:forEach>
							</select>
							</td>
							<th>공간</th>
							<td class="valueSetting">
							<div id="forImg">
								<img src="imgs/pencil.png" class="pencil" hidden>
							</div>
							<select class="form-control officeName" name="officeName" disabled>  
								<option id="officeName"></option>
							</select>
							</td>
						</tr>
						<tr>
							<th>층</th>
							<td class="valueSetting">
							<div id="forImg">
								<img src="imgs/pencil.png" class="pencil" hidden>
							</div>
							<select class="form-control floor" name="floor" disabled>  
								<option id="floor"></option>
							</select>
							</td>
							<th>계약일</th>
							<td class="dateCss"d><img src="imgs/pencil.png" class="pencil" hidden><input type="date" id="contractDate" name="contractDate" class="valueSetting" disabled></td>
						</tr>
						<tr>
							<th>입주일</th>
							<td class="dateCss"><img src="imgs/pencil.png" class="pencil" hidden><input type="date" id="rentStartDate" name="rentStartDate" class="valueSetting" disabled></td>
							<th>퇴소일</th>
							<td class="dateCss"><img src="imgs/pencil.png" class="pencil" hidden><input type="date" id="rentEndDate" name="rentEndDate" class="valueSetting" disabled></td>
						</tr>
					</table>
				</div>
			</div>
		
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary closeBtn" data-dismiss="modal">목록</button>
				<button type="button" class="btn btn-primary editSpace">수정</button>
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
			<button type="button" class="btn btn-danger btn-block" data-dismiss="modal" id="closeBtn">확인</button>
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