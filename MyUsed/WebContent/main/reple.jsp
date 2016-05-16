<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2> reple 페이지 </h2> <br/>
글작성자   = ((( ${name} ))) <br/> <br/>
작성 내용  = ((( ${content} ))) <br /> <br />

<c:forEach var="replelist" items="${replelist}"> 

댓글작성자 = ${replelist.name} ///
내용 = ${replelist.content} 

<br />
</c:forEach>