<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>광고 등록 페이지</title>
</head>
<body>

<!---------------------- 작업할때 2개만 include 해서 사용 ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->
<center>
	
	<h2>* 통과된 광고목록 *</h2>
	
	
	
		
	
	<table border="1">
		<tr align="center" bgcolor="#EAEAEA">
		<td><strong>업체명</strong></td><td><strong>성함</strong></td><td><strong>URL</strong></td>
		<td><strong>IMG</strong></td><td><strong>신청일</strong></td><td><strong>승인여부</strong></td>
		</tr>
		<c:forEach var="bannerlist" items="${bannerlist}">
		<c:if test="${bannerlist.state !=0}">
		<tr align="center">
		<td><strong>${bannerlist.hostname}</strong></td><td>${bannerlist.name}</td><td><a href="http://${bannerlist.url}">${bannerlist.url}</a></td>
		<td><a href="applyDetail.nhn?seq_num=${bannerlist.seq_num}"><img src="/MyUsed/images/${bannerlist.img}" width="50" height="80" /></a></td>
		<td><fmt:formatDate value="${bannerlist.reg}" type="date"/></td>
		<td>
		<c:if test="${bannerlist.state == 0}">
			<font color="red" ><strong>심사중</strong></font>
		</c:if>
		<c:if test="${bannerlist.state != 0}">
			<img src="/MyUsed/images/pass.PNG" width="50" height="50">
		</c:if>
		</td>
		</tr>
		</c:if>
		</c:forEach>
	
	</table>
	

</center>

</body>
</html>