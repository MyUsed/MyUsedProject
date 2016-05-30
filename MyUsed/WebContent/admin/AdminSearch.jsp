<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>검색 결과</title>
</head>
<body>

<h4><strong>- 검색결과 - </strong></h4>


<table bgcolor="#EAEAEA" border="1" >
 	<tr align="center" >
   		<td><strong>ID</strong></td><td><strong>PW</strong></td><td><strong>NAME</strong></td>
   		<td><strong>GRADE</strong></td><td><strong>PART</strong></td><td><strong>DATE</strong></td>
   	</tr>
   	
   	 <c:forEach var="list" items="${list}">
	 <tr>
	 		<td>${list.id}</td> 
	 		<td>${list.pw}</td>
	 		<td>${list.name}</td> 
	 		<td>${list.grade}</td>
	 		<td>${list.part}</td>
	 		<td><fmt:formatDate value="${list.reg}" type="date" /></td>
	  </tr>
	  </c:forEach>
	
</table>

</body>
</html>