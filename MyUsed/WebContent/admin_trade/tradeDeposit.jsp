<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>�ŷ���û������</title>
</head>
<body>
<!---------------------- �۾��Ҷ� 2���� include �ؼ� ��� ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->	
<center>
	<br/>
		<h2>* �Աݻ��¸�� *</h2>
	<br/><br/>
		
	<table border="1">
	
		<tr align="center">
		<td bgcolor="#B2CCFF"><strong>������ȸ����ȣ</strong></td><td bgcolor="#B2CCFF"><strong>������ID</strong></td><td bgcolor="#B2CCFF"><strong>�������̸�</strong></td>
		<td bgcolor="#B2CCFF"><strong>���űݾ�</strong></td><td bgcolor="#B2CCFF"><strong>�Աݻ���</strong></td><td bgcolor="#B2CCFF"><strong>�ŷ���û��</strong></td><td bgcolor="#B2CCFF"><font color="red"><strong>�Ա�Ȯ��</strong></font></td>
		</tr>
		
		<c:forEach var="orderlist" items="${orderlist}">
		<tr align="center">
		<td>${orderlist.buy_memnum}</td><td>${orderlist.buy_id}</td><td>${orderlist.buy_name}</td><td bgcolor="#FFEF85">${orderlist.buy_price}</td>
		<td>
		<c:if test="${orderlist.state == 0}"><font color="blue">�Ա���</font></c:if>
		<c:if test="${orderlist.state != 0}"><font color="red">�ԱݿϷ�</font></c:if>
		</td>
		<td><fmt:formatDate value="${orderlist.reg}" type="date"/></td>
		<td>
		<c:if test="${orderlist.state ==0}">
		<input type="button" value="�Ա�Ȯ��" onclick="javascript:window.location='insertNotice.nhn?seq_num=${orderlist.seq_num}'" />
		</c:if>
		<c:if test="${orderlist.state != 0}">
		<font color="red"><strong>O</strong></font>
		</c:if>
		</td>
		</tr>
		</c:forEach>
	
	</table>
		
</center>		
	
		
		
	
	
</body>
</html>