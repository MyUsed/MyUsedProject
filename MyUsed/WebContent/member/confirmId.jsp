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

<script language="javascript">
  function setid()
    {	
    	opener.document.userinput.signup_id.value="${id}";	//id ����
    	opener.document.userinput.signup_idchk.onkeyup="";	//Ű���� �̺�Ʈ ����
		self.close();	//�˾�â �ݱ�
	}

</script>

</head>
<body bgcolor="#E9EAED">
	<center>
	<br />
<c:if test="${check == 1}">
	<font size="3"><b>"${id}" <br /> �̹� ������� ���̵��Դϴ�.</b></font> 
	<br /><br />
	�ٸ� ���̵� �Է��ϼ���
	
	<form name="checkId" action="/MyUsed/confirmId.nhn" method="post">
		
		<input type="text" name="id">
		<br /><br />
		<input type="submit" value="�Է�" class="btn btn-success" style="width:80px">&nbsp;&nbsp;
		<input type="button" value="���" class="btn btn-success" onClick="window.close()" style="width:80px">

	</form>
</c:if>

<c:if test="${check == 0}">
<br /><br />
	<font size="3"><b>"${id}" <br /> ��밡���� ���̵��Դϴ�.</b></font>
	<br /><br />
	<form name="checkId" action="/MyUsed/confirmId.nhn" method="post">
		
		<input type="button" value="�Է�" class="btn btn-success" onClick="setid()" style="width:80px">

	</form>
</c:if>



	</center>
</body>

</html>


