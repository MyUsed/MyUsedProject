<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="/MyUsed/main/script.js"></script>

<script>
	function confirmB(){
		if(confirm("삭제 하시겠습니까?") == true){
			
		}
		else{
			return false;
		}
	}
</script>    

<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->
<div id="sidebannerR"><jsp:include page="/main/sidebannerR.jsp"/></div> <!-- 사이드배너 Right  -->
<div id="advertise" ><jsp:include page="/main/advertise.jsp"/></div>  <!-- 광고 페이지  -->
<div id="sidebannerL"><jsp:include page="/main/sidebannerL.jsp" /></div> <!-- 사이드배너 Left -->


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
	    			<input type="submit" value="삭제">
	    			<input type="button" value="보낸쪽지함" onclick="javascript:window.location='paperCollection.nhn?mynum=${mynum}'"/>
	    		</td>
	    		
	    		<td>
	    			<input type="button" value="목록" onclick="javascript:window.location='paperMain.nhn?mynum=${mynum}'"/>
	    		</td>
	    		
	    		<input type="hidden" name="m_no" value="${m_no}"/>
	    	</tr>
	    	
	    	<tr>
	    		<td colspan="2"><hr color="#BDBDBD"></td>
	    	</tr>
	    
	    	<tr>
	    		<td>받는사람 &nbsp&nbsp ${rdto.r_name}</td>
	    	</tr>
	    	
	    	<tr>
	    		<td>보낸시간 &nbsp&nbsp ${rdto.reg}</td>
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