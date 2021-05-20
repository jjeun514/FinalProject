<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<title>입주사관리</title>
<script type="text/javascript">
$('.spaceMgmtLink').attr('class','nav-link spaceMgmtLink');
$('.companyMgmtLink').attr('class','nav-link companyMgmtLink active');
$('.masterMgmtLink').attr('class','nav-link masterMgmtLink');
$('.meetingRoomMgmtLink').attr('class','nav-link meetingRoomMgmtLink');
$('.signUpMgmtLink').attr('class','nav-link signUpMgmtLink');

$(document).ready(function(){
	$('#detail').on('show.bs.modal', function(event) {
		event.stopImmediatePropagation();
		console.log('[modal상세]');
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
		console.log('[modal상세] officeName: '+officeName);
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
			console.log('[수정버튼누름]');
			$('.spaceTitle').html('입주 공간 정보 수정').css('color','red');
			$('#comCode, #ceo, #manager, #comPhone, #masterAccount').css('background-color','rgba(230, 230, 230, 0.4)').css('color','darkgray');
			$('.closeBtn').attr('class', 'btn btn-secondary cancleBtn').attr('data-dismiss','none').html('취소');
			$('.editSpace').attr('class', 'btn btn-primary okBtn').html('확인');
			$('.branchName').attr('disabled',false).attr('class', 'form-control editBranch');
			$('.branchName').val(branchName).attr('selected', 'selected');
			$('#contractDate, #rentStartDate, #rentEndDate').attr('disabled', false);
			console.log('[수정버튼누름] officeName: '+officeName);
			$.selectFloor();
		});
		
		$('#branch>select').change(function(){
			console.log('[수정버튼누름>지점 변경]');
			console.log('[수정버튼누름>지점 변경] officeName: '+officeName);
			$.selectFloor();
		});
		
		$('.floor').change(function(){
			console.log('[수정버튼누름>층 변경]');
			$.selectOffice();
		});
		
		$('#rentStartDate').change(function(){
			console.log('[수정버튼누름>입주일 변경]');
			
		});
		
		$('#rentEndDate').change(function(){
			console.log('[수정버튼누름>퇴소일 변경]');
			
		});
		
		$(document).on('click','.okBtn', function(e){
			e.stopImmediatePropagation();
			console.log('[수정>확인버튼누름] officeName: '+officeName);
			if($('.officeName').val()=='공간 선택'){
				document.getElementById('modalText01').textContent='공간을 선택해주세요.';
				$('#dangerModal').modal('show');
			} else {
				if($('#contractDate').val()>$('#rentStartDate').val()){
					console.log('[X]계약일>입주일');
					document.getElementById('modalText01').textContent='계약일을 확인해주세요.';
					$('#dangerModal').modal('show');
				} else {
					console.log('[O]계약일<=입주일');
					if($('#rentStartDate').val()>=$('#rentEndDate').val()){
						console.log('[X]계약일>=퇴소일');
						document.getElementById('modalText01').textContent='입주일과 퇴소일을 확인해주세요.';
						$('#dangerModal').modal('show');
					} else {
						console.log('[O]계약일<퇴소일');
						if(branchName==$('.editBranch').val() && floor==$('.floor').val() && officeName==$('.officeName').val() && contractDate==$('#contractDate').val() && rentStartDate==$('#rentStartDate').val() && rentFinishDate==$('#rentEndDate').val()){
							console.log('[수정>확인버튼누름] 값 변경 없음');
							console.log('branchName: '+branchName+', branchName(입력값): '+$('.editBranch').val()+', floor: '+floor+', floor(입력값): '+$('.floor').val()+', officeName: '+officeName+', officeName(입력값): '+$('.officeName').val()+', contractDate: '+contractDate+', contractDate(입력값): '+$('#contractDate').val()+', rentStartDate: '+rentStartDate+', rentStartDate(입력값): '+$('#rentStartDate').val()+', rentEndDate: '+rentFinishDate+', rentEndDate(입력값): '+$('#rentEndDate').val());
							$.cssBack();
							document.getElementById('modalText02').textContent='변경된 값이 없습니다.';
							$('#primaryModal').modal('show');
						} else {
							console.log('[수정>확인버튼누름] 지점/층/공간/계약일/입주일/퇴소일 변경됨');
							console.log('branchName: '+branchName+', branchName(입력값): '+$('.editBranch').val()+', floor: '+floor+', floor(입력값): '+$('.floor').val()+', officeName: '+officeName+', officeName(입력값): '+$('.officeName').val()+', contractDate: '+contractDate+', contractDate(입력값): '+$('#contractDate').val()+', rentStartDate: '+rentStartDate+', rentStartDate(입력값): '+$('#rentStartDate').val()+', rentEndDate: '+rentFinishDate+', rentEndDate(입력값): '+$('#rentEndDate').val());
							
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
									console.log('[editSpaceInfo] ajax성공 data: '+JSON.stringify(data));
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
										console.log('[editSpaceInfo] ajax - 입주일/퇴소일 확인 필요 data" '+JSON.stringify(data));
										document.getElementById('modalText01').textContent='입력하신 기간은 공실이 아닙니다.';
										$('#dangerModal').modal('show');
									},
									406: function(data){
										console.log('[editSpaceInfo] ajax - 사무실 존재X" '+JSON.stringify(data));
										document.getElementById('modalText01').textContent='입력하신 공간은 선택할 수 없습니다.';
										$('#dangerModal').modal('show');
									}
								},
								error: function(request, status, error){
									console.log('[editSpaceInfo] ajax 에러');
									console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
			console.log('[취소버튼누름] officeName: '+officeName);
			$.cssBack();
			$.dataBack();
		});
		
		$('#detail').on('hide.bs.modal', function(event) {
			console.log('[modal상세 닫힘] officeName: '+officeName);
			$.cssBack();
		});
		
		$.cssBack=function(){
			$('#comCode, #ceo, #manager, #comPhone, #masterAccount').css('background-color','transparent').css('color','black');
			$('.spaceTitle').html('입주 공간 정보').css('color','black');
			$('.cancleBtn').attr('class', 'btn btn-secondary closeBtn').attr('data-dismiss','modal').html('목록');
			$('.okBtn').attr('class', 'btn btn-primary editSpace').html('수정');
			$('.editBranch').attr('disabled',true).attr('class', 'form-control branchName');
			$('#contractDate, #rentStartDate, #rentEndDate, .officeName, .floor').attr('disabled', true);
		}
		
		$.dataBack=function(){
			$('.branchName').val(branchName);
			console.log('[dataBack] officeName: '+officeName);
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
					console.log('[selectFloor] ajax 성공');
					$.each(data, function(key, value){
						console.log('[selectFloor] length: '+value.length);
							$('.officeName').attr('disabled',false);
							$('.floor').attr('disabled',false);
							$('.floor').html('');
							for(var index=0; index<value.length; index++){
								console.log('[selectFloor] floor['+index+']: '+JSON.stringify(value[index].office.floor));
								if($('.editBranch').val()==value[index].branch.branchName){
									console.log('[selectFloor] 선택된 지점에 따라서 층/공간 select 동적 구성');
									console.log('지점 같음');
									$('.floor').val('<option selected>'+floor+'</option>');
									$('.floor').append('<option>'+value[index].office.floor+'</option>');
									$('.officeName').val('<option>'+officeName+'</option>');
								}
							}
							$('.floor').val(floor).attr('selected','selected');
							if($('.floor').val()==null){
								console.log('[selectOffices] 층 null');
								$('.floor').prepend('<option>층 선택</option>');
								$('.floor').val('층 선택').attr('selected','selected');
							}
					});
					console.log('[selectFloor] floor(ajax each 끝나고): '+floor);
					console.log('[selectFloor] officeName(ajax each 끝나고): '+officeName);
					$.selectOffice();
				},
				error: function(error){
					console.log('[selectFloor] ajax 에러');
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
					console.log('[selectOffices] ajax 성공');
					$.each(data, function(key, value){
						console.log('[selectOffices] length: '+value.length);
							$('.officeName').attr('disabled',false);
							$('.officeName').html('');
							for(var index=0; index<value.length; index++){
								if($('.editBranch').val()==value[index].branch.branchName){
									console.log('[selectOffices] 선택된 지점에 따라서 층/공간 select 동적 구성');
									console.log('지점 같음');
									$('.officeName').append('<option>'+value[index].office.officeName+'</option>');
									if(officeName==value[index].office.officeName){
										console.log('[selectOffices] selected officeName: '+officeName+', option: '+value[index].office.officeName);
										$('.officeName').val('<option selected>'+officeName+'</option>');
									}
									console.log('[selectOffices] selected 다름 officeName: '+value[index].office.officeName);
								}
							}
							$('.officeName').val(officeName).attr('selected','selected');
							if($('.officeName').val()==null){
								console.log('[selectOffices] 공간 null');
								$('.officeName').prepend('<option>공간 선택</option>');
								$('.officeName').val('공간 선택').attr('selected','selected');
							}
					});
					console.log('[selectOffices] ajax each 끝나고 floor: '+floor);
					console.log('[selectOffices] ajax each 끝나고 officeName: '+officeName);
				},
				error: function(error){
					console.log('[selectOffices] ajax 에러');
					document.getElementById('modalText01').textContent='오류가 발생했습니다. 다시 시도해주세요.';
					$('#dangerModal').modal('show');
				}
			});
		}
		
		// 삭제
		$(document).on('click', '.deleteBtn', function(e){
			e.stopImmediatePropagation();
			console.log('[삭제버튼누름]');
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
					console.log('[deleteOffices] ajax성공');
					document.getElementById('modalText02').textContent='삭제가 완료되었습니다';
					$('#primaryModal').modal('show');
					$('#primaryModal').on('hidden.bs.modal',function(){
						location.reload();
					});
				},
				error: function(request, status, error){
					console.log('[editSpaceInfo] ajax 에러');
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
							<select class="form-control branchName" name="branch" disabled>  
								<c:forEach items="${branchList }" var="list">
						        	<option id="branchName" value="${list.branchName }" >${list.branchName }</option>
						        </c:forEach>
							</select>
							</td>
							<th>공간</th>
							<td class="valueSetting">
							<select class="form-control officeName" name="officeName" disabled>  
								<option id="officeName"></option>
							</select>
							</td>
						</tr>
						<tr>
							<th>층</th>
							<td class="valueSetting">
							<select class="form-control floor" name="floor" disabled>  
								<option id="floor"></option>
							</select>
							</td>
							<th>계약일</th>
							<td><input type="date" id="contractDate" name="contractDate" class="valueSetting" disabled></td>
						</tr>
						<tr>
							<th>입주일</th>
							<td><input type="date" id="rentStartDate" name="rentStartDate" class="valueSetting" disabled></td>
							<th>퇴소일</th>
							<td><input type="date" id="rentEndDate" name="rentEndDate" class="valueSetting" disabled></td>
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