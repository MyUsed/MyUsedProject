<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<%-- <c:forEach var="all" items="${all}">
${all.mem_num} ${all.name}  ${all.count} <br />
</c:forEach> --%>



<style type="text/css">		  
#index { position:relative; 
			  width:110px; 
			  height:110px;  
			  margin-top:40px; 
			  margin-left:10px;
			  background:#FFB2F5;
			  float:left;}  
</style>

<c:forEach begin="1" step="1" end="5">
	<div id="index">
	</div>
</c:forEach>