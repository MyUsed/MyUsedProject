<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />

<title>������ �̹��� ��� ����</title>
<style type="text/css">
		
</style>

</head>
<body bgcolor="#E9EAED">
	<center>
	<br /><br />
	
	<form name="deleteAll" action="/MyUsed/MyUsedDeleteAllPro.nhn" method="get">
		<font size="4"><b>���� �����Ͻðڽ��ϱ�?</b></font> 
		<br />������ �̹����� ������ �� �����ϴ�.
		
		<br /><br /><br />
		<input type="hidden" name="mem_num" value="${mem_num}" class="btn btn-success" >
		<input type="submit" value="Ȯ��" class="btn btn-success" style="width:80px">&nbsp;&nbsp;
		<input type="button" value="���" class="btn btn-success" onClick="window.close()" style="width:80px">


	</form>




	</center>
</body>

</html>





<%-- <meta http-equiv="Refresh" content="0;url=/MyUsed/MyUsedMyPage.nhn?mem_num=${mem_num}">
 --%>
