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

<style>
#sidebannerR { position:fixed; 
		top:50px; 
		height:500%; 
		left:80%; 
		width:14%;
		margin-left:0%;  
		padding-left:1%;
		background:#EAEAEA; 
		z-index:100;
	}
#contents { width:52%; height:9000px; margin-top:1px; margin-left:13%; background:#EAEAEA; }
#advertise {  position:fixed; width:45%; height:100%; left:57%; margin-right:30%;background:#EAEAEA; }
</style>

    
<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->
<div id="sidebannerR"><jsp:include page="/main/advertise.jsp"/></div> <!-- ���̵��� Right  -->
<div id="contents"></div>
<div id="advertise"></div>
<div id="detailViewback"></div>


<div id="detailView" >
	


   	<div id="detailimg">
   	<br />
   	<hr width=100% />
 		<font color="#747474"><strong>* ������ ����� ����  *</strong></font>
 	<hr width=100% />
 	<br />
 	<c:if test="${depositlist != null}">
 	<table align="center"  width="300" height="180">
  			<tr>
  				
  				<td width="100" height="50"><strong>�����Ǻ�</strong></td>
  				<td><strong>${depositlist.send_name}</strong> <br/>
  					( ${depositlist.send_ph} )
  				</td>
  			</tr>
  			<tr>
  				<td><strong>�ּ�</strong></td>
  				<td><font size="2">${depositlist.send_addr} ${depositlist.send_addrr} (${depositlist.send_adrnum})</font></td>
  			</tr>
  			
  	</table>
 	</c:if>
 	<c:if test="${depositlist == null}">
 		<font color="#747474"> ������ �����ϴ�. </font>
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
   			<font size="5" color="#FF1212">1.</font><strong> <font size="4" color="#747474">���¹�ȣ�Է�</font></strong> <br/>
   			<font size="2" color="#747474">�۱� ������ ���¸� �Է�.</font> <br/>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">2.</font><strong> <font size="4" color="#747474">�����ȣ�Է�</font></strong><br/>
   			<font size="2" color="#747474">��ۺ����� �����ȣ�� �Է�.</font>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">3.</font><strong> <font size="4" color="#747474">�����ȣȮ��</font></strong><br/>
   			<font size="2" color="#747474">�����ȣ Ȯ�� �� �Ǹűݾ� ����.</font>
   			</td>
   			<td>
   			 <font size="7" color="#747474"> > </font>
   			</td>
   			<td>
   			<font size="5" color="#FF1212">4.</font><strong> <font size="4" color="#747474">�ŷ��Ϸ�</font></strong><br/>
   			<font size="2" color="#747474">�ŷ��� �Ϸ� �Ǿ����ϴ�.</font>
   			</td>
   		</tr>
   		
   		<tr align="center">
   		<td align="left">
   		<input type="Text" name="acount" placeholder="���¹�ȣ (-����)"/><br/>
   		<input type="Text" name="bankname" size="6" placeholder="�����"/><input type="Text" name="sendname" size="9"placeholder="����"/>
   		
   		</td><td></td>
   		<td><input type="Text" name="postnum" placeholder="�����ȣ (13�ڸ�)"/></td><td></td>
   		<td><input type="image" src="/MyUsed/images/addDepositIcon.png" width="80" height="70" title="�����ϱ�" style="cursor:pointer;" /></td>
   		</tr>
   		
   		
   		
   		</table>
   	</form>
 	</center>
    </div>
    
    
    <div id="detailcontent">
    	<br/>
  		<hr width=100% />
 		<font color="#747474"><strong>* �ŷ� ��û�� ��ǰ���� *</strong></font>
 		<hr width=100% />
    	<br />
    	<c:if test="${depositlist != null}">
    	<a href="ProductDetailView.nhn?num=${depositlist.sell_pronum}"><img src="/MyUsed/images/${depositlist.sell_propic}" title="��ǰ����" width="120" height="120"/></a><br/>
    	</c:if>
    	
    	 <c:if test="${depositlist == null}">
 			<font color="#747474"> ������ �����ϴ�. </font>
 		</c:if>
    	
    </div>
   


</div>




</body>
</html>