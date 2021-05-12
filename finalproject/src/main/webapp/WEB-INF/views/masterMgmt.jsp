<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<title>마스터계정관리</title>
<script type="text/javascript">
$('.spaceMgmtLink').attr('class','nav-link spaceMgmtLink');
$('.companyMgmtLink').attr('class','nav-link companyMgmtLink');
$('.masterMgmtLink').attr('class','nav-link masterMgmtLink active');
$('.meetingRoomMgmtLink').attr('class','nav-link meetingRoomMgmtLink');
$('.signUpMgmtLink').attr('class','nav-link signUpMgmtLink');
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
			<tr>
				<td><a href="#">${list.companyInfo.comCode}</a></td>
				<td><a>${list.companyInfo.comName}</a></td>
				<td><a>${list.companyInfo.ceo}</a></td>
				<td><a>${list.companyInfo.manager}</a></td>
				<td><a>${list.companyInfo.comPhone}</a></td>
				<td><a>${list.masteraccount.id}</a></td>
				<td><a>${list.masteraccount.signdate}</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
<%@ include file="template/footer.jspf" %>