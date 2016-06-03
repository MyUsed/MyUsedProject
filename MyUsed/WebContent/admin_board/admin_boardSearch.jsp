<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.adminId == null }">
	<script type="text/javascript">
		alert("������ �����ϴ�.");
		history.go(-1);
	</script>
</c:if>

<!------------------------------------- boardlist ------------------------------------->
<br/>
<c:if test="${sessionScope.adminId != null }">
		<table align="center">
			<c:if test="${radio == 'board'}">
				<c:if test="${boardcount > 0}">
					
					<tr>
						<td colspan="6" align="center"><b>�� �Խñ� ��:${boardcount}</b></td>
					</tr>
					
					<tr align="center" bgcolor="#7EB1FF">
						<td>�۹�ȣ</td>
						<td>ȸ�����̵�</td>
						<td>ȸ���̸�</td>
						<td>���ƿ��</td>
						<td>��ۼ�</td>
						<td>�Խ��ѽð�</td>
					</tr>
					
				<c:forEach var="boardlist" items="${boardlist}">
					<tr align="center" bgcolor="#D5D5D5">
						<td><a href="admin_boardView.nhn?b_num=${boardlist.num}&like=${boardlist.likes}">${boardlist.num}</a></td>
						<td>${memid}</td>
						<td>${boardlist.name}</td>
						<td>${boardlist.likes}</td>
						<td>${boardlist.reples}</td>
						<td>${boardlist.reg}</td>
					</tr>
				</c:forEach>
				
				<tr>
					<td colspan="6" align="center">${pagingHtml}</td>
				</tr>
			</c:if>
<!--------------------- �Խù��� �������� ���� �� --------------------->	
				<c:if test="${boardcount < 1}">		
					<table align="center">
						<tr>
							<td align="center"><font color="red">�Խñ��� �������� �ʽ��ϴ�.</font></td>
						</tr>
					</table>
				</c:if>
<!--------------------- �Խù��� �������� ���� �� --------------------->	
			</c:if>
<!------------------------------------- boardlist ------------------------------------->
	
	
			
<!------------------------------------- proboardlist ------------------------------------->	
			<c:if test="${radio == 'proboard'}">
				<c:if test="${procount > 0}">
					<tr>
						<td colspan="8" align="center"><b>�� �Խñ� ��:${procount}</b></td>
					</tr>
				
					<tr align="center" bgcolor="#7EB1FF">
						<td>�۹�ȣ</td>
						<td>ȸ�����̵�</td>
						<td>ȸ���̸�</td>
						<td>ī�װ�</td>
						<td>���ƿ��</td>
						<td>��ۼ�</td>
						<td>����</td>
						<td>�Խ��ѽð�</td>
					</tr>
					
				<c:forEach var="prolist" items="${prolist}">
					<tr align="center" bgcolor="#D5D5D5">
						<td><a href="admin_proboardView.nhn?pro_num=${prolist.num}&like=${prolist.likes}">${prolist.num}</a></td>
						<td>${memid}</td>
						<td>${prolist.name}</td>
						<td>${prolist.categ}</td>
						<td>${prolist.likes}</td>
						<td>${prolist.reples}</td>
						<td>${prolist.price}</td>
						<td>${prolist.reg}</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="8" align="center">${pagingHtml}</td>
				</tr>
			</c:if>
			
<!--------------------- �Խù��� �������� ���� �� --------------------->	
			<c:if test="${procount < 1}">		
				<table align="center">
					<tr>
						<td align="center"><font color="red">�Խñ��� �������� �ʽ��ϴ�.</font></td>
					</tr>
				</table>
			</c:if>
<!--------------------- �Խù��� �������� ���� �� --------------------->					
			</c:if>
		</table>
</c:if> 
<!------------------------------------- proboardlist ------------------------------------->	