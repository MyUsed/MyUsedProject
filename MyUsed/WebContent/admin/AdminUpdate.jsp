<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>


</head>
<body>
	<h2> * 관리자 등급조정 * </h2>

	<!-- 등급 조정  -->
	<div id="AdminupdateReturn"></div>
	
	<br/>
	
	 <table border="1" >
	
	 <tr align="center">
   		<td><strong>ID</strong></td><td><strong>PW</strong></td><td><strong>NAME</strong></td>
   		<td><strong>GRADE</strong></td><td><strong>PART</strong></td><td><strong>DATE</strong></td><td><strong>조정</strong></td>
   		</tr>
  		
	 	<c:forEach var="list" items="${list}" varStatus="i">
	 <tr>
	 		
	 		<td>${list.id}</td> 
	 		<td>${list.pw}</td>
	 		<td>${list.name}</td> 
	 		<td>${list.grade}</td>
	 		<td>${list.part}</td>	
	 		<td><fmt:formatDate value="${list.reg}" type="date" /></td>
	 		<c:if test="${list.seq_num != 1}"><td><input type="button" value="수정" onclick="AdiminupdateAjax(${list.seq_num});"/></td></c:if>
	  </tr>
	  
	 	</c:forEach>
	
	 
	 </table>
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>