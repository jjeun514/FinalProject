<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<title>관리자페이지</title>
<div class="content main">
<table id="adminMain">
	<tr>
		<td id="spaceMgmt">
			<a href="spaceMgmt" id="more">> 더보기</a>
			<h2 id="spaceMgmtTitle">〈공간 관리〉</h2>
			<table id="spaceMgmtTable">
				<tr>
					<th id="branchName">지점</th>
					<th id="floor">층</th>
					<th id="officeName">호수</th>
					<th id="acreages">평수</th>
					<th id="rent">가격</th>
					<th id="occupancy">임대<br>현황</th>
					<th id="comName">입주사</th>
					<th id="max">가용<br>인원수</th>
				</tr>
				<c:forEach items="${spaceInfo}" var="spaceInfo" end="8">
				<tr class="spaceMgmt">
					<td><a href="#" onclick="return false;">${spaceInfo.branchName}</a></td>
					<td><a href="#" onclick="return false;">${spaceInfo.floor}</a></td>
					<td><a href="#" onclick="return false;">${spaceInfo.officeName}</a></td>
					<td><a href="#" onclick="return false;">${spaceInfo.acreages}</a></td>
					<td><a href="#" onclick="return false;">${spaceInfo.rent}</a></td>
				<c:if test="${spaceInfo.occupancy eq 0}">
					<td><a href="#" onclick="return false;"><font style="color:rgba(255,72,72,0.9)">공실</font></a></td>
				</c:if>
				<c:if test="${spaceInfo.occupancy eq 1}">
					<td><a href="#" onclick="return false;"><font style="color:darkgray">임대</font></a></td>
				</c:if></a>
					<td><a href="#" onclick="return false;">${spaceInfo.comName}</a></td>
					<td><a href="#" onclick="return false;">${spaceInfo.max}</a></td>
				</tr>
				</c:forEach>
			</table>
		</td>
		
		<td id="reservationMgmt">
			<a href="meetingRoomMgmt" id="more">> 더보기</a><br>
			<%@ include file="chart.jsp" %>
		</td>
	</tr>
	<tr>
		<td colspan=2 id="masterAccountMgmt">
			<a href="masterMgmt" id="more">> 더보기</a>
			<h2 id="masterTitle">〈마스터 계정 리스트〉</h2>
			<table id="masterAccountMgmtTable">
				<tr>
					<th scope="col">회사코드</th>
					<th scope="col">회사명</th>
					<th scope="col">대표</th>
					<th scope="col">담당자</th>
					<th scope="col">대표번호</th>
					<th scope="col">마스터계정</th>
					<th scope="col">가입일</th>
				</tr>
				<c:forEach items="${masterList}" var="list" end="8">
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
			</table>
		</td>
	</tr>
</table>

</div>
<%@ include file="template/footer.jspf" %>