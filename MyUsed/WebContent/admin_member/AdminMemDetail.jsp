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
		data : { // url 페이지도 전달할 파라미터
			num : '${memDTO.num}',
			point : $("#point_modi").val()
		},
		success : mpoint, // 페이지요청 성공시 실행 함수
		error : mpointError
	//페이지요청 실패시 실행함수
	});
}
function mpoint(list) { // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
	alert('포인트가 수정되었습니다.');
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
		data : { // url 페이지도 전달할 파라미터
			num : '${memDTO.num}',
			grade : $("#grade_modi").val()
		},
		success : mgrade, // 페이지요청 성공시 실행 함수
		error : mgradeError
	//페이지요청 실패시 실행함수
	});
}
function mgrade(list) { // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
	alert('등급이 수정되었습니다.');
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
			일반 회원
			</c:if>
			<c:if test="${memDTO.naverid != 0}">
			네이버 회원
			</c:if>
			</div>
		</td>
	</tr>
	<tr>
		<td width="15%">이름</td>
		<td width="30%">${memDTO.name}</td>
		<td width="15%">아이디</td>
		<td width="30%">${memDTO.id}</td>
	</tr>
	<tr>
		<td width="15%">생일</td>
		<td width="30%">${memDTO.birthdate}</td>
		<td width="15%">성별</td>
		<td width="30%">${memDTO.gender}</td>
	</tr>
	<tr>
		<td width="15%">포인트</td>
		<td width="30%" onclick="openpoint()" style="cursor:pointer;">
			<div id="mpoint1" style="display:block;">${memDTO.point}</div>
			<div id="mpoint2" style="display:none;">
				<input type="text" name="point_modi" id="point_modi" value="${memDTO.point}" onkeypress="modify_point()">
			</div>
		</td>
		<td width="15%">등급</td>
		<td width="30%" onclick="opengrade()">
			<div id="mgrade1" style="display:block;">${memDTO.grade}</div>
			<div id="mgrade2" style="display:none;">
				<input type="text" name="grade_modi" id="grade_modi" value="${memDTO.grade}" onkeypress="modify_grade()">
			</div>
		</td>
	</tr>
</table>

</body></html>