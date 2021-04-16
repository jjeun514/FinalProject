<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>어드민 계정리스트입니다</h1>
	<table>
		<thead>
			<tr>
				<th>id</th>
				<th>branchCode</th>
				<th>password</th>
				<th>nickName</th>
				<th>profile</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="bean">
			<tr>
				<td>${bean.id }</td>
				<td>${bean.branchCode }</td>
				<td>${bean.password }</td>
				<td>${bean.nickName }</td>
				<td>${bean.profile }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>