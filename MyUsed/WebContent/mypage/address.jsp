<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>주소록</title>
</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/MyUsed/product/productScript.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/MyUsed/mypage/address.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />

	<script>
	function deleteCheck(){
               if(confirm("정말로 삭제하시겠습니까?") == true){

               } 	else{
               	event.preventDefault();
             		  }
               }
      
	</script>


<body>



    
<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->
<div id="detailViewback"></div>


<div id="detailView">
	


   	<div id="detailimg">
  	<br/>
  	<form action="addrInsert.nhn" method="post" >
  			
  			<input type="hidden" name="num" value="${num}"/>
  			
  	
  			  <hr width=100% />
  	<font color="#747474"><strong>* 주소록 관리 *</strong></font>  
  			  <hr width=100% />
  	
   			<input type="text" id="sample6_postcode" name ="addrNum" placeholder="우편번호">
			<img src="/MyUsed/images/AddressSearch.PNG" onclick="sample6_execDaumPostcode()" width="33" height="33" border="0" style='cursor:pointer;' title="우편번호찾기"><br />
			<input type="text" id="sample6_address" name="addr" placeholder="주소" size="50"><br /><br/>
			<input type="text" id="sample6_address2" name="addrr" placeholder="상세주소" size="60"> <br/> <br/>
			
			<input type="text" id="name" name="name" placeholder="받으실분"/>
			<input type="text" id="ph" name="ph" placeholder="핸드폰번호 [-포함]"/> <br />
			<input type="image" src="/MyUsed/images/checkIcon.png" width="35" height="35" title="추가">
	</form>
			
   	</div>

	
   	<div id="detailimgs">
   
    	<table border="1" width="840" height="160">
   		
   			
   		<tr bgcolor="#BDBDBD">
   		<td><strong>이름</strong></td><td><strong>전화번호</strong></td><td><strong>우편번호</strong></td>
   		<td><strong>주소</strong></td><td><strong>상세주소</strong></td><td><strong>삭제</strong></td>
   		</tr>
   			
   		<c:forEach var="addresslist" items="${addresslist}">
   		<tr>
    	<td>${addresslist.name} </td>
    	<td>${addresslist.ph}</td>
    	<td>${addresslist.addrNum} </td>
    	<td>${addresslist.addr}</td>
    	<td>${addresslist.addrr} </td>
    	<td>
    	<a href="/MyUsed/addressDelete.nhn?seq_num=${addresslist.seq_num}&num=${num}">
    	<img src="/MyUsed/images/deleteIcon.PNG" width="30" height="30" title="삭제하기" onclick="deleteCheck()">
    	</a>
    	</td>
    	</tr>	
    	</c:forEach>
    		
   		
   	</table>
 
    </div>
    
    
    <div id="detailcontent">
    	
    
    	
    	<br/>
    <hr width=100% />
  	<font color="#747474"><strong>* 업데이트 주소 *</strong></font>  
  	<hr width=100% />
  	
  	
  		<table align="center"  width="300" height="180">
  			<tr>
  				<td width="100" height="50"><strong>성함</strong></td>
  				<td><strong>${fianllist.name}</strong> <br/>
  					( ${fianllist.ph} )
  				</td>
  			</tr>
  			<tr>
  				<td><strong>주소</strong></td>
  				<td><font size="2">${fianllist.addr} ${fianllist.addrr}</font></td>
  			</tr>
  			
  		</table>
    	
    </div>


</div>




</body>
</html>