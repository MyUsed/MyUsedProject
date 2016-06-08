<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/member/jquery-1.11.3.js"></script>

</head>
<body>


<table border="1" align="center" width="800">
	<tr>
		<td align="center" bgcolor="#D9E5FF"><b>회원번호</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>이름</b></td>
		<td align="center" width="50%" bgcolor="#D9E5FF"><b>사유</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>날짜</b></td>
	</tr>
	
	<c:forEach var="report" items="${searchList}">
	<tr>
		<td align="center">${report.mem_num}</td>
		<td align="center">${report.name}</td>
		<td align="center">${report.reason}</td>
		<td align="center"><fmt:formatDate value="${report.reg}" type="date" /></td>
	</tr>
	</c:forEach>
</table>

</body>
</html>