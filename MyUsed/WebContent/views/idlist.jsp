<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<select multiple="multiple" size="22">
		<c:forEach var="list" items="${list}">
			<option>${list.id}	</option>
		</c:forEach>			
	</select>
		
