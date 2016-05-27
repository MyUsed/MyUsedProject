<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>관리자 관리 페이지 </title>
<script src="/MyUsed/admin/adminAjax.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>

<!---------------------- 작업할때 2개만 include 해서 사용 ------------------------------->
<div id="AdminTop"><jsp:include page="AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->


		<br /> <br />
	<center>
	
	<input type="button" value="관리자 계정생성" onclick="createAjax();" /> 
	<input type="button" value="관리자 등급조정" onclick="updateAjax();"/> 
	<input type="button" value="관리자 계정삭제" onclick="deleteAjax();"/>
	
		<br /> <br />
		
	 <!-- create 계정생성 Ajax -->
	 <div id="createReturn"></div>
	 
	  <!-- create 계정삭제 Ajax -->
	 <div id="deleteReturn"></div>
	 	 
	  <!-- create 계정수정 Ajax -->
	 <div id="updateReturn"></div>
	 
	
	 <br/>
	 
	 
	 <div id="adminlist" style="display:block;">
	 
	 				<strong>* 관리자 목록 * </strong>
	 <table border="1" >
	
	 <tr align="center">
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
	 
	 </div>
	 
	 
	 
	</center>

	


</body>
</html>