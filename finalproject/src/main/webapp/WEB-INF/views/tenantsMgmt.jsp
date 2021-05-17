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
		var comName=$(event.relatedTarget).data('comname');
		var comCode=$(event.relatedTarget).data('comcode');
		var ceo=$(event.relatedTarget).data('ceo');
		var manager=$(event.relatedTarget).data('manager');
		var comPhone=$(event.relatedTarget).data('comphone');
		var branchName=$(event.relatedTarget).data('branchname');
		var officeName=$(event.relatedTarget).data('officename');
		var contractDate=$(event.relatedTarget).data('contractdate');
		var rentStartDate=$(event.relatedTarget).data('rentstartdate');
		var rentFinishDate=$(event.relatedTarget).data('rentfinishdate');
		var masterAccount=$(event.relatedTarget).data('masteraccount');
		console.log('comName: '+comName);
		$('.tenantsTitle').html(comName+' 상세 정보');
		$('#comCode').html(comCode);
		$('#ceo').html(ceo);
		$('#manager').html(manager);
		$('#comPhone').html(comPhone);
		$('#branchName').html(branchName);
		$('#officeName').html(officeName);
		$('#contractDate').html(contractDate);
		$('#rentStartDate').html(rentStartDate);
		$('#rentEndDate').html(rentFinishDate);
		$('#masterAccount').html(masterAccount);
	});
});
</script>

<div class="content main">
	<h1> 입주사 관리 </h1>
	<table class="table companyMgmtTable">
		<thead class="thead-light">
			<tr>
				<td colspan="10" id="addSpaceBtn">
					<button type="button" class="btn btn-primary addSpaceBtn" data-toggle="modal" data-target="#addModal">추가</button>
				</td>
			</tr>
		    <tr>
				<th scope="col">회사코드</th>
				<th scope="col">회사명</th>
				<th scope="col">대표</th>
				<th scope="col">담당자</th>
				<th scope="col">대표번호</th>
				<th scope="col">지점</th>
				<th scope="col">입주공간</th>
				<th scope="col">계약일</th>
				<th scope="col">입주기간</th>
				<th scope="col">마스터계정</th>
		    </tr>
		</thead>
		<tbody>
		<c:forEach items="${tenantsList}" var="tenantsList">
			<tr id="highlight" data-toggle="modal" data-target="#detail" data-comcode="${tenantsList.companyInfo.comCode}" data-comname="${tenantsList.companyInfo.comName}" data-ceo="${tenantsList.companyInfo.ceo}" data-manager="${tenantsList.companyInfo.manager}"  data-comphone="${tenantsList.companyInfo.comPhone}" data-branchname="${tenantsList.branch.branchName}" data-officename="${tenantsList.office.officeName}" data-contractdate="${tenantsList.companyInfo.contractDate}" data-rentstartdate="${tenantsList.companyInfo.rentStartDate}" data-rentfinishdate="${tenantsList.companyInfo.rentFinishDate}" data-masteraccount="${tenantsList.masterAccount.id}">
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.comCode}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.comName}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.ceo}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.manager}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.comPhone}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.branch.branchName}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.office.officeName}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.contractDate}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.companyInfo.rentStartDate} ~ ${tenantsList.companyInfo.rentFinishDate}</a></td>
				<td><a href="#" onclick="return false;">${tenantsList.masterAccount.id}</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

<%//상세 Modal %>
<div class="modal fade" id="detail" tabindex="-1" aria-hidden="true">
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
							<td id="branchName" class="valueSetting">-</td>
							<th>공간</th>
							<td id="officeName" class="valueSetting">-</td>
						</tr>
						<tr>
							<th>계약일</th>
							<td colspan="3" id="contractDate" class="valueSetting">-</td>
						</tr>
						<tr>
						<th>입주일</th>
							<td id="rentStartDate" class="valueSetting">-</td>
							<th>퇴소일</th>
							<td id="rentEndDate" class="valueSetting">-</td>
						</tr>
					</table>
				</div>
			</div>
		
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary closeBtn" data-dismiss="modal">목록</button>
				<button type="button" class="btn btn-primary">수정</button>
				<button type="button" class="btn btn-danger">삭제</button>
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