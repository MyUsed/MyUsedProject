<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>���� �ɻ� ������</title>
</head>
<body>

<!---------------------- �۾��Ҷ� 2���� include �ؼ� ��� ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->
<center>
	
	<h2>* ${applyDTO.hostname} *</h2>
	
	
		<table width="800" height="500">
		
			<tr>
			<td colspan="2" height="10" align="center">
				<strong>���� ����</strong>
			</td>
			</tr>
			<tr>
			
			<td rowspan="2" align="center">
			<img src="${applyDTO.img}" width="250" height="400"/>
			</td>
			<td align="center">
			<strong>${applyDTO.hostname}</strong><br/>
		    ${applyDTO.name} <br/>
		    ${applyDTO.ph}<br/>
		    ${applyDTO.email}<br/>

		    <a href="http://${applyDTO.url}">http://${applyDTO.url}</a>
			</td>
			
			</tr>
			<tr>
			
			<td align="center">
						<strong> ���� </strong> <br /><br/><br/>
				${applyDTO.content}
			
			</td>
			
			
			</tr>
			
		</table>
	
		
	
	

</center>

</body>
</html>