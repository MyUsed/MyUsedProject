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
	<br/><br/>
		<section class="ac-container">
			<c:forEach var="list" items="${list}" varStatus="i">
				<div>
					<input id="ac-${i.count}" name="accordion-1" type="checkbox" />
					
					<c:if test="${i.count < 10}">
						<label for="ac-${i.count}"><img src="/MyUsed/images/Q.png"/> 0${i.count}. ${list.title} 
							<b class="right">
								<c:if test="${fn:length(list.reg) > 11}">
						    		${fn:substring(list.reg,0,10)}
						    	</c:if>
							</b>
							
						</label>
					</c:if>
					
					<c:if test="${i.count > 9}">
						<label for="ac-${i.count}"><img src="/MyUsed/images/Q.png"/> ${i.count}. ${list.title} 
							<b class="right">
								<c:if test="${fn:length(list.reg) > 11}">
						    		${fn:substring(list.reg,0,10)}
						    	</c:if>
							</b>
						</label>
					</c:if>
					
					<article class="ac-small">
						<img src="/MyUsed/images/A.png"/><div class="center">${list.content}</div> 
					</article>
				</div>
			</c:forEach>
		</section>
</body>
</html>
</c:if>