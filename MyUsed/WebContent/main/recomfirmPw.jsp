<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />

<title>��й�ȣ Ȯ��</title>
<style type="text/css">
		
</style>

<script language="javascript">
  function comfrimpw(){
	  
	  if('${memDTO.password}' == pw.value){
			alert('��й�ȣ Ȯ���� �Ϸ�Ǿ����ϴ�');
	    	opener.document.userinput.signup_pw.onfocus="";	//��Ŀ�� �̺�Ʈ ����
			self.close();	//�˾�â �ݱ�
	  }else{
			alert('��й�ȣ�� �ٽ� Ȯ�����ּ���');
	  }
  }

</script>

</head>
<body bgcolor="#E9EAED">
	<br />
	<table border="0" align="center">
		<tr>
			<td colspan="2" align="center">
				<img src="/MyUsed/images/profile/${sessionproDTO.profile_pic}" width="150" height="150" style="margin-bottom:5px;">
			</td>
		</tr>
		<tr height="60px">
			<td colspan="2" align="center">
				<font style="font-size:130%; font-weight:bold;">
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${memDTO.num}">${memDTO.name}</a>
				���� �����ʴϱ�?
				</font><br />
				��й�ȣ�� �Է����ּ���.
			</td>
		</tr>
		<tr height="20px">
			<td align="left">
				<input type="text" value="${memDTO.id}" style="width:210px" class="signup_input">
			</td>
		</tr>
		<tr height="30px">
			<td align="left">
				<input type="password" id="pw"  style="width:210px" class="signup_input" placeholder="��й�ȣ�� �Է��ϼ���">
			</td>
		</tr>
		<tr height="45px">
			<td align="center">
			<input type="button" onclick="comfrimpw()" value="Ȯ  ��" class="btn btn-success" style="width:150px">
			</td>
		</tr>
	</table>
</body>

</html>


