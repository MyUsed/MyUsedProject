<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2> reple ������ </h2> <br/>
���ۼ���   = ((( ${name} ))) <br/> <br/>
�ۼ� ����  = ((( ${content} ))) <br /> <br />

<c:forEach var="replelist" items="${replelist}"> 

����ۼ��� = ${replelist.name} ///
���� = ${replelist.content} 

<br />
</c:forEach>