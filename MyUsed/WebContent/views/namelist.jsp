<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<select name="select" multiple="multiple" size="22" style="width:150px; cursor:pointer; background-color: #EAEAEA; border:1px solid #B4B4B4; border-width:1px;" onchange="window.open(this.value, 'asd', 'width=600, height=400');">
		<c:forEach var="list" items="${list}">
		
			<c:if test="${name == list.name}">
				<option value="paperFormnew.nhn?mynum=${mynum}&name=${list.id}">*${list.name}(${list.id})*</font>
			</c:if>
			
			<c:if test="${name != list.name}">
				<option value="paperFormnew.nhn?mynum=${mynum}&name=${list.id}">${list.name}(${list.id})</option>
			</c:if>
			
		</c:forEach>
	</select>
