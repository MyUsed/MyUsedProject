<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div style="font-weight:90%">
<br /><br /><br />
<c:forEach var="viewCateg" items="${viewCategList}">
	<a href="/MyUsed/MyUsedProductView.nhn?categ=${viewCateg.categ}&currentPage=1"
		onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
		${viewCateg.categ}
	</a>
	<br />
</c:forEach>
</div>