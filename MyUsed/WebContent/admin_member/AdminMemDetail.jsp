<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/member/jquery-1.11.3.js"></script>
<script type="text/javascript">
function openpoint(){
	$('#mpoint1').attr('style', 'display:none;');
	$('#mpoint2').attr('style', 'display:block;');
}

function opengrade(){
	$('#mgrade1').attr('style', 'display:none;');
	$('#mgrade2').attr('style', 'display:block;');
	
}

function modify_point(){
	if(event.keyCode == 13){
		modifyPoint();
	}
}
function modifyPoint() {
	$.ajax({
		type : "post",
		url : "/MyUsed/MyUsedModPoint.nhn",
		data : { // url �������� ������ �Ķ����
			num : '${memDTO.num}',
			point : $("#point_modi").val()
		},
		success : mpoint, // ��������û ������ ���� �Լ�
		error : mpointError
	//��������û ���н� �����Լ�
	});
}
function mpoint(list) { // ��û������ ������������ aaa ������ �ݹ�ȴ�. 
	alert('����Ʈ�� �����Ǿ����ϴ�.');
	$('#mpoint2').attr('style', 'display:none;');
	$('#mpoint1').attr('style', 'display:block;');
	$("#mpoint1").html(list);
	console.log(resdata);
}
function mpointError() {
	alert("mpointError");
}

function modify_grade(){
	if(event.keyCode == 13){
		modifyGrade();
	}
}
function modifyGrade() {
	$.ajax({
		type : "post",
		url : "/MyUsed/MyUsedModGrade.nhn",
		data : { // url �������� ������ �Ķ����
			num : '${memDTO.num}',
			grade : $("#grade_modi").val()
		},
		success : mgrade, // ��������û ������ ���� �Լ�
		error : mgradeError
	//��������û ���н� �����Լ�
	});
}
function mgrade(list) { // ��û������ ������������ aaa ������ �ݹ�ȴ�. 
	alert('����� �����Ǿ����ϴ�.');
	$('#mgrade2').attr('style', 'display:none;');
	$('#mgrade1').attr('style', 'display:block;');
	$("#mgrade1").html(list);
	console.log(resdata);
}
function mgradeError() {
	alert("mgradeError");
}
</script>
</head>

<body>

<table border="1" width="800" align="center">
	<tr>
		<td  height="150" width="150" rowspan="4">
		 	<img src="/MyUsed/images/profile/${profile}" width="150" height="150">
		</td>
		<td colspan="4" align="right">
			<div onclick="close()" style="cursor:pointer;">
			<c:if test="${memDTO.naverid == 0}">
			�Ϲ� ȸ��
			</c:if>
			<c:if test="${memDTO.naverid != 0}">
			���̹� ȸ��
			</c:if>
			</div>
		</td>
	</tr>
	<tr>
		<td width="15%">�̸�</td>
		<td width="30%">${memDTO.name}</td>
		<td width="15%">���̵�</td>
		<td width="30%">${memDTO.id}</td>
	</tr>
	<tr>
		<td width="15%">����</td>
		<td width="30%">${memDTO.birthdate}</td>
		<td width="15%">����</td>
		<td width="30%">${memDTO.gender}</td>
	</tr>
	<tr>
		<td width="15%">����Ʈ</td>
		<td width="30%" onclick="openpoint()" style="cursor:pointer;">
			<div id="mpoint1" style="display:block;">${memDTO.point}</div>
			<div id="mpoint2" style="display:none;">
				<input type="text" name="point_modi" id="point_modi" value="${memDTO.point}" onkeypress="modify_point()">
			</div>
		</td>
		<td width="15%">���</td>
		<td width="30%" onclick="opengrade()">
			<div id="mgrade1" style="display:block;">${memDTO.grade}</div>
			<div id="mgrade2" style="display:none;">
				<input type="text" name="grade_modi" id="grade_modi" value="${memDTO.grade}" onkeypress="modify_grade()">
			</div>
		</td>
	</tr>
</table>

</body></html>