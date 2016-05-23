<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>상품주문</title>
</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/MyUsed/product/productScript.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/MyUsed/product/ProductView.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<body>
<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->
<div id="detailViewback"></div>


<div id="detailView">
	

   	
   	<!-- 대표이미지 (추후 경로 수정)-->
   	<div id="detailimg">
  	<br/>
  			<font face="Comic Sans MS" size="2" color="#4565A1"><strong>* 배송받을 주소 *</strong></font> <br/><br/>
   			<input type="text" id="sample6_postcode" name ="addrNum" placeholder="우편번호">
			<img src="/MyUsed/images/AddressSearch.PNG" onclick="sample6_execDaumPostcode()" width="33" height="33" border="0" style='cursor:pointer;' title="우편번호찾기"><br />
			<input type="text" id="sample6_address" name="addr" placeholder="주소" size="50"><br /><br/>
			<input type="text" id="sample6_address2" name="addrr" placeholder="상세주소" size="60"> <br/> <br/>
			
			<input type="text" name="name" placeholder="받으실분"/>
			<input type="text" name="ph" placeholder="핸드폰번호 [-제외]"/>
	
		
   	</div>
   	
   	<!-- 다른 이미지 -->
   	<div id="detailimgs">
   	
   	<table border="1" width="480" height="160">
   	
   		<tr>
   		
   			<td>
   			
   			</td>
   		
   		</tr>
   	
   		<tr>
   		
   			<td>
   				
   			</td>
   		
   		</tr>
   	</table>
    </div>
    


</div>





</body>
</html>