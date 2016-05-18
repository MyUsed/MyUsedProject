<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2> test ÆäÀÌÁö </h2> <br/>

${reple}

<c:forEach var="replelist" items="${replelist}">
${replelist.content} <br />
</c:forEach>

