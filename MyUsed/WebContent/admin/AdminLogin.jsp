<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>관리자페이지 로그인</title>

<script type="text/javascript">
	window.moveTo(0,0)
	window.resiteTo(300,600)
</script>

</head>




<body bgcolor="#3B5998">

	<center>
	
	<br/><br/><br/> 
		<strong>관리자페이지</strong> <br/><br/>
	<form action="AdminLogin.nhn" method="post" >
		<input type="text" name="id" placeholder="ID"/> <br />
		<input type="password" name="pw" placeholder="PASSWARD" /> <br /><br/>
		<input type="submit" value="로그인"  />
	</form>
	</center>



</body>
</html>