<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>
<c:if test="${sessionScope.adminId == null}">
	<script type="text/javascript">
		alert("������ �����ϴ�.");
		history.go(-1);
	</script>
</c:if>



<c:if test="${sessionScope.adminId != null}">
<center><br/><br/>
<h2>�������� �ۼ�</h2>
<form method="post" action="admin_noticeInsert.nhn">
	<table>
	
		<tr>
			<td>����:</td> <td><input type="text" name="title" size="48"></td>
		</tr>
		
		<tr>
			<td>����:</td> <td><textarea name="content" rows="20" cols="50"></textarea></td>
		</tr>
		
		<tr align="center">
			<td colspan="2"><input type="submit" value="�ۼ��ϱ�"><input type="reset" value="�ٽ��ۼ�"></td>
		</tr>
		
	</table>
</center>
</form>
</c:if>