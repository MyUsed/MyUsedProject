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
		data : { // url 페이지도 전달할 파라미터
			mem_num : mem_num
		},
		success : detail, // 페이지요청 성공시 실행 함수
		error : detailError
	//페이지요청 실패시 실행함수
	});
}
function detail(list) { // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
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
		<td align="center" bgcolor="#D9E5FF"><b>회원번호</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>아이디</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>이름</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>생일</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>성별</b></td>
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