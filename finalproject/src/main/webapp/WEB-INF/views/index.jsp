<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>어드민 계정리스트입니다</h1>
	<!-- 로그인 안되어있는 경우 보여지는 곳 -->
	<sec:authorize access="isAnonymous()">
	<h5>로그인 안되어있음</h5>
	<a href="/login">로그인페이지이동</a>
	</sec:authorize>
	
	<!-- 로그인 되어있는 경우 보여지는 곳-->
	<sec:authorize access="isAuthenticated()">
		<h5>로그인 중임</h5>
		<form action='/logout' method="POST">
	   	 	<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
	   	 	<button type="submit">logout</button>
		</form>
	</sec:authorize>
	<a href="/user">유저페이지 이동 어드민만 갈 수 있음</a>
	
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