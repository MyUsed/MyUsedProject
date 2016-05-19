<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!-- ��üüũ�ڽ� -->
<script>
	function CheckAll(){
		var chk = document.getElementsByName("check");	// checkbox�� name�� ���� ����
		var length = chk.length;	// checkbox�� ����
		var check = "";		// true�� üũ, false�� ����
		if(paper.checkall.checked == true){	// ���üũ�� true�� 
			check = false;	//checkbox ���� üũ
		}
		else{	// ���üũ�� false��
			check = true;	// checkbox ���� üũ ����
		}
			if(check == false){
				for(var i=0; i<chk.length;i++){		// checkbox�� ���̸�ŭ ����
					chk[i].checked = true;    		//��� üũ
				}	
			}
			else{
				for(var i=0; i<chk.length;i++){ 	// checkbox�� ���̸�ŭ ����
						chk[i].checked = false;     //��� ����
					}
				}
	}
	// checkbox�� ���� üũ ���� ��  ���üũ�� üũ
	function CheckOne(){
		var length = paper.check.length;	// checkbox�� ����
		var cnt = 0;	
			for(var i=0; i<length; i++){
				if(paper.check[i].checked == true){	// checkbox�� üũ �� ������ cnt ����
					cnt++;
					if(cnt == length){	// cnt�� checkbox�� ���̰� ������ ���üũ�� üũ
						paper.checkall.checked = true;
					}
				}
			}
	}
</script>

<script>
	function confirmB(){
		if(confirm("���� �Ͻðڽ��ϱ�?") == true){
			
		}
		else{
			return false;
		}
	}
</script>

<form name="paper" method="post" action="paperDelete.nhn?mynum=${mynum}" onsubmit="return confirmB()">
	<center>
	    <table width="600">
	    
	    	<tr>
	    		<td colspan="4"><hr color="#BDBDBD"></td>
	    	</tr>
	    
	    	<tr align="center">
	    		<td><input type="submit" value="����"/></td>
	    		
	    		<td>
	    			<input type="button" value="��������" onclick="javascript:window.location='paperForm.nhn?mynum=${mynum}'"/>
	    		</td>
	    		
				<td align="right">�� ���� ���� ${paperCount}��</td>
				
			</tr>
			
			<tr>
				<td colspan="4"><hr color="#BDBDBD"></td>
			</tr>
			
		    	<tr>
		    		<td align="center" width="5%"><input type="checkbox" name="checkall" onclick="CheckAll()"/></td>
		    		<td width="25%">�������</td>
		    		<td width="60%">����</td>
		    		<td width="10%">��¥</td>
		    	</tr>
	    				
	    	<c:forEach var="list" items="${list}">
	    		<tr>
	    			<td align="center"><input type="checkbox" name="check" value="${list.m_no}" onclick="CheckOne()"/></td>
	    			<td><a href="paperForm.nhn?mynum=${mynum}&name=${list.s_name}">${list.s_name}</a></td>
	    			<td><a href="paperView.nhn?m_no=${list.m_no}">
	    			<!-- list.s_content�� ���̰� 15���� ũ�� 14��° �ڸ� + ... �� ��� -->
	    			<c:if test="${fn:length(list.s_content) > 15}">
	    				${fn:substring(list.s_content,0,14)}...
	    			</c:if>
					<!-- list.s_content�� ���̰� 15���� ������ ���������� ��� -->
					<c:if test="${fn:length(list.s_content) < 15}">
	    				${list.s_content}
	    			</c:if>
					</a>
	    				<c:if test="${list.state == 1}">
	    					(1)
	    				</c:if>
	    			</td>
	    			<td>${list.reg}</td>
	    		</tr>
	    	</c:forEach>
	    	
	    		<tr>
	    			<td colspan="4" align="center">${pagingHtml}</td>
	    		</tr>
	    	
	    		<tr>
	    			<td colspan="4"><hr color="#BDBDBD"></td>
	    		</tr>
	    		
	    </table>
    </center>
</form>