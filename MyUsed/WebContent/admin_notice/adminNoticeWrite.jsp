<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>
<c:if test="${sessionScope.adminId == null}">
	<script type="text/javascript">
		alert("권한이 없습니다.");
		history.go(-1);
	</script>
</c:if>



<c:if test="${sessionScope.adminId != null}">
<center><br/><br/>
<h2>공지사항 작성</h2>
<form method="post" action="admin_noticeInsert.nhn">
	<table>
	
		<tr>
			<td>제목:</td> <td><input type="text" name="title" size="48"></td>
		</tr>
		
		<tr>
			<td>내용:</td> <td><textarea name="content" rows="20" cols="50"></textarea></td>
		</tr>
		
		<tr align="center">
			<td colspan="2"><input type="submit" value="작성하기"><input type="reset" value="다시작성"></td>
		</tr>
		
	</table>
</center>
</form>
</c:if>