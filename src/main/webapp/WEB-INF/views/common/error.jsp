<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<html>
<head>
<title>에러페이지</title>
<style>
div#error-container{text-align:center;}
</style>
</head>
<body>
	<div id="error-container">
		<h1>에러!</h1>
		<h2 style="color:red;"><%=exception.getMessage() %></h2>
		<a href="${pageContext.request.contextPath }">시작페이지로 돌아가기</a>
	</div>
</body>
</html>