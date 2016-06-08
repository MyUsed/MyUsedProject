<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/member/jquery-1.11.3.js"></script>

<script type="text/javascript">
$(document).ready(function(){		//onload이벤트같은것(시작하자마자 바로 동작)
    $("#categ0").change(function(){
    	if($("#categ0").val() == 0){
    		$("#categ1").attr('style', 'display:none');
    		$("#categ1_1").attr('style', 'display:block');
    		$("#categ1_2").attr('style', 'display:none');
    	}else if($("#categ0").val() == 1){
    		$("#categ1").attr('style', 'display:none');
    		$("#categ1_2").attr('style', 'display:block');
    		$("#categ1_1").attr('style', 'display:none');
    	}else {
    		$("#categ1").attr('style', 'display:block');
    		$("#categ1_2").attr('style', 'display:none');
    		$("#categ1_1").attr('style', 'display:none');
    	}
    });
    
    $("#categ1").change(function(){//전체 
		location.reload();
    });

    $("#categ1_1").change(function(){
    	sortType();
    });
    function sortType(){
        $.ajax({
            type: "post",
            url : "/MyUsed/MyUsedMemInfo_index.nhn",
            data: {	// url 페이지도 전달할 파라미터
            	sort : 'type',
            	categ : $("#categ1_1").val()
            },
            success: sort,	// 페이지요청 성공시 실행 함수
            error: sortError	//페이지요청 실패시 실행함수
     	});
    }
    
    $("#categ1_2").change(function(){
    	sortState();
    });
    function sortState(){
        $.ajax({
            type: "post",
            url : "/MyUsed/MyUsedMemInfo_index.nhn",
            data: {	// url 페이지도 전달할 파라미터
            	sort : 'state',
            	categ : $("#categ1_2").val()
            },
            success: sort,	// 페이지요청 성공시 실행 함수
            error: sortError	//페이지요청 실패시 실행함수
     	});
    }
    function sort(list){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
		$("#sort").attr('style', 'display:block;');
    	$('#sortAll').attr('style', 'display:none;');
        $("#sort").html(list);
        console.log(resdata);
    }
    function sortError(){
        alert("sortError");
    }
    
    $("#sBtn").click(function(){
    	searchMem();
    });
    function searchMem(){
        $.ajax({
            type: "post",
            url : "/MyUsed/MyUsedMemInfo_searchmem.nhn",
            data: {	// url 페이지도 전달할 파라미터
            	mem_num : $("#search").val()
            },
            success: search,	// 페이지요청 성공시 실행 함수
            error: searchError	//페이지요청 실패시 실행함수
     	});
    }
    function search(list){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
		$("#sort").attr('style', 'display:block;');
    	$('#sortAll').attr('style', 'display:none;');
		$("#allBtn").attr('style', 'display:block;');
        $("#sort").html(list);
        console.log(resdata);
    }
    function searchError(){
        alert("searchError");
    }

    $("#allBtn").click(function(){ 
		location.reload();
    });
    
    
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
<h2>* 개인정보 수정 요청 목록 *</h2>

<table border="0" width="800">
	<tr>
		<td width="15%" a align="left">
			<input type="text" id="search" style="width:110px;" placeholder="회원번호">
		</td>
		<td width="5%" align="left">
			<input type="button" id="sBtn" value="검색">
		</td>
		<td width="70%" align="left">
			<input type="button" id="allBtn" value="전체" style="display:none">
		</td>
		<td width="5%" align="right">
			<select id="categ0" name="categ0">
				<option value="null">---분류1---</option>
				<option value="0">타입</option>
				<option value="1">처리</option>
				<option value="2">전체</option>
			</select>
		</td>
		<td width="5%" align="right">
			<select id="categ1">
				<option value="null">---분류2---</option>
				<option value="all">전체</option>
			</select>
			
			<select id="categ1_1" name="categ1_1" style="display:none">
				<option value="null">---분류2---</option>
				<option>name</option>
				<option>id</option>
				<option>birthdate</option>
				<option>gender</option>
			</select>

			<select id="categ1_2" name="categ1_2" style="display:none">
				<option value="null">---분류2---</option>
				<option value="0">미처리</option>
				<option value="1">승인</option>
				<option value="-1">거절</option>
			</select>

			<select id="categ1_2" name="categ1_2" style="display:none">
				<option value="null">---분류2---</option>
				<option value="0">미처리</option>
				<option value="1">승인</option>
				<option value="-1">거절</option>
			</select>
		</td>
	</tr>
</table>

<div id="sortAll" style="display:block;">
<form action="ModifyInfo.nhn" method="post">
<table border="1" align="center" width="800">
	<tr>
		<td align="center" bgcolor="#D9E5FF"><b>회원번호</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>타입</b></td>
		<td align="center" width="50%" bgcolor="#D9E5FF"><b>변경값</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>신청일</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>처리</b></td>
	</tr>
	<c:forEach var="modify" items="${modifyList}">
	
	<script type="text/javascript">
		function viewReason${modify.num}(){
			if(tr${modify.num}.style.display == 'block'){
				$('#tr${modify.num}').attr('style','display:none;');
			}else{
				$('#tr${modify.num}').attr('style','display:block;');
			}
		}
	</script>
	
	<tr>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">${modify.mem_num}</div></td>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">${modify.type}</div></td>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">${modify.changeval}</div></td>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">
		<fmt:formatDate value="${modify.reg}" type="date" /></div></td>
		<td align="center">
		<c:if test="${modify.state == 0}">
			<input type="hidden" value="${modify.num}" name="num">
			<input type="hidden" value="${modify.mem_num}" name="mem_num">
			<input type="hidden" value="${modify.type}" name="type">
			<input type="hidden" value="${modify.changeval}" name="changeval">
			<input type="submit" value="승인">
			<input type="button" value="거절" onclick="document.location.href='/MyUsed/ModifyReject.nhn?num=${modify.num}&type=${modify.type}&mem_num=${modify.mem_num}'">
		</c:if>
		<c:if test="${modify.state == 1}">
			<font color="blue"><b>승인</b></font>			
		</c:if>
		<c:if test="${modify.state == -1}">
			<font color="red"><b>거절</b></font>
		</c:if>
		</td>
	</tr>
	
	<tr id="tr${modify.num}" style="display:none;">
		<td colspan="4">${modify.reason}</td>
	</tr>
	
	</c:forEach>

</table>
</form>
</div>


<div id="sort" style="display:block;"></div>








</center>
</body>
</html>