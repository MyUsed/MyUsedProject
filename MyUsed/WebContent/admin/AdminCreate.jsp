<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<strong>* ������ ���� ���� *</strong> <br/> <br />
	
	
	<form action="AdminCreate.nhn" method="post">
	
	<select name="grade">
		<option>-�����ڵ��-</option>
		<option>Master</option>
		<option>����</option>
		<option>����</option>
		<option>�븮</option>
	</select>
	<select name="part">
		<option>-�μ�-</option>
		<option>ȸ������</option>
		<option>����������</option>
		<option>�Խñ۰���</option>
		<option>��۰���</option>
		<option>�������</option>
		<option>�����Ͱ���</option>
	</select>
	
	<br/>
	<input type="text" name="id"  placeholder="ID"/> <br/>
	<input type="text" name="pw"  placeholder="PASSWORD"/> <br/>
	<input type="text" name="name"  placeholder="NAME"/> <br/> <br/>
	<input type="submit" value="�����ϱ�"/>
	
	</form>
	



</body>
</html>