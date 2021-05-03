<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>어드민만 볼 수 있음</h1>
	
	
	
	<sec:authorize access="hasRole('ADMIN')">
 		<h2>관리자 페이지</h2>
	</sec:authorize>
	
	<!-- 로그인 안되어있는 경우 보여지는 곳 -->
	<sec:authorize access="isAnonymous()">
	<!-- 로그인 링크 버튼 -->
	<a href="/login">login</a>
	</sec:authorize>
	
	<!-- 로그인 되어있는 경우 보여지는 곳-->
	<sec:authorize access="isAuthenticated()">
	<span>사용자</span>
	<span>권한</span>
	
	<!-- 로그아웃 버튼 -->
	
	<form action='/logout' method="POST">
	   <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
	   <button type="submit">logout</button>
	</form>
	
	</sec:authorize>
	
	
	
	
	
	<!-- 아래 내용은 자바 코드에서 해결할지 고민 -->
	<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
	<%@page import="org.springframework.security.core.Authentication"%>
	<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 
    String name = "";
    if(principal != null) {
        name = auth.getName();
    }
	%>



</body>
</html>