<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<script src="/MyUsed/main/script.js"></script>
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
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

<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->
<div id="sidebannerR"><jsp:include page="/main/sidebannerR.jsp"/></div> <!-- ���̵��� Right  -->
<div id="advertise" ><jsp:include page="/main/advertise.jsp"/></div>  <!-- ���� ������  -->
<div id="sidebannerL"><jsp:include page="/main/sidebannerL.jsp" /></div> <!-- ���̵��� Left -->


<div id="contents">
<br/><br/><br/><br/><br/>
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
	    		
				<td colspan="2" align="right">�� ���� ���� ${paperCount}��</td>
				
			</tr>
			
			<tr>
				<td colspan="4"><hr color="#BDBDBD"></td>
			</tr>
			
		    	<tr>
		    		<td align="center" width="5%"><input type="checkbox" name="checkall" onclick="CheckAll()"/></td>
		    		<td width="25%">�������</td>
		    		<td width="45%">����</td>
		    		<td width="25%">��¥</td>
		    	</tr>
	    				
	    	<c:forEach var="list" items="${list}">
	    		<tr>
	    			<td align="center"><input type="checkbox" name="check" value="${list.m_no}" onclick="CheckOne()"/></td>
	    			<td><a href="paperForm.nhn?mynum=${mynum}&name=${list.s_name}">${list.s_name}</a></td>
	    			<td><a href="paperView.nhn?m_no=${list.m_no}">
	    			
	    			
	    			<c:if test="${list.state == 1}">
	    				(1)
	    			</c:if>
	    			
	    			<!-- list.s_content�� ���̰� 15���� ũ�� 14��° �ڸ� + ... �� ��� -->
	    			<c:if test="${fn:length(list.s_content) > 15}">
	    				${fn:substring(list.s_content,0,14)}... 
	    			</c:if>
	    			
					<!-- list.s_content�� ���̰� 15���� ������ ���������� ��� -->
					<c:if test="${fn:length(list.s_content) < 15}">
	    				${list.s_content}
	    			</c:if>
					</a>
	    					
	    			</td>
	    			<td><font size="2">${list.reg}</font></td>
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
</div>