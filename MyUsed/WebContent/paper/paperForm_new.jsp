<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- <link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" /> -->
<!-- <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="/MyUsed/main/script.js"></script> -->
<script>
	function FriendList(){
		var url="paperFriendList.nhn?mynum=${mynum}";
		open(url, "friend", "width=300, height=500, top=80, left=600, resizable=no, scrollbars=yes, location=no");
	}
</script>
<body bgcolor="#EAEAEA">

<form name="pform" action="paperSend.nhn" method="post">
		<table align="center">
			<tr height="50"><td align="center"><b>����������</b></td></tr>
		    <tr>
		    	<c:if test="${name == null}">
		    		<td>�޴»�� <input type="text" name="r_name" size="35"/>
		    	</c:if>
		    	
		    	<c:if test="${name != null}">
		    		<td>�޴»�� <input type="text" name="r_name" size="35" value="${name}"/>
		    	</c:if>
		    	
		    	<input type="button" value="ģ�����" onclick="FriendList()"/>
		    	</td>
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
</form>

</body>