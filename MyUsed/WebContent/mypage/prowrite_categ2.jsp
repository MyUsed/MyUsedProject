<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<select name="categ1" id="categ1">
	<option>--------2차--------</option>
	<c:forEach var="categ" items="${categList}">
		<option>${categ.categ}</option>
	</c:forEach>
</select>
<input type="hidden" value="${categ0}">	<!-- 1차로 선택한 카테고리 -->