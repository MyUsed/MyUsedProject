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
		<link rel="stylesheet" type="text/css" href="accordian/css/style.css" />
		<script type="text/javascript" src="/accordian/js/modernizr.custom.29473.js"></script>
		<script type="text/javascript" src="/accordian/js/accordian.js"></script>	
	</head>

<body>
<h3>�Ű��ϱ�</h3>
	<c:if test="${count3 == 0}">
    		�Խñ��� �����ϴ�. <br /><br/>
    	<input type="button" value ="�۾���" onclick="location.href='/MyUsed/Reportwirte.nhn'"/>
    
	</c:if>
	<c:if test="${count3 != 0}">
										<table  width="500">
						<tr border="0">
							<td align="right"><a onclick="location.href='/MyUsed/Report1.nhn'">�ڼ��� ����</a></td>
						</tr>
				     </table>
				<table border="1" width="500" height="20">
					<tr bgcolor="#3B5998">
						<th width="20"><font color="#fffff">��ȣ</font></th>
						<th width="130">����</th>
						<th width="60">��ȸ��</th>
						<th width="60">�ۼ���</th>
						<th width="60">�ۼ���</th>
					</tr> 
				</table>
				<c:forEach var="list3" items="${list3}" varStatus="i">
					<table border="1" width="500" height="20">
					<tr>
						<td width="20">${list3.seq_num}</td>
						<td width="130">${list3.title}</td>
						<td width="60">${list3.readcount}</td>
						<td width="60">${list3.mem_id}</td>
						<td width="60"><c:if test="${fn:length(list3.reg) > 11}">
								${fn:substring(list3.reg,0,10)}
							</c:if> </td>
					</tr>
					</table>
				</c:forEach>
	</c:if>
</body>
</html>
</c:if>