<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>

<c:if test="${sessionScope.adminId == null}">
	<script type="text/javascript">
		alert("권한이 없습니다");
		history.go(-1);
	</script>
</c:if>

<c:if test="${sessionScope.adminId != null}">
<html>
	<head>
		<meta charset="euc-kr" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<meta name="description" content="Accordion with CSS3" />
		<meta name="keywords" content="accordion, css3, sibling selector, radio buttons, input, pseudo class" />
		<meta name="author" content="Codrops" />
		<link rel="stylesheet" type="text/css" href="accordian/css/style.css" />
		<script type="text/javascript" src="/accordian/js/modernizr.custom.29473.js"></script>
		<script type="text/javascript" src="/accordian/js/accordian.js"></script>	
	</head>
<body>

</body>
</html>
</c:if>