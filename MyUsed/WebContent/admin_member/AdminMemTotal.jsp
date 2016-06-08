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

	/*새로고침*/
	$("#reload").click(function(){ 
		location.reload();
	});
	
	/* 분류별 검색 */
	 $("#sBtn").click(function(){
		 searchMember();
	    });
	    function searchMember(){
	        $.ajax({
	            type: "post",
	            url : "/MyUsed/MyUsedSearchMem.nhn",
	            data: {	// url 페이지도 전달할 파라미터
	            	categ : $("#categ").val(),
	            	word : $("#word").val()
	            },
	            success: search,	// 페이지요청 성공시 실행 함수
	            error: searchError	//페이지요청 실패시 실행함수
	     	});
	    }
	    function search(list){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
	        $("#query").html(list);
	        console.log(resdata);
	    }
	    function searchError(){
	        alert("searchError");
	    }
	    
	/* 등급별 */
	$("#grade").change(function() {
			searchgrade();
		});
		function searchgrade() {
			$.ajax({
				type : "post",
				url : "/MyUsed/MyUsedGrade.nhn",
				data : { // url 페이지도 전달할 파라미터
					grade : $("#grade").val()
				},
				success : grade, // 페이지요청 성공시 실행 함수
				error : gradeError
			//페이지요청 실패시 실행함수
			});
		}
		function grade(list) { // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
			$("#query").html(list);
			console.log(resdata);
		}
		function gradeError() {
			alert("gradeError");
		}

		/* 포인트 */
		$("#point").change(function() {
			pointSort();
		});
		function pointSort() {
			$.ajax({
				type : "post",
				url : "/MyUsed/MyUsedPoint.nhn",
				data : { // url 페이지도 전달할 파라미터
					point : $("#point").val()
				},
				success : point, // 페이지요청 성공시 실행 함수
				error : pointError
			//페이지요청 실패시 실행함수
			});
		}
		function point(list) { // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
			$("#query").html(list);
			console.log(resdata);
		}
		function pointError() {
			alert("pointError");
		}
		
	/* 네이버 */
	$("#naver").change(function() {
		naverMem();
	});
	function naverMem() {
		$.ajax({
			type : "post",
			url : "/MyUsed/MyUsedNaver.nhn",
			data : { // url 페이지도 전달할 파라미터
				naverid : $("#naver").val()
			},
			success : naver, // 페이지요청 성공시 실행 함수
			error : naverError
		//페이지요청 실패시 실행함수
		});
	}
	function naver(list) { // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
		$("#query").html(list);
		console.log(resdata);
	}
	function naverError() {
		alert("naverError");
	}

/* 접속구분 */
$("#onoff").change(function() {
	onoffMem();
});
function onoffMem() {
	$.ajax({
		type : "post",
		url : "/MyUsed/MyUsedOnoff.nhn",
		data : { // url 페이지도 전달할 파라미터
			onoff : $("#onoff").val()
		},
		success : onoff, // 페이지요청 성공시 실행 함수
		error : onoffError
	//페이지요청 실패시 실행함수
	});
}
function onoff(list) { // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
	$("#query").html(list);
	console.log(resdata);
}
function onoffError() {
	alert("onoffError");
}


/* 성별구분 */
$("#gender").change(function() {
	genderSort();
});
function genderSort() {
	$.ajax({
		type : "post",
		url : "/MyUsed/MyUsedGender.nhn",
		data : { // url 페이지도 전달할 파라미터
			gender : $("#gender").val()
		},
		success : gender, // 페이지요청 성공시 실행 함수
		error : genderError
	//페이지요청 실패시 실행함수
	});
}
function gender(list) { // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
	$("#query").html(list);
	console.log(resdata);
}
function genderError() {
	alert("genderError");
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
<h2>* 회원 정보 토탈 *</h2>

<table border="0" width="800" bgcolor="#EAEAEA" style="border:2px double #747474;">
	<tr>
		<td colspan="6">
			<select id="categ" name="categ">
				<option value="null">---분류---</option>
				<option value="num">회원번호</option>
				<option value="id">아아디</option>
				<option value="name">이름</option>
			</select>
			<input type="text" id="word" style="width:200px;" placeholder="검색어">
			<input type="button" value="검색" id="sBtn">
		</td>
	</tr>
	<tr>
		<td align="center">
			<select id="grade" name="grade" style="width:126px;">
				<option value="null">---등급별---</option>
				<c:forEach var="i" begin="1" end="5">
					<option value="${i}">${i}등급</option>
				</c:forEach>
			</select>
			
			<select id="point" name="point" style="width:126px;">
				<option value="null">---포인트---</option>
				<option value="desc">높은순서</option>
				<option value="asc">낮은순서</option>
			</select>

			<select id="naver" name="naver" style="width:126px;">
				<option value="null">---회원구분---</option>
				<option value="0">일반회원</option>
				<option value="1">네이버회원</option>
			</select>

			<select id="onoff" name="onoff" style="width:126px;">
				<option value="null">---접속구분---</option>
				<option value="1">접속회원</option>
				<option value="0">비접속회원</option>
			</select>

			<select id="gender" name="gender" style="width:126px;">
				<option value="null">---성별구분---</option>
				<option value="M">남성</option>
				<option value="F">여성</option>
				<option value="U">기타</option>
			</select>

			<input type="button" id="reload" value="새로고침" style="width:115px;">
		</td>
	</tr>
</table>


<div id="memDetail" style="display:none"></div>
<div id="query"></div>







</center>
</body>
</html>