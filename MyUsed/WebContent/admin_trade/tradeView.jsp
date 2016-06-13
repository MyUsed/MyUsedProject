<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>주소록</title>
</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/MyUsed/product/productScript.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/MyUsed/mypage/address.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />



<body>


<div id="sidebannerL">

<body>




 	
 	<br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a onclick="javascript:callAjax_profile()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"><img src="/MyUsed/images/modify.png" width="20" height="20">&nbsp;<font size="2"><b>프로필 수정</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a onclick="javascript:callAjax_newsfeed('${num}')" onmouseover="this.style.textDecoration='none'"  style="cursor:pointer; ">
 	<img src="/MyUsed/images/newSpeed.png" width="20" height="20">&nbsp;<font size="2"><b>뉴스피드</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a onclick="javascript:callAjax_viewFriend()" onmouseover="this.style.textDecoration='none'"  style="cursor:pointer;"><img src="/MyUsed/images/friend.png" width="20" height="20">&nbsp;<font size="2"><b>친구보기</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a onclick="javascript:callAjax_friend('${num}')" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"><img src="/MyUsed/images/friendSearch.png" width="20" height="20">&nbsp;<font size="2"><b>친구찾기</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a onclick="javascript:callAjax_picture()" onmouseover="this.style.textDecoration='none'"  style="cursor:pointer;"><img src="/MyUsed/images/picture.png" width="20" height="20">&nbsp;<font size="2"><b>사진</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="javascript:;" onmouseover="this.style.textDecoration='none'" onclick="openChat();"><img src="/MyUsed/images/chat.png" width="20" height="20" onclick="openChat();">&nbsp;<font size="2"><b>채팅방</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/address.nhn" onmouseover="this.style.textDecoration='none'"><img src="/MyUsed/images/address.png" width="20" height="20">&nbsp;<font size="2"><b>주소록</b></font></a>
 	<br /><br />
 	
 	
 	
 	<!--상품 카테고리 별로 조회 -->
 	
	&nbsp;
 	<a href="#" onmouseover="this.style.textDecoration='none'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/MyUsed/images/categ.png" width="20" height="20">&nbsp;<font size="2"><b>카테고리</b></font></a>
 			
 	<br /><br />
 
 
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="tradeState.nhn" onmouseover="this.style.textDecoration='none'" ><img src="/MyUsed/images/deposit.png" width="20" height="20">&nbsp;<font size="2"><b>거래현황</b></font></a>
   	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="depositState.nhn" onmouseover="this.style.textDecoration='none'"><img src="/MyUsed/images/deliver.png" width="20" height="20">&nbsp;<font size="2"><b>배송관리</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="choiceMain.nhn?mynum=${num}" onmouseover="this.style.textDecoration='none'"onmouseover="this.style.textDecoration='none'"><img src="/MyUsed/images/like.png" width="20" height="20">&nbsp;<font size="2"><b>찜하기</b></font></a>
 	<br /><br />	
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="board.nhn" onmouseover="this.style.textDecoration='none'"><img src="/MyUsed/images/board.png" width="20" height="20">&nbsp;<font size="2"><b>고객센터</b></font></a>
 	<br /><br />
</body>
</div> <!-- 사이드배너 Left -->
    
<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->



<div id="detailViewback"></div>


<div id="detailView">
	

   	<div id="detailimg">
  	<br/>
 	<hr width=100% />
  	<font color="#747474"><strong>* 최근 거래 요청하신 상품정보 *</strong></font>  
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="tradeAllView.nhn"><u>전체보기</u></a>
  	<hr width=100% />
  	<table  align="center" width="400" height="150"> 
  		
  		
  		<tr>	
  			<td>
  			<a href="ProductDetailView.nhn?num=${orderlist.sell_pronum}">
  			<img src="/MyUsed/images/${orderlist.sell_propic}" width="150" height="150" title="상품자세히보기">
  			</a>
  			</td>	
  			<td>
  			<a href="MyUsedMyPage.nhn?mem_num=${orderlist.sell_memnum}">
  			<img src="/MyUsed/images/profile/${sellDTO.profile_pic}" width="50" height="50" title="정보보기"/> </a><br/>
  			<a href="MyUsedMyPage.nhn?mem_num=${orderlist.sell_memnum}">
  			<font size="3" color="#4565A1"><strong>${orderlist.sell_name}</strong> </font></a><br/> <br/>
  			
  			<font size="4" color="red" ><b><fmt:formatNumber value="${orderlist.buy_price}" type="number" />원</b></font>
  			</td>
  			
  				
  		</tr>		
  		
	
	</table>	
   	</div>
	
	
   	<div id="detailimgs">
   <center>
    	<table   width="800" height="80">
   			
   		<tr>
   			<td>
   			<font size="5" color="#FF1212">1.</font><strong> <font size="4" color="#747474">입금전</font></strong> <br/>
   			<font size="2" color="#747474">결제를 완료해주세요.</font> <br/>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">2.</font><strong> <font size="4" color="#747474">입금확인</font></strong><br/>
   			<font size="2" color="#747474">입금확인이 완료되었습니다.</font>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">3.</font><strong> <font size="4" color="#747474">배송중</font></strong><br/>
   			<font size="2" color="#747474">판매자가 상품을 보냈습니다.</font>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">4.</font><strong> <font size="4" color="#747474">배송완료</font></strong><br/>
   			<font size="2" color="#747474">거래가 완료되었습니다.</font>
   			</td>
   		</tr>
   		
   		<tr align="center">
   		<td><c:if test="${orderlist.state == 0}"><img src="/MyUsed/images/ingIcon.PNG" width="80" height="80"/></c:if></td><td></td>
   		<td><c:if test="${orderlist.state == 1}"><img src="/MyUsed/images/ingIcon.PNG" width="80" height="80"/></c:if></td><td></td>
   		<td><c:if test="${orderlist.state == 2}"><img src="/MyUsed/images/ingIcon.PNG" width="80" height="80"/></c:if></td><td></td>
   		<td><c:if test="${orderlist.state == 3}"><img src="/MyUsed/images/ingIcon.PNG" width="80" height="80"/></c:if></td>
   		</tr>
   		
   		
   		
   		</table>
 	</center>
    </div>
    
    
    <div id="detailcontent">
    <br/>
    <hr width=100% />
  	<font color="#747474"><strong>* 상품 받으실 정보 *</strong></font>  
  	<hr width=100% />
  	
  	
  		<table align="center"  width="300" height="180">
  			<tr>
  				<td width="100" height="50"><strong>받으실분</strong></td>
  				<td><strong>${orderlist.send_name}</strong> <br/>
  					( ${orderlist.send_ph} )
  				</td>
  			</tr>
  			<tr>
  				<td><strong>주소</strong></td>
  				<td><font size="2">${orderlist.send_addr} ${orderlist.send_addrr}</font></td>
  			</tr>
  			
  		</table>
  	
    	
    </div>


</div>




</body>
</html>