<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>���� ��� ������</title>
</head>
<body>

<!---------------------- �۾��Ҷ� 2���� include �ؼ� ��� ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->
<center>
	
	<h2>* ����� ������ *</h2>
	
	
	
		
	
	<table border="1">
		<tr align="center" bgcolor="#EAEAEA">
		<td><strong>��ü��</strong></td><td><strong>����</strong></td><td><strong>URL</strong></td>
		<td><strong>IMG</strong></td><td><strong>��û��</strong></td><td><strong>���ο���</strong></td>
		</tr>
		<c:forEach var="bannerlist" items="${bannerlist}">
		<c:if test="${bannerlist.state !=0}">
		<tr align="center">
		<td><strong>${bannerlist.hostname}</strong></td><td>${bannerlist.name}</td><td><a href="http://${bannerlist.url}">${bannerlist.url}</a></td>
		<td><a href="applyDetail.nhn?seq_num=${bannerlist.seq_num}"><img src="/MyUsed/images/${bannerlist.img}" width="50" height="80" /></a></td>
		<td><fmt:formatDate value="${bannerlist.reg}" type="date"/></td>
		<td>
		<c:if test="${bannerlist.state == 0}">
			<font color="red" ><strong>�ɻ���</strong></font>
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