<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>�ּҷ�</title>
</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/MyUsed/product/productScript.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/MyUsed/mypage/address.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />



<body>



    
<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->

<div id="detailViewback"></div>


<div id="detailView">
	

   	<div id="detailimg">
  	<br/>
 	<hr width=100% />
  	<font color="#747474"><strong>* ��ü��ǰ���� *</strong></font>  
  	<hr width=100% />
  	<table align="center" width="400" height="80"> 
  		
  		
  		<tr>	
  			<td width="100" height="50"><strong>IMG</strong></td><td><strong>����</strong></td><td><strong>�Ǹ���</strong></td><td><strong>����</strong></td>
  				
  		</tr>	
  		<c:forEach var="orderAll" items="${orderAll}">	
  		<tr>
  			<td width="80" height="50">
  			<a href="ProductDetailView.nhn?num=${orderAll.sell_pronum}">
  			<img src="/MyUsed/images/${orderAll.sell_propic}" width="50" height="60"/>
  			</a>
  			</td>
  			<td><font size="4" color="red"><strong>${orderAll.buy_price} ��</strong></font></td>
  			<td>
  			<a href="MyUsedMyPage.nhn?mem_num=${orderAll.sell_memnum}">
  			<font size="3" color="#4565A1">${orderAll.sell_name}</font>
  			</a>
  			</td>
  			<td>
  			<c:if test="${orderAll.state == 0}"><font size="3" color="blue"><strong>�Ա���</strong></font></c:if>
  			<c:if test="${orderAll.state == 1}"><font size="3" color="blue"><strong>�ԱݿϷ�</strong></font></c:if>
  			<c:if test="${orderAll.state == 2}"><font size="3" color="blue"><strong>�����</strong></font></c:if>
  			<c:if test="${orderAll.state == 3}"><font size="3" color="blue"><strong>��ۿϷ�</strong></font></c:if>
  			
  			</td>
  		</tr>
  		</c:forEach>
  		
	
	</table>	
   	</div>
	
	
   	<div id="detailimgs">
   <center>
    	<table   width="800" height="80">
   			
   		<tr>
   			<td>
   			<font size="5" color="#FF1212">1.</font><strong> <font size="4" color="#747474">�Ա���</font></strong> <br/>
   			<font size="2" color="#747474">������ �Ϸ����ּ���.</font> <br/>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">2.</font><strong> <font size="4" color="#747474">�Ա�Ȯ��</font></strong><br/>
   			<font size="2" color="#747474">�Ա�Ȯ���� �Ϸ�Ǿ����ϴ�.</font>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">3.</font><strong> <font size="4" color="#747474">�����</font></strong><br/>
   			<font size="2" color="#747474">�Ǹ��ڰ� ��ǰ�� ���½��ϴ�.</font>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">4.</font><strong> <font size="4" color="#747474">��ۿϷ�</font></strong><br/>
   			<font size="2" color="#747474">�ŷ��� �Ϸ�Ǿ����ϴ�.</font>
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
  	<font color="#747474"><strong>* ��ǰ ������ ���� *</strong></font>  
  	<hr width=100% />
  	
  	
  		<table align="center" width="350" height="80"> 
  		
  		
  		<tr>	
  			<td height="50"><strong>�����ּ�</strong></td><td><strong>�����Ǻ�</strong></td><td><strong>��ȭ��ȣ</strong></td>
  				
  		</tr>	
  		<c:forEach var="orderAll" items="${orderAll}">	
  		<tr>
  			<td width="200" height="60" >${orderAll.send_addr} ${orderAll.send_addrr}</td>
  			<td><strong>${orderAll.send_name}</strong></td>
  			<td>${orderAll.send_ph}</td>
  		</tr>
  		</c:forEach>
  		
	
	</table>
  	
    	
    </div>


</div>




</body>
</html>