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



<body>



    
<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->
<div id="detailViewback"></div>


<div id="detailView" >
	


   	<div id="detailimg">
   	<br />
   	<hr width=100% />
 		<font color="#747474"><strong>* 구매자 배송지 정보  *</strong></font>
 	<hr width=100% />
 	<br />
 	<c:if test="${depositlist != null}">
 	<table align="center"  width="300" height="180">
  			<tr>
  				
  				<td width="100" height="50"><strong>받으실분</strong></td>
  				<td><strong>${depositlist.send_name}</strong> <br/>
  					( ${depositlist.send_ph} )
  				</td>
  			</tr>
  			<tr>
  				<td><strong>주소</strong></td>
  				<td><font size="2">${depositlist.send_addr} ${depositlist.send_addrr} (${depositlist.send_adrnum})</font></td>
  			</tr>
  			
  	</table>
 	</c:if>
 	<c:if test="${depositlist == null}">
 		<font color="#747474"> 정보가 없습니다. </font>
 	</c:if>
 	
   	</div>
	
	
   <div id="detailimgs">
   <center>
   <form action="submitAcount.nhn" method="post">
   
   <input type="hidden" name="buy_memnum" value="${depositlist.buy_memnum}"/>
   <input type="hidden" name="buy_name" value="${depositlist.buy_name}"/>
   <input type="hidden" name="sell_pronum" value="${depositlist.sell_pronum}"/>
   <input type="hidden" name="sell_memnum" value="${depositlist.sell_memnum}"/>
   <input type="hidden" name="sell_name" value="${depositlist.sell_name}"/>
   <input type="hidden" name="sell_propic" value="${depositlist.sell_propic}"/>
   <input type="hidden" name="send_ph" value="${depositlist.send_ph}"/>
   <input type="hidden" name="buy_price" value="${depositlist.buy_price}"/>
   
   
   
    	<table   width="800" height="80">
   			
   		<tr>
   			<td>
   			<font size="5" color="#FF1212">1.</font><strong> <font size="4" color="#747474">계좌번호입력</font></strong> <br/>
   			<font size="2" color="#747474">송금 받으실 계좌를 입력.</font> <br/>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">2.</font><strong> <font size="4" color="#747474">송장번호입력</font></strong><br/>
   			<font size="2" color="#747474">배송보내신 송장번호를 입력.</font>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">3.</font><strong> <font size="4" color="#747474">송장번호확인</font></strong><br/>
   			<font size="2" color="#747474">송장번호 확인 후 판매금액 지급.</font>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">4.</font><strong> <font size="4" color="#747474">거래완료</font></strong><br/>
   			<font size="2" color="#747474">거래가 완료 되었습니다.</font>
   			</td>
   		</tr>
   		
   		<tr align="center">
   		<td align="left">
   		<input type="Text" name="acount" placeholder="계좌번호 (-제외)"/><br/>
   		<input type="Text" name="bankname" size="6" placeholder="은행명"/><input type="Text" name="sendname" size="9"placeholder="성명"/>
   		
   		</td><td></td>
   		<td><input type="Text" name="postnum" placeholder="송장번호 (13자리)"/></td><td></td>
   		<td><input type="image" src="/MyUsed/images/addDepositIcon.png" width="80" height="70" title="전송하기" style="cursor:pointer;" /></td>
   		</tr>
   		
   		
   		
   		</table>
   	</form>
 	</center>
    </div>
    
    
    <div id="detailcontent">
    	<br/>
  		<hr width=100% />
 		<font color="#747474"><strong>* 거래 요청된 상품정보 *</strong></font>
 		<hr width=100% />
    	<br />
    	<c:if test="${depositlist != null}">
    	<a href="ProductDetailView.nhn?num=${depositlist.sell_pronum}"><img src="/MyUsed/images/${depositlist.sell_propic}" title="상품보기" width="120" height="120"/></a><br/>
    	</c:if>
    	
    	 <c:if test="${depositlist == null}">
 			<font color="#747474"> 정보가 없습니다. </font>
 		</c:if>
    	
    </div>
   


</div>




</body>
</html>