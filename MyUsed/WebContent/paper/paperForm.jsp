<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	function FriendList(){
		var url="paperFriendList.nhn?mynum=${mynum}";
		open(url, "friend", "width=300, height=500, top=80, left=600, resizable=no, scrollbars=yes, location=no");
	}
</script>

<form name="pform" action="paperSend.nhn" method="post">
	<center>
		<table border="0">
		    <tr>
		    	<c:if test="${name == null}">
		    		<td>받는사람 <input type="text" name="r_name" size="35"/>
		    	</c:if>
		    	
		    	<c:if test="${name != null}">
		    		<td>받는사람 <input type="text" name="r_name" size="35" value="${name}"/>
		    	</c:if>
		    	
		    	<input type="button" value="친구목록" onclick="FriendList()"/></td>
		    </tr>
		    
		  	<tr>
		  		<td><textarea rows="15" cols="57" name="r_content"></textarea></td>
		  	</tr>
		  	
		  	<tr>
		  		<input type="hidden" name="mynum" value="${mynum}">
		  		
		  		<td align="right">
		  		<input type="button" value="목록" onclick="javascript:window.location='paperMain.nhn?mynum=${mynum}'"/>
		  		<input type="submit" value="보내기"/>
		  		</td>
		  	</tr>
		</table>
	</center>
</form>