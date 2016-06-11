<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>주문 정보</title>
</head>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/MyUsed/product/productScript.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/MyUsed/mypage/address.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />

<body>
<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->
<div id="detailViewback"></div>

<div id="detailView">
	

 	<div id="detailimg">
 	<br />
		<font face="Comic Sans MS" size="5" color="#4565A1"><strong>* 주문 접수가 완료되었습니다 *</strong></font>
		<br /> <br />
		
		<a href="/MyUsed/MyUsed.nhn">
		<img src="/MyUsed/images/finishIcon.PNG" width="250" height="250" title="홈으로" style='cursor:pointer;'>
		</a>
 	</div>
 	
 	<div id="detailimgs">
 	
 	
 	<font size="5" color="red" ><b> <fmt:formatNumber value="${price}" type="number" /> 원</b></font><br /> 
 	
 	<font face="Comic Sans MS" size="3" color="#003399"><strong>국민은행 </strong> <br/> </font>
 	<font face="Comic Sans MS" size="3" color="#4565A1">
 		
 		
 		679802 - 01 - 3384920 <br />
 		(주) MyUsed <br />
 		1544 - 9970
 	
 	</font>
 	
 	
 	</div>
 	
 	<div id="detailcontent">
	<br /> <br />
	<font size="5" color="#4374D9"> * 상품받을 주소 * </font> <br /> <br />
	
	
		<font size="5" color="#4374D9">우편번호 ( ${addresslist.addrNum} )</font> <br />
		<br />
		<font size="5" color="#4374D9"> ${addresslist.addr}</font> <br />
		<br />
		<font size="5" color="#4374D9"> ${addresslist.addrr}</font> <br />
								
		<font size="5" color="#4374D9">( ${addresslist.ph} )</font> <br />

 	


 	</div>
 	
 </div>

</body>
</html>