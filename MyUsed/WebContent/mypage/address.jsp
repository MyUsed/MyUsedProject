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

	<script>
	function deleteCheck(){
               if(confirm("������ �����Ͻðڽ��ϱ�?") == true){

               } 	else{
               	event.preventDefault();
             		  }
               }
      
	</script>


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
  	<form action="addrInsert.nhn" method="post" >
  			
  			<input type="hidden" name="num" value="${num}"/>
  			
  	
  			  <hr width=100% />
  	<font color="#747474"><strong>* �ּҷ� ���� *</strong></font>  
  			  <hr width=100% />
  	
   			<input type="text" id="sample6_postcode" name ="addrNum" placeholder="�����ȣ">
			<img src="/MyUsed/images/AddressSearch.PNG" onclick="sample6_execDaumPostcode()" width="33" height="33" border="0" style='cursor:pointer;' title="�����ȣã��"><br />
			<input type="text" id="sample6_address" name="addr" placeholder="�ּ�" size="50"><br /><br/>
			<input type="text" id="sample6_address2" name="addrr" placeholder="���ּ�" size="60"> <br/> <br/>
			
			<input type="text" id="name" name="name" placeholder="�����Ǻ�"/>
			<input type="text" id="ph" name="ph" placeholder="�ڵ�����ȣ [-����]"/> <br />
			<input type="image" src="/MyUsed/images/checkIcon.png" width="35" height="35" title="�߰�">
	</form>
			
   	</div>

	
   	<div id="detailimgs">
   
    	<table border="1" width="840" height="160">
   		
   			
   		<tr bgcolor="#BDBDBD">
   		<td><strong>�̸�</strong></td><td><strong>��ȭ��ȣ</strong></td><td><strong>�����ȣ</strong></td>
   		<td><strong>�ּ�</strong></td><td><strong>���ּ�</strong></td><td><strong>����</strong></td>
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
    	<img src="/MyUsed/images/deleteIcon.PNG" width="30" height="30" title="�����ϱ�" onclick="deleteCheck()">
    	</a>
    	</td>
    	</tr>	
    	</c:forEach>
    		
   		
   	</table>
 
    </div>
    
    
    <div id="detailcontent">
    	
    
    	
    	<br/>
    <hr width=100% />
  	<font color="#747474"><strong>* ������Ʈ �ּ� *</strong></font>  
  	<hr width=100% />
  	
  	
  		<table align="center"  width="300" height="180">
  			<tr>
  				<td width="100" height="50"><strong>����</strong></td>
  				<td><strong>${fianllist.name}</strong> <br/>
  					( ${fianllist.ph} )
  				</td>
  			</tr>
  			<tr>
  				<td><strong>�ּ�</strong></td>
  				<td><font size="2">${fianllist.addr} ${fianllist.addrr}</font></td>
  			</tr>
  			
  		</table>
    	
    </div>


</div>




</body>
</html>