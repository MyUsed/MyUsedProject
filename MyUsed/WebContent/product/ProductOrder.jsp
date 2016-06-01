<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>상품주문</title>
</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/MyUsed/product/productScript.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/MyUsed/mypage/address.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />

<script type="text/javascript">
function adrNum(){
 var sample = document.getElementsByName('address');
 for(var i=0;i<sample.length;i++){
  if(sample[i].checked == true){
   location.href="/MyUsed/orderDetail.nhn?seq_num="+sample[i].value+"&num="+${num}+"&price="+${price}+"&mem_num="+${mem_num}+"&pronum="+${pronum};
  }
 }
}
</script>


<body>

<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->
<div id="detailViewback"></div>


<div id="detailView">
	

   	
   	<!-- 대표이미지 (추후 경로 수정)-->
   	<div id="detailimg">
  	<br/><font face="Comic Sans MS" size="3" color="#4565A1"><strong>* 받으실 주소 *</strong></font> 
  	<br/><br/>
  		<a href="address.nhn">
  		<img src="/MyUsed/images/addhouse.png" width="200" height="200" title="주소 추가하러가기" style='cursor:pointer;'/>
  		</a>
   	</div>
   	
   	<!-- 다른 이미지 -->
   	<div id="detailimgs">
   
   	<table border="1" width="840" height="160">
   		
   			
   		<tr>
   		<td><strong>선택</strong></td><td><strong>이름</strong></td><td><strong>전화번호</strong></td><td><strong>우편번호</strong></td>
   		<td><strong>주소</strong></td><td><strong>상세주소</strong></td><td><strong>삭제</strong></td>
   		</tr>
   			
   		<c:forEach var="addresslist" items="${addresslist}" varStatus="i">
   		<tr>
   		<td><input name="address" type="radio" value="${addresslist.seq_num}"></td>
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
    	<br />
    	<font face="Comic Sans MS" size="3" color="#4565A1"><strong>* 판매자 정보 *</strong></font> 
    	<br /> <br />
    	
    		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${mem_num}"> 
				<img src="/MyUsed/images/${profilepic}" width="40"  height="40"></a>
		
    	<c:forEach var="memlist" items="${memlist}">
    		
    		<font face="Comic Sans MS" size="3" color="#5D5D5D" >판매자 ID = <strong>${memlist.id}</strong> </font><br />
    		<font face="Comic Sans MS" size="3" color="#5D5D5D" >판매자 성함 = <strong>${memlist.name}</strong> </font><br />  
    		<font face="Comic Sans MS" size="3" color="#5D5D5D" >판매자 등급 = <strong>${memlist.grade}  (등급) </strong></font> <br />
    		<font face="Comic Sans MS" size="3" color="#5D5D5D" >판매자 접속여부 = <strong>
    		<c:if test="${memlist.onoff == 0}">
    		<font color="#FF0000">OFF</font>
    		</c:if>
    		<c:if test="${memlist.onoff == 1}">
    		<font color="#2F9D27">ON</font>
    		</c:if>
    		
    		</strong></font> <br />
    		
    		<br/> <br/>
    		<font face="Comic Sans MS" size="5" color="#4565A1"><strong>${price} 원</strong></font>
    	
    	</c:forEach>
 	
    		<img src="/MyUsed/images/orderIcon.PNG" style='cursor:pointer;' onclick="javascript_:adrNum();" title="주문하기"/>

     </div>
    
    


</div>





</body>
</html>