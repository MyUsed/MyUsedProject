<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>광고 심사 페이지</title>
</head>
<body>

<!---------------------- 작업할때 2개만 include 해서 사용 ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->
<center>
	
	<h2>* ${applyDTO.hostname} *</h2>
	
	
		<table width="800" height="500">
		
			<tr>
			<td colspan="2" height="10" align="center">
				<strong>광고 정보</strong>
			</td>
			</tr>
			<tr>
			
			<td rowspan="2" align="center"> <br/>
			<img src="/MyUsed/images/${applyDTO.img}" width="250" height="400"/>
			<br /><br />
			<a href="bannerInsert.nhn?img=${applyDTO.img}&url=${applyDTO.url}">
			<img src="/MyUsed/images/adminCheck.PNG" width="50" height="40" title="메인에 등록하기" style='cursor:pointer;'/>
			</a>
			</td>
			<td align="center">
			<a href="updateState.nhn?seq_num=${applyDTO.seq_num}">
			<img src="/MyUsed/images/passIcons.PNG" width="50" height="50" title="승인하기" style='cursor:pointer;'> <br/>
			</a>
			<strong>${applyDTO.hostname}</strong><br/><br/>
		    ${applyDTO.name} <br/>
		    ${applyDTO.ph}<br/>
		    <a href="https://mail.naver.com/?n=1464659172432&v=f#%7B%22fClass%22%3A%22write%22%2C%22oParameter%22%3A%7B%22orderType%22%3A%22new%22%2C%22sMailList%22%3A%22%22%7D%7D">${applyDTO.email}</a><br/>

		    <a href="http://${applyDTO.url}">http://${applyDTO.url}</a>
			</td>
			
			</tr>
			<tr>
			
			<td align="center">
						<strong> 내용 </strong> <br /><br/><br/>
				${applyDTO.content}
			
			</td>
			
			
			</tr>
			
		</table>
	
		
	
	

</center>

</body>
</html>