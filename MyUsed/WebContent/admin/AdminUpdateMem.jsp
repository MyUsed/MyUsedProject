<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<body>

<h2> </h2>

<form action="AdminUpdateCheck.nhn" method="post">
<table border="1"  bgcolor="#A6A6A6">
	<tr align="center">
	<td><strong>ID</strong></td><td><strong>NAME</strong></td>
	<td><strong>GRADE</strong></td><td><strong>PART</strong></td><td><strong>CHECK</strong></td>
	</tr>
	 <tr>
	 <td>${adminDTO.id}</td>
	 <td>${adminDTO.name}</td>
	 
	 <td>
	 <select name="grade">
		<option>${adminDTO.grade}</option>
		<option>Master</option>
		<option>����</option>
		<option>����</option>
		<option>�븮</option>
	</select>
	</td>
	<td>
	<select name="part">
		<option>${adminDTO.part}</option>
		<option>ȸ������</option>
		<option>����������</option>
		<option>�Խñ۰���</option>
		<option>��۰���</option>
		<option>�������</option>
		<option>�����Ͱ���</option>
	</select>
	 </td>  
	 <td><input type="submit" value="Ȯ��"/></td>
	 </tr>
</table>

<input type="hidden" value="${adminDTO.seq_num}" name="seq_num"/>

</form>
</body>
</html>