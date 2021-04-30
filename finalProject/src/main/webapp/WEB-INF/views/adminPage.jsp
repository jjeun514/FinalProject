<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<title>관리자페이지</title>
<div class="content main">
<table id="adminMain">
	<tr>
		<td id="signUpMgmt">
			<a href="#" id="more">> 더보기</a>
			<h2 id="admissionTitle">〈신청서 관리〉</h2>
			<p id="text01">※ 관리자 승인 대기중인 회원가입 신청서</p>
			<table id="signUpMgmtTable">
				<tr>
					<th id="comName">회사</th>
					<th id="memName">이름</th>
					<th id="emailId">ID/이메일</th>
					<th id="dept">부서</th>
					<th id="memPhone">전화번호</th>
					<th id="memNick">닉네임</th>
				</tr>
				<c:forEach items="${pendingList}" var="pendingList" end="8">
				<tr>
					<td>${pendingList.comName}</td>
					<td>${pendingList.memName}</td>
					<td>${pendingList.id}</td>
					<td>${pendingList.dept}</td>
					<td>${pendingList.memPhone}</td>
					<td>${pendingList.memNickName}</td>
				</tr>
				</c:forEach>
			</table>
		</td>
		<td id="reservationMgmt">
			<a href="#" id="more">> 더보기</a><br>
			<%@ include file="chart.jsp" %>
		</td>
	</tr>
	<tr>
		<td id="memberMgmt">
			<a href="memberMgmt" id="more">> 더보기</a>
			<h2 id="memberTitle">〈회원 관리〉</h2>
			<table id="memberMgmtTable">
				<tr>
					<th id="comName">회사</th>
					<th id="memName">이름</th>
					<th id="emailId">ID/이메일</th>
					<th id="dept">부서</th>
					<th id="memPhone">전화번호</th>
					<th id="memNick">닉네임</th>
				</tr>
				<c:forEach items="${memberList}" var="memberList" end="8">
				<tr>
					<td>${memberList.comName}</td>
					<td>${memberList.memName}</td>
					<td>${memberList.id}</td>
					<td>${memberList.dept}</td>
					<td>${memberList.memPhone}</td>
					<td>${memberList.memNickName}</td>
				</tr>
				</c:forEach>
			</table>
		</td>
		<td id="spaceMgmt">
			<a href="spaceMgmt" id="more">> 더보기</a>
			<h2 id="spaceMgmtTitle">〈공간 관리〉</h2>
			<table id="spaceMgmtTable">
				<tr>
					<th id="branchName">지점</th>
					<th id="floor">층</th>
					<th id="officeNum">호수</th>
					<th id="acreages">평수</th>
					<th id="rent">가격</th>
					<th id="occupancy">임대현황</th>
					<th id="comName">입주사</th>
					<th id="max">가용인원수</th>
				</tr>
				<c:forEach items="${spaceInfo}" var="spaceInfo" end="8">
				<tr>
					<td>${spaceInfo.branchName}</td>
					<td>${spaceInfo.floor}</td>
					<td>${spaceInfo.officeNum}</td>
					<td>${spaceInfo.acreages}</td>
					<td>${spaceInfo.rent}</td>
				<c:if test="${spaceInfo.occupancy eq 0}">
					<td style="color:red; background-color:lightyellow">공실</td>
				</c:if>
				<c:if test="${spaceInfo.occupancy eq 1}">
					<td>임대중</td>
				</c:if>
					<td>${spaceInfo.comName}</td>
					<td>${spaceInfo.max}</td>
				</tr>
				</c:forEach>
			</table>
		</td>
	</tr>
</table>

</div>
<%@ include file="template/footer.jspf" %>