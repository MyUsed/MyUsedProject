<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>관리자 관리 페이지 </title>
<script src="/MyUsed/admin/adminAjax.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>

// 검색 ajax

function SearchAjax(){
	
	$('#AdminSearchReturn').attr('style', 'display:block');
	
    $.ajax({
        type: "post",
        url : "AdminSearch.nhn",
        data: {
        	grade : $('#grade').val(),
        	part : $('#part').val(),
        	search : $('#search').val(),
        	ser : $('#ser').val()
        	
        },
        success: search,	// 페이지요청 성공시 실행 함수
        error: whenError	//페이지요청 실패시 실행함수
 	});
}
function search(bbb){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
    $("#AdminSearchReturn").html(bbb);
    console.log(resdata);
}
function whenError(){
    alert("Error");
}

</script>
</head>
<body>

<!---------------------- 작업할때 2개만 include 해서 사용 ------------------------------->
<div id="AdminTop"><jsp:include page="AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->


		<br /> <br />
	<center>
	
	<input type="button" value="관리자 계정생성" onclick="createAjax();" /> 
	<input type="button" value="관리자 등급조정" onclick="updateAjax();"/> 
	<input type="button" value="관리자 계정삭제" onclick="deleteAjax();"/> <br />
	
	
		<br /> <br />
		
	 <!-- create 계정생성 Ajax -->
	 <div id="createReturn"></div>
	 
	  <!-- create 계정삭제 Ajax -->
	 <div id="deleteReturn"></div>
	 	 
	  <!-- create 계정수정 Ajax -->
	 <div id="updateReturn"></div>
	 
	 <!-- search 결과 -->
	 <div id="AdminSearchReturn" style="display:block;"></div>
		
	 <br/>
	 
	 
	 <div id="adminlist" style="display:block;">
	 				 
	 				<h2><strong>* 관리자 목록 * </strong></h2>
	 <table border="1" >
	
	 <tr align="center">
   		<td><strong>ID</strong></td><td><strong>PW</strong></td><td><strong>NAME</strong></td>
   		<td><strong>GRADE</strong></td><td><strong>PART</strong></td><td><strong>DATE</strong></td>
   	</tr>
  		
	 	<c:forEach var="list" items="${list}">
	 <tr>
	 		<td>${list.id}</td> 
	 		<td>${list.pw}</td>
	 		<td>${list.name}</td> 
	 		<td>${list.grade}</td>
	 		<td>${list.part}</td>
	 		<td><fmt:formatDate value="${list.reg}" type="date" /></td>
	  </tr>
	 	</c:forEach>
	
	 
	 
	 </table>
	 <br />
	 
	 
	 
	 <select id="grade" name="grade" >
		<option value="null">-관리자등급-</option>
		<option>Master</option>
		<option>팀장</option>
		<option>과장</option>
		<option>대리</option>
	</select>
	<select id="part" name="part" >
		<option value="null">-부서-</option>
		<option>회원관리</option>
		<option>페이지관리</option>
		<option>게시글관리</option>
		<option>배송관리</option>
		<option>광고관리</option>
		<option>고객센터관리</option>
	</select>
	
	 
	 </div>
	 <script>

		 </script>
	 
	 <select id="ser">
	 <option value="null">선택</option>
	 <option value="id">ID</option>
	 <option value="name">NAME</option>
	 </select>   
	 <input type="text"  id="search" name="search" size="14"/>
	 <input type="button" value="검색" onclick="SearchAjax();" /> 
	 
	 
	</center>

	


</body>
</html>