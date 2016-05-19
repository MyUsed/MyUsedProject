<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="/MyUsed/main/script.js"></script>
<script>
	function FriendList(){
		var url="paperFriendList.nhn?mynum=${mynum}";
		open(url, "friend", "width=300, height=500, top=80, left=600, resizable=no, scrollbars=yes, location=no");
	}
</script>

<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->
<div id="sidebannerR"><jsp:include page="/main/sidebannerR.jsp"/></div> <!-- ���̵��� Right  -->
<div id="advertise" ><jsp:include page="/main/advertise.jsp"/></div>  <!-- ���� ������  -->
<div id="sidebannerL"><jsp:include page="/main/sidebannerL.jsp" /></div> <!-- ���̵��� Left -->


<div id="contents">
<br/><br/><br/><br/><br/>
<form name="pform" action="paperSend.nhn" method="post">
	<center>
		<table border="0">
		    <tr>
		    	<c:if test="${name == null}">
		    		<td>�޴»�� <input type="text" name="r_name" size="35"/>
		    	</c:if>
		    	
		    	<c:if test="${name != null}">
		    		<td>�޴»�� <input type="text" name="r_name" size="35" value="${name}"/>
		    	</c:if>
		    	
		    	<input type="button" value="ģ�����" onclick="FriendList()"/></td>
		    </tr>
		    
		  	<tr>
		  		<td><textarea rows="15" cols="57" name="r_content"></textarea></td>
		  	</tr>
		  	
		  	<tr>
		  		<input type="hidden" name="mynum" value="${mynum}">
		  		
		  		<td align="right">
		  		<input type="button" value="���" onclick="javascript:window.location='paperMain.nhn?mynum=${mynum}'"/>
		  		<input type="submit" value="������"/>
		  		</td>
		  	</tr>
		</table>
	</center>
</form>
</div>