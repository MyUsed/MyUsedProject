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
	<h3>�������</h3>
	<hr width="500">
	<form method="post" action="admin_termsUpdate.nhn">
		<table>			
			<tr align="center">
				<td>MyUsed �̿��� ����</td>
				<td>�������� ���� �� �̿뿡 ���� �ȳ�</td>
				<td>��ġ���� �̿��� ����</td>
			</tr>	
				
			<tr>
				<td><textarea rows="20" cols="40" name="content1">${Tdto.content1}</textarea></td>
				<td><textarea rows="20" cols="40" name="content2">${Tdto.content2}</textarea></td>
				<td><textarea rows="20" cols="40" name="content3">${Tdto.content3}</textarea></td>
				<td><input type="hidden" name="seq_num" value="${Tdto.seq_num}"/></td>
			</tr>
		
			<tr><td></td></tr>
					
			<tr align="center">
				<td colspan="3">
					<input type="submit" value="�����Ϸ�"/>
					<input type="button" value="�ڷΰ���" onclick="history.go(-1)"/>
				</td>
			</tr>
		</table>
	</form>
</center>
</c:if>