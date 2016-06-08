<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/member/jquery-1.11.3.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	 $("#sBtn").click(function(){
		 sortSearch();
	 });
	 function sortSearch(){
	        $.ajax({
	            type: "post",
	            url : "/MyUsed/MyUsedMemReport_index.nhn",
	            data: {	// url 페이지도 전달할 파라미터
	            	sort : $("#categ").val(),
	            	word : $("#search").val()
	            },
	            success: sort,	// 페이지요청 성공시 실행 함수
	            error: sortError	//페이지요청 실패시 실행함수
	     	});
	    }
	    function sort(list){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
			$("#report").attr('style', 'display:block;');
	    	$('#reportAll').attr('style', 'display:none;');
	        $("#report").html(list);
	        console.log(resdata);
	    }
	    function sortError(){
	        alert("sortError");
	    }
	$("#allBtn").click(function() {//전체 
			location.reload();
		});

	
	
	$("#reason").change(function() {
		sortReason();
	});
		function sortReason() {
			$.ajax({
				type : "post",
				url : "/MyUsed/MyUsedMemReport_reason.nhn",
				data : { // url 페이지도 전달할 파라미터
					re_num : $("#reason").val()
				},
				success : sortreason, // 페이지요청 성공시 실행 함수
				error : sortreasonError
			//페이지요청 실패시 실행함수
			});
		}
		function sortreason(list) { // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
			$("#report").attr('style', 'display:block;');
			$('#reportAll').attr('style', 'display:none;');
			$("#report").html(list);
			console.log(resdata);
		}
		function sortreasonError() {
			alert("sortreasonError");
		}

	});
</script>
	 	

<title> 관리자 페이지 </title>
</head>
<body>
	
<!---------------------- 작업할때 2개만 include 해서 사용 ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->
<center>
<h2>* 신고 계정 관리 *</h2>



<table border="0" width="800">
	<tr>
		<td width="5%" align="right">
			<select id="categ" name="categ">
				<option value="null">---분류---</option>
				<option value="mem_num">회원번호</option>
				<option value="name">이름</option>
			</select>
		</td>
		<td width="15%" a align="left">
			<input type="text" id="search" style="width:110px;" placeholder="검색어">
		</td>
		<td width="5%" align="left">
			<input type="button" id="sBtn" value="검색">
		</td>
		<td width="70%" align="left">
			<input type="button" id="allBtn" value="전체">
		</td>
		<td width="5%" align="right">
			<select id="reason" name="reason">
				<option value="null">-------------------------사유-------------------------</option>
				<c:forEach var="reason" items="${reasonList}">
					<option value="${reason.re_num}">${reason.re_reason}</option>
				</c:forEach>
					<option value="0">기타</option>
			</select>
		</td>
	</tr>
</table>

<div id="reportAll" style="display:block;">
<table border="1" align="center" width="800">
	<tr>
		<td align="center" width="10%"  bgcolor="#D9E5FF"><b>회원번호</b></td>
		<td align="center" width="15%" bgcolor="#D9E5FF"><b>이름</b></td>
		<td align="center" width="60%" bgcolor="#D9E5FF"><b>사유</b></td>
		<td align="center" width="15%" bgcolor="#D9E5FF"><b>날짜</b></td>
	</tr>
	
	<c:forEach var="report" items="${reportList}">
	<tr>
		<td align="center">${report.mem_num}</td>
		<td align="center">${report.name}</td>
		<td align="center">${report.reason}</td>
		<td align="center"><fmt:formatDate value="${report.reg}" type="date" /></td>
	</tr>
	</c:forEach>
</table>
</div>


<div id="report" style="display:none;"></div>



</center>
</body>
</html>