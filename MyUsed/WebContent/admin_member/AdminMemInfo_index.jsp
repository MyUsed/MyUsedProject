<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/member/jquery-1.11.3.js"></script>
</head>

<body>

<form action="ModifyInfo.nhn" method="post">
<table border="1" align="center" width="800">
	<tr>
		<td align="center" bgcolor="#D9E5FF"><b>회원번호</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>타입</b></td>
		<td align="center" width="50%" bgcolor="#D9E5FF"><b>변경값</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>신청일</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>처리</b></td>
	</tr>
	<c:forEach var="modify" items="${modifyList}">
	
	<script type="text/javascript">
		function viewReason${modify.num}(){
			if(tr${modify.num}.style.display == 'block'){
				$('#tr${modify.num}').attr('style','display:none;');
			}else{
				$('#tr${modify.num}').attr('style','display:block;');
			}
		}
	</script>
	
	<tr>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">${modify.mem_num}</div></td>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">${modify.type}</div></td>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">${modify.changeval}</div></td>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">
		<fmt:formatDate value="${modify.reg}" type="date" /></div></td>
		<td align="center">
		<c:if test="${modify.state == 0}">
			<input type="hidden" value="${modify.num}" name="num">
			<input type="hidden" value="${modify.mem_num}" name="mem_num">
			<input type="hidden" value="${modify.type}" name="type">
			<input type="hidden" value="${modify.changeval}" name="changeval">
			<input type="submit" value="승인">
			<input type="button" value="거절" onclick="document.location.href='/MyUsed/ModifyReject.nhn?num=${modify.num}&type=${modify.type}&mem_num=${modify.mem_num}'">
		</c:if>
		<c:if test="${modify.state == 1}">
			<font color="blue"><b>승인</b></font>			
		</c:if>
		<c:if test="${modify.state == -1}">
			<font color="red"><b>거절</b></font>
		</c:if>
		</td>
	</tr>
	
	<tr id="tr${modify.num}" style="display:none;">
		<td colspan="4">${modify.reason}</td>
	</tr>
	
	</c:forEach>

</table>
</form>


</body></html>