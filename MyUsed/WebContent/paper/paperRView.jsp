<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="/MyUsed/main/script.js"></script>

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
<center>
	<form method="post" action="paperViewRDelete.nhn?mynum=${mynum}" onsubmit="return confirmB()">
	    <table width="600">
	    	<tr>
	    		<td colspan="2"><hr color="#BDBDBD"></td>
	    	</tr>
	    
	    	<tr>
	    		<td>
	    			<input type="submit" value="����">
	    			<input type="button" value="����������" onclick="javascript:window.location='paperCollection.nhn?mynum=${mynum}'"/>
	    		</td>
	    		
	    		<td>
	    			<input type="button" value="���" onclick="javascript:window.location='paperMain.nhn?mynum=${mynum}'"/>
	    		</td>
	    		
	    		<input type="hidden" name="m_no" value="${m_no}"/>
	    	</tr>
	    	
	    	<tr>
	    		<td colspan="2"><hr color="#BDBDBD"></td>
	    	</tr>
	    
	    	<tr>
	    		<td>�޴»�� &nbsp&nbsp ${rdto.r_name}</td>
	    	</tr>
	    	
	    	<tr>
	    		<td>�����ð� &nbsp&nbsp ${rdto.reg}</td>
	    	</tr>
	    	
	    	<tr>
	    		<td colspan="2"><hr color="#BDBDBD"></td>
	    	</tr>
	    	
	    	<tr>
	    		<td colspan="2">${rdto.r_content}</td>
	    	</tr>
	    	
	    	<tr>
	    		<td colspan="2"><hr color="#BDBDBD"></td>
	    	</tr>
	    </table>
    </form>
</center>
</div>