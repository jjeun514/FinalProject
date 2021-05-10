<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<title>마스터계정관리</title>
<script type="text/javascript">
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
				<td>${list.companyInfo.comCode}</td>
				<td>${list.companyInfo.comName}</td>
				<td>${list.companyInfo.ceo}</td>
				<td>${list.companyInfo.manager}</td>
				<td>${list.companyInfo.comPhone}</td>
				<td>${list.masteraccount.id}</td>
				<td>${list.masteraccount.signdate}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
<%@ include file="template/footer.jspf" %>