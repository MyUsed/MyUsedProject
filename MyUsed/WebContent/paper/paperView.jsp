<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<script>
	function confirmB(){
		if(confirm("삭제 하시겠습니까?") == true){
			
		}
		else{
			return false;
		}
	}
</script>    
    
<center>
	<form method="post" action="paperViewDelete.nhn?mynum=${mynum}" onsubmit="return confirmB()">
	    <table width="600">
	    	<tr>
	    		<td colspan="2"><hr color="#BDBDBD"></td>
	    	</tr>
	    
	    	<tr>
	    		<td><input type="submit" value="삭제">
	    			<input type="button" value="목록" onclick="javascript:window.location='paperMain.nhn?mynum=${mynum}'"/>
	    		</td>
	    		<input type="hidden" name="m_no" value="${m_no}"/>
	    	</tr>
	    	
	    	<tr>
	    		<td colspan="2"><hr color="#BDBDBD"></td>
	    	</tr>
	    
	    	<tr>
	    		<td>보낸사람 &nbsp&nbsp ${dto.s_name}(${name})</td>
	    	</tr>
	    	
	    	<tr>
	    		<td>받은시간 &nbsp&nbsp ${dto.reg}</td>
	    	</tr>
	    	
	    	<tr>
	    		<td colspan="2"><hr color="#BDBDBD"></td>
	    	</tr>
	    	
	    	<tr>
	    		<td colspan="2">${dto.s_content}</td>
	    	</tr>
	    	
	    	<tr>
	    		<td colspan="2"><hr color="#BDBDBD"></td>
	    	</tr>
	    </table>
    </form>
</center>