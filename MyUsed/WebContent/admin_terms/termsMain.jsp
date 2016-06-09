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

<script type="text/javascript">
	function termsConfirm(seq_num){
		if(confirm("�����Ͻðڽ��ϱ�?") == true){
			window.location="admin_termsDelete.nhn?seq_num="+seq_num;
		}
		else{
			return;
		}
	}
</script>

<c:if test="${sessionScope.adminId != null}">
<center>	
	<c:if test="${count > 0}">
	<br/><br/>
	<h3>���</h3>
	<hr width="500">
		<form method="post" action="admin_termsUpdateForm.nhn">
				<table>			
					<tr align="center">
						<td>MyUsed �̿��� ����</td>
						<td>�������� ���� �� �̿뿡 ���� �ȳ�</td>
						<td>��ġ���� �̿��� ����</td>
					</tr>
						
					<tr>
						<td><textarea rows="20" cols="40" name="content1" readonly="readonly">${Tdto.content1}</textarea></td>
						<td><textarea rows="20" cols="40" name="content2" readonly="readonly">${Tdto.content2}</textarea></td>
						<td><textarea rows="20" cols="40" name="content3" readonly="readonly">${Tdto.content3}</textarea></td>
						<td><input type="hidden" name="seq_num" value="${Tdto.seq_num}"/></td>
					</tr>
					
					<tr><td></td></tr>
					
					<tr align="center">
						<td colspan="3">
							<input type="button" value="����ۼ�" onclick="javascript:window.location='admin_termsWrite.nhn'"/>&nbsp&nbsp
							<input type="submit" value="�����ϱ�"/>&nbsp&nbsp
							<input type="button" value="����" onclick="termsConfirm('${Tdto.seq_num}')"/>
						</td>
					</tr>
				</table>
		</form>
	</c:if>
		<c:if test="${count < 1}">
				<table>
				<br/><br/><br/><br/><br/><br/><br/>
					<tr>
						<td>
							<font color="red"><b>�ۼ��� ����� �����ϴ�.</b></font>
						</td>
					</tr>
					
					<tr align="center">
							<td colspan="3">
								<input type="button" value="����ۼ�" onclick="javascript:window.location='admin_termsWrite.nhn'"/>
							</td>
					</tr>
				</table>
		</c:if>
	</center>
	
	
</c:if>