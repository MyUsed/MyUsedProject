<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>

<c:if test="${sessionScope.adminId == null}">
	<script type="text/javascript">
		alert("������ �����ϴ�");
		history.go(-1);
	</script>
</c:if>

<c:if test="${sessionScope.adminId != null}">
<center>
<br/><br/>
<h3>����ۼ�</h3>
<hr width="500">
	
		<form action="admin_termsInsert.nhn" method="post">
			<table>
			
				<tr align="center">
					<td>���1</td>
					<td>���2</td>
					<td>���3</td>
				</tr>
			
				<tr>
					<td><textarea rows="20" cols="40" name="content1"></textarea></td>
					<td><textarea rows="20" cols="40" name="content2"></textarea></td>
					<td><textarea rows="20" cols="40" name="content3"></textarea></td>
				</tr>
				
				<tr><td></td></tr>
				
				<tr>
					<td colspan="3" align="center">
						<input type="submit" value="�ۼ��Ϸ�"/>&nbsp&nbsp
						<input type="reset" value="�ٽ��ۼ�"/>&nbsp&nbsp
						<input type="button" value="�ڷ�" onclick="history.go(-1)"/>
					</td>
				</tr>
				
			</table>
		</form>
	</center>
</c:if>