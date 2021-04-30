<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="template/AdminNavbar.jspf" %>
<title>관리자페이지</title>
<div class="content main">
<table id="adminMain">
	<tr>
		<td id="signUpMgmt"><h2>신청서 관리</h2></td>
		<td><%@ include file="chart.jsp" %></td>
	</tr>
	<tr>
		<td><h2>공간 관리</h2></td>
		<td><h2>회원 관리</h2></td>
	</tr>
</table>

</div>
<%@ include file="template/footer.jspf" %>