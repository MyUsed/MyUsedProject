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
<h2>�������� ����</h2>
	<form method="post" action="admin_noticeUpdate.nhn">
		<table>
		
			<tr>
				<td>����:</td> <td><input type="text" name="title" size="48" value="${ndto.title}"></td>
				<input type="hidden" name="seq_num" value="${ndto.seq_num}"/>
			</tr>
			
			<tr>
				<td>����:</td> <td><textarea name="content" rows="20" cols="50">${ndto.content}</textarea></td>
			</tr>
			
			<tr align="center">
				<td colspan="2"><input type="submit" value="�ۼ��ϱ�"><input type="reset" value="�ٽ��ۼ�"></td>
			</tr>
			
		</table>
	</form>
</center>
</form>
</c:if>