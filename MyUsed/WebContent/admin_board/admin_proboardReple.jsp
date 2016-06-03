<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.adminId == null }">
	<script type="text/javascript">
		alert("������ �����ϴ�.");
		history.go(-1);
	</script>
</c:if>

<script type="text/javascript">
	function Bconfirm(seq_num, num){
		if(confirm("�����Ͻðڽ��ϱ�?") == true){
			window.location="admin_proRepleDelete.nhn?seq_num="+seq_num+"&num="+num;
		}
		else{
			return;
		}
	}
</script>
<center>
<c:if test="${sessionScope.adminId != null }">
	<table>
	
		<tr align="center" bgcolor="#7EB1FF">
			<td>��۹�ȣ</td>
			<td>ȸ����ȣ</td>
			<td>��۳���</td>
			<td>ȸ���̸�</td>
			<td>�ۼ���¥</td>
			<td>����</td>
		</tr>
		
		<c:forEach var="list" items="${list}">
			<tr align="center" bgcolor="#D5D5D5">
				<td>${list.seq_num}</td>
				<td>${list.mem_num}</td>
				<td>${list.content}</td>
				<td>${list.name}</td>
				<td>${list.reg}</td>
				<td><input type="button" value="����" onclick="Bconfirm('${list.seq_num}', '${num}')"/></td>
			</tr>
		</c:forEach>

	</table>
</c:if>
</center>