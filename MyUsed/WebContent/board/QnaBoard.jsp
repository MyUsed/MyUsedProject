<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<c:if test="${sessionScope.memId == null}">
	<script type="text/javascript">
		alert("�α��� �Ŀ� �̿��Ͻ� �� �ֽ��ϴ�.");
		history.go(-1);
	</script>
</c:if>
<c:if test="${sessionScope.memId != null}">
<html>
	<head>	
		<meta charset="euc-kr" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<meta name="description" content="Accordion with CSS3" />
		<meta name="keywords" content="accordion, css3, sibling selector, radio buttons, input, pseudo class" />
		<meta name="author" content="Codrops" />
		<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
		<link rel="stylesheet" type="text/css" href="accordian/css/style.css" />
		<script type="text/javascript" src="/accordian/js/modernizr.custom.29473.js"></script>
		<script type="text/javascript" src="/accordian/js/accordian.js"></script>	
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<title>Qna_Board</title>
	</head>

<body>
<div id="layer_fixed"><jsp:include page="/board/layer_fixed.jsp"/></div>
<div id="sidebannerL"><jsp:include page="/board/bdsidebannerL.jsp" /></div> <!-- ���̵��� Left -->
<div id="csearch"></div>
	<c:if test="${count == 0}">
    		�Խñ��� �����ϴ�. <br /><br/>
    <input type="button" value ="�۾���" onclick="location.href='/MyUsed/Reportwirte.nhn'"/>
    <input type="button" value ="�ڷ�" onclick="location.href='/MyUsed/board.nhn'"/>
	</c:if>
	<c:if test="${count > 0}">
	<br/><br/>
	<h2>Q&A</h2>
	<section class="ac-container">
			<c:forEach var="list" items="${list}" varStatus="i">	
				<div >
					<input id="ac-${i.count}" name="accordion-1" type="checkbox" />
					<label for="ac-${i.count}"><img src="/MyUsed/images/Q.png"/>&nbsp&nbsp&nbsp&nbsp&nbsp 0${i.count}. ${list.title}
						<b class="right">
							<c:if test="${fn:length(list.reg) > 11}">
								${fn:substring(list.reg,0,10)}
							</c:if>
						</b>
					</label>	
						<article class="ac-small">
							<img src="/MyUsed/images/A.png"/><div class="center">${list.contents}</div> 
						</article>
				</div>
			</c:forEach>	
		</section>	
	</c:if>
</body>
</html>
</c:if>