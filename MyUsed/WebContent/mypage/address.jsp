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



    
<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->
<div id="detailViewback"></div>


<div id="detailView">
	


   	<div id="detailimg">
  	<br/>
  	<form action="addrInsert.nhn" method="post" >
  			
  			<input type="hidden" name="num" value="${num}"/>
  			
  	
  			<font face="Comic Sans MS" size="3" color="#4565A1"><strong>* �ּҷ� ����  *</strong></font> <br/><br/>
   			<input type="text" id="sample6_postcode" name ="addrNum" placeholder="�����ȣ">
			<img src="/MyUsed/images/AddressSearch.PNG" onclick="sample6_execDaumPostcode()" width="33" height="33" border="0" style='cursor:pointer;' title="�����ȣã��"><br />
			<input type="text" id="sample6_address" name="addr" placeholder="�ּ�" size="50"><br /><br/>
			<input type="text" id="sample6_address2" name="addrr" placeholder="���ּ�" size="60"> <br/> <br/>
			
			<input type="text" id="name" name="name" placeholder="�����Ǻ�"/>
			<input type="text" id="ph" name="ph" placeholder="�ڵ�����ȣ [-����]"/> <br /><br/>
			<input type="image" src="/MyUsed/images/checkIcon.png" width="50" height="50" title="�߰�">
	</form>
			
   	</div>

	
   	<div id="detailimgs">
   
    	<table border="1" width="840" height="160">
   		
   			
   		<tr>
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
    	<font face="Comic Sans MS" size="3" color="#4565A1"><strong>* �ֽ� ��� �ּ� *</strong>	 </font> 
    	<br /> <br />
    	<c:forEach var="fianllist" items="${fianllist}">
    		
    	<font size="5" color="#4374D9">�޴º� ���� =  	${fianllist.name}</font> <br /> 
    	<font size="5" color="#4374D9">��ȭ��ȣ =  ${fianllist.ph} </font><br />
    	<font size="5" color="#4374D9">�����ȣ =  ${fianllist.addrNum} </font><br /> 
    	<font size="5" color="#4374D9">(�ּ�) </font> <br/>
    	<font size="5" color="#4374D9">${fianllist.addr}  </font><br />
    	<font size="5" color="#4374D9">���ּ� =  ${fianllist.addrr} </font><br />
    	
    	</c:forEach>
    	
    </div>


</div>




</body>
</html>