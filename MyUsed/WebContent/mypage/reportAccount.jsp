<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />
<script src="/MyUsed/mypage/MyPageScript.js"></script>
<title>�Ű�</title>
</head>
<body>

<div style="width:100%; height:100%; text-align:center; padding-top:5%;">

<form action="/MyUsed/ReportAccountPro.nhn" method="get">
	<font size="3"><b>
	<a onclick="window.open('/MyUsed/MyUsedMyPage.nhn?mem_num=${frimemDTO.num}')" style="cursor:pointer;">
	${frimemDTO.name}</a>
	���� �Ű��Ͻðڽ��ϱ�?</b></font>
	<br /><br />

	<div style="width:70%; text-align:left; margin-left:15%">
	<c:forEach var="reasons" items="${reasons}">
		<input type="radio" value="${reasons.re_reason}" id="dbreason" name="reason">${reasons.re_reason}<br />
	</c:forEach>
		<input type="radio" onfocus="alert('��Ÿ ������ �ۼ��ϼ���')" id="etcreason" name="reason">��Ÿ
		<!-- <input type="text" name="reason" style="width:250px;" placeholder="��Ÿ ����"> -->
	</div>
	
	
	<br/>
	<input type="hidden" value="${mem_num}" name="mem_num">
	<input type="hidden" value="${frimemDTO.name}" name="name">
	<input type="submit" value="�Ű�" style="width:70px;" class="btn btn-success">&nbsp;&nbsp;
	<input type="submit" value="���" style="width:70px;" onclick="self.close()"  class="btn btn-success">
</form>
</div>

</body>
</html>