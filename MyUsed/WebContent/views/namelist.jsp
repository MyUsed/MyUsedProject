<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<select name="select" multiple="multiple" size="23" style="width:150px; cursor:pointer;" onchange="window.open(this.value);">
		<c:forEach var="list" items="${list}">
		
			<c:if test="${name == list.name}">
				<option value="paperchatForm.nhn?mynum=${mynum}&name=${list.id}">*${list.name}(${list.id})*</font>
			</c:if>
			
			<c:if test="${name != list.name}">
				<option value="paperchatForm.nhn?mynum=${mynum}&name=${list.id}">${list.name}(${list.id})</option>
			</c:if>
			
		</c:forEach>
	</select>
