<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>QnaWrite</title>
</head>
<body>
	<h1>QNA �Խ���</h1>
	<form action="/MyUsed/QnaWritePro.nhn?qna_ref=${qna_ref}" method="post">
	<table border="1" style="width:500px;"">
		<tr>
			<td>ID</td><td>${sessionid}</td>
		</tr>
		<tr><td>���� </td><td><input type="text" name="title"/></td>
		</tr>
		<tr><td>��й�ȣ</td><td><input type="text" name="pw"></td>
		</tr>
		<tr>
			<td colspan="2"><textarea name="contents" cols="30" style="width:99%;"></textarea></td>
		</tr>
	</table>
	<input type="button" value="�ڷ�" onclick="history.go(-1)"/>
	<input type="reset" value="�ٽ��ۼ�"/>
	<input type="submit" value="����"/>
	</form>
</body>
</html>