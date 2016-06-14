<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>관리자페이지 로그인</title>

</head>


<body bgcolor="#3B5998">
<div style="position:fixed; width:100%; height:100%; background:#3B5998; ">
<div style="position:absolute; width:100%; height:100%;">
<img src="/MyUsed/images/adminMain.png" width="90%" height="100%">
</div>

<div style="position:absolute; margin-top:280px; margin-left:65%; text-align:right">
	<font style="font-size:300%; font-style:italic;" color="#FFFFFF">
	MyUsed Admin Page
	</font>
</div>

<div style="position:absolute; margin-top:330px; margin-left:75%; text-align:right">
	<br /><br /><br />
	<form action="AdminLogin.nhn" method="post" >
		<input type="text" name="id" placeholder="ID" style="width:250px;" class="form-control"/><br />
		<input type="password" name="pw" placeholder="PASSWARD" style="width:250px;"  class="form-control"/> <br />
		<input type="submit" value="로그인"  class="btn btn-success" />
	</form>
</div>


</div>
</body>
</html>