<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>QNA_Board</title>
</head>
<body>
	<h1>QNA �Խ���</h1>
	<form action="/MyUsed/QnamodifyPro.nhn" method="post">
	<table border="1" style="width:500px;">
		<tr>
			<td>��ȣ</td><td>${contents.seq_num}</td>
			<td>ID</td><td>${contents.mem_id}</td>
		</tr>
		<tr>
			<td colspan="1">����</td><td><input type="text" name="title" value="${contents.title}"/></td>
			<td>��ȸ��</td><td>${contents.count}</td>
		</tr>
		<tr>	
			<td colspan="4" align="center">���� </td>
		</tr>
		<tr>	
			<td colspan="4"><textarea name="contents" cols="30" style="width:99%; value="${contents.contents}"></textarea></td>	
		</tr>
	</table>
	<input type="submit" value="����"/>
	<input type="reset" value="�ٽ��ۼ�"/>
	<input type="button" value="�ڷ�" onclick="history.go(-1)"/>
	</form>
</body>
</html>