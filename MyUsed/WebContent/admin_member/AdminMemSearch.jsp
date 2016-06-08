<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/member/jquery-1.11.3.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="/MyUsed/member/animate.js"></script>
<script type="text/javascript">

function detailInfo(mem_num) {
	$.ajax({
		type : "post",
		url : "/MyUsed/MyUsedDetailInfo.nhn",
		data : { // url �������� ������ �Ķ����
			mem_num : mem_num
		},
		success : detail, // ��������û ������ ���� �Լ�
		error : detailError
	//��������û ���н� �����Լ�
	});
}
function detail(list) { // ��û������ ������������ aaa ������ �ݹ�ȴ�. 
	$("#memDetail").attr('style', 'display:block;');
	$("#memDetail").html(list);
	//console.log(resdata);
}
function detailError() {
	alert("detailError");
}
</script>
</head>

<body>

<form action="ModifyInfo.nhn" method="post">
<table border="1" align="center" width="800">
	<tr>
		<td align="center" bgcolor="#D9E5FF"><b>ȸ����ȣ</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>���̵�</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>�̸�</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>����</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>����</b></td>
	</tr>
	<c:forEach var="searchMem" items="${searchMemList}">
	<tr>
		<td onclick="detailInfo('${searchMem.num}')" style="cursor:pointer;" align="center">${searchMem.num}</td>
		<td onclick="detailInfo('${searchMem.num}')" style="cursor:pointer;" align="center">${searchMem.id}</td>
		<td onclick="detailInfo('${searchMem.num}')" style="cursor:pointer;" align="center">${searchMem.name}</td>
		<td onclick="detailInfo('${searchMem.num}')" style="cursor:pointer;" align="center">${searchMem.birthdate}</td>
		<td onclick="detailInfo('${searchMem.num}')" style="cursor:pointer;" align="center">${searchMem.gender}</td>
	</tr>
	
	</c:forEach>
</table>
</form>


</body></html>