<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
	<form action="tradeApply.nhn" method="post">
	<select name="year">
	<option>년도</option>
	<c:forEach var="y" begin="2000" end="2020">
		<option value="${y}">${y}</option>
	</c:forEach>
	</select>
	
	
	<select name="month">
	<option>월</option>
	<c:forEach var="m" begin="1" end="12">
		<option value="${m}">${m}</option>
	</c:forEach>
	</select>
	
	
	<select name="day">
	<option>일</option>
	<c:forEach var="d" begin="1" end="31">
		<option value="${d}">${d}</option>
	</c:forEach>
	</select>
	
	
	<font size="3"><b>~</b></font>
	
	
	<select name="yyear">
	<option>년도</option>
	<c:forEach var="yy" begin="2000" end="2020">
		<option value="${yy}">${yy}</option>
	</c:forEach>
	</select>
	
	
	<select name="mmonth">
	<option>월</option>
	<c:forEach var="mm" begin="1" end="12">
		<option value="${mm}">${mm}</option>
	</c:forEach>
	</select>
	
	
	<select name="dday">
	<option>일</option>
	<c:forEach var="dd" begin="1" end="31">
		<option value="${dd}">${dd}</option>
	</c:forEach>
	</select>
	
		<input type="submit" value="검색" />
	</form>
		
</body>
</html>