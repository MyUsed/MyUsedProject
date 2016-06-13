<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>
	// ģ����Ͽ� üũ�� radio��ư ��(ģ����id)�� 1�� �������� �Լ�
	function swap(){
		var length = friend.Fradio.length;	// radio��ư�� ����
		var bool = false;	// if���� ���������� ����
		
		for(var i=0; i<length; i++){	// radio��ư ���̸�ŭ ����
			if(friend.Fradio[i].checked){	// radio��ư�� 1���� üũ��������
				var radioV = friend.Fradio[i].value;	// üũ�� ���� radioV������ ����
				bool = true;
				break;
			}
			else{
				bool = false;
			}
		}
		if(bool == true){
			opener.document.pform.r_name.value = radioV;	// ģ���� id��(radioV)�� text�� ���.
			bool = false;
			self.close();
		}
			
		else{
			alert("ģ���� üũ���ּ���.");
		}
		
	}
</script>

<center>
<form name="friend" method="post" onsubmit="swap()">
<table>

	<tr>
		<td align="right">
			<input type="submit" value="�Է�"/>
		</td>
	</tr>

	<c:forEach var="list" items="${list}">
		<tr>
			<td>
				<input type="radio" name="Fradio" value="${list.id}">${list.id}(${list.name})
			</td>
		</tr>
	</c:forEach>
	
	
</table>
</form>
</center>