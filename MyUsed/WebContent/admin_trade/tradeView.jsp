<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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


<div id="sidebannerL">

<body>




 	
 	<br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a onclick="javascript:callAjax_profile()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"><img src="/MyUsed/images/modify.png" width="20" height="20">&nbsp;<font size="2"><b>������ ����</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a onclick="javascript:callAjax_newsfeed('${num}')" onmouseover="this.style.textDecoration='none'"  style="cursor:pointer; ">
 	<img src="/MyUsed/images/newSpeed.png" width="20" height="20">&nbsp;<font size="2"><b>�����ǵ�</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a onclick="javascript:callAjax_viewFriend()" onmouseover="this.style.textDecoration='none'"  style="cursor:pointer;"><img src="/MyUsed/images/friend.png" width="20" height="20">&nbsp;<font size="2"><b>ģ������</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a onclick="javascript:callAjax_friend('${num}')" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"><img src="/MyUsed/images/friendSearch.png" width="20" height="20">&nbsp;<font size="2"><b>ģ��ã��</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a onclick="javascript:callAjax_picture()" onmouseover="this.style.textDecoration='none'"  style="cursor:pointer;"><img src="/MyUsed/images/picture.png" width="20" height="20">&nbsp;<font size="2"><b>����</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="javascript:;" onmouseover="this.style.textDecoration='none'" onclick="openChat();"><img src="/MyUsed/images/chat.png" width="20" height="20" onclick="openChat();">&nbsp;<font size="2"><b>ä�ù�</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/address.nhn" onmouseover="this.style.textDecoration='none'"><img src="/MyUsed/images/address.png" width="20" height="20">&nbsp;<font size="2"><b>�ּҷ�</b></font></a>
 	<br /><br />
 	
 	
 	
 	<!--��ǰ ī�װ� ���� ��ȸ -->
 	
	&nbsp;
 	<a href="#" onmouseover="this.style.textDecoration='none'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/MyUsed/images/categ.png" width="20" height="20">&nbsp;<font size="2"><b>ī�װ�</b></font></a>
 			
 	<br /><br />
 
 
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="tradeState.nhn" onmouseover="this.style.textDecoration='none'" ><img src="/MyUsed/images/deposit.png" width="20" height="20">&nbsp;<font size="2"><b>�ŷ���Ȳ</b></font></a>
   	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="depositState.nhn" onmouseover="this.style.textDecoration='none'"><img src="/MyUsed/images/deliver.png" width="20" height="20">&nbsp;<font size="2"><b>��۰���</b></font></a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="choiceMain.nhn?mynum=${num}" onmouseover="this.style.textDecoration='none'"onmouseover="this.style.textDecoration='none'"><img src="/MyUsed/images/like.png" width="20" height="20">&nbsp;<font size="2"><b>���ϱ�</b></font></a>
 	<br /><br />	
 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="board.nhn" onmouseover="this.style.textDecoration='none'"><img src="/MyUsed/images/board.png" width="20" height="20">&nbsp;<font size="2"><b>������</b></font></a>
 	<br /><br />
</body>
</div> <!-- ���̵��� Left -->
    
<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->



<div id="detailViewback"></div>


<div id="detailView">
	

   	<div id="detailimg">
  	<br/>
 	<hr width=100% />
  	<font color="#747474"><strong>* �ֱ� �ŷ� ��û�Ͻ� ��ǰ���� *</strong></font>  
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="tradeAllView.nhn"><u>��ü����</u></a>
  	<hr width=100% />
  	<table  align="center" width="400" height="150"> 
  		
  		
  		<tr>	
  			<td>
  			<a href="ProductDetailView.nhn?num=${orderlist.sell_pronum}">
  			<img src="/MyUsed/images/${orderlist.sell_propic}" width="150" height="150" title="��ǰ�ڼ�������">
  			</a>
  			</td>	
  			<td>
  			<a href="MyUsedMyPage.nhn?mem_num=${orderlist.sell_memnum}">
  			<img src="/MyUsed/images/profile/${sellDTO.profile_pic}" width="50" height="50" title="��������"/> </a><br/>
  			<a href="MyUsedMyPage.nhn?mem_num=${orderlist.sell_memnum}">
  			<font size="3" color="#4565A1"><strong>${orderlist.sell_name}</strong> </font></a><br/> <br/>
  			
  			<font size="4" color="red" ><b><fmt:formatNumber value="${orderlist.buy_price}" type="number" />��</b></font>
  			</td>
  			
  				
  		</tr>		
  		
	
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
  	
  	
  		<table align="center"  width="300" height="180">
  			<tr>
  				<td width="100" height="50"><strong>�����Ǻ�</strong></td>
  				<td><strong>${orderlist.send_name}</strong> <br/>
  					( ${orderlist.send_ph} )
  				</td>
  			</tr>
  			<tr>
  				<td><strong>�ּ�</strong></td>
  				<td><font size="2">${orderlist.send_addr} ${orderlist.send_addrr}</font></td>
  			</tr>
  			
  		</table>
  	
    	
    </div>


</div>




</body>
</html>