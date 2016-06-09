<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>

<c:if test="${sessionScope.adminId == null}">
	<script type="text/javascript">
		alert("������ �����ϴ�.");
		history.go(-1);
	</script>
</c:if>

<script type="text/javascript">
	function Nconfirm(seq_num){
		if(confirm("�����Ͻðڽ��ϱ�?") == true){
			window.location="admin_noticeDelete.nhn?seq_num="+seq_num;
		}
		else{
			return;
		}
	}
</script>

<c:if test="${sessionScope.adminId != null}">
<center><br/>
<h2>�������� ����</h2>
	<table>
		<tr align="center" bgcolor="#7EB1FF">
			<td>�� ��ȣ</td>
			<td>�� ����</td>
			<td>�� ����</td>
		</tr>
		
		<c:forEach var="list" items="${list}">
			<tr align="center" bgcolor="#D5D5D5">
				<td>
					${list.seq_num}
				</td>
				
				<td>
					<a href="admin_noticeModify.nhn?seq_num=${list.seq_num}">
						<!-- list.content�� ���̰� 15���� ũ�� 14��° �ڸ� + ... �� ��� -->
				   		<c:if test="${fn:length(list.title) > 14}">
				    		${fn:substring(list.title,0,13)}... 
				    	</c:if>
				    	
						<!-- list.content�� ���̰� 15���� ������ ���������� ��� -->
						<c:if test="${fn:length(list.title) < 14}">
					 		${list.title}
						</c:if>	    		
					</a>
				</td>
				
				<td>
					<input type="button" value="����" onclick="Nconfirm(${list.seq_num})"/>
				</td>
			</tr>
		</c:forEach>
	</table>
</center>
</c:if>