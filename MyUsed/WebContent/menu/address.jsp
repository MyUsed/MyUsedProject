<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>��ǰ�ֹ�</title>
</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/MyUsed/product/productScript.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/MyUsed/product/ProductView.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<body>
<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->
<div id="detailViewback"></div>


<div id="detailView">
	

   	
   	<!-- ��ǥ�̹��� (���� ��� ����)-->
   	<div id="detailimg">
  	<br/>
  			<font face="Comic Sans MS" size="2" color="#4565A1"><strong>* ��۹��� �ּ� *</strong></font> <br/><br/>
   			<input type="text" id="sample6_postcode" name ="addrNum" placeholder="�����ȣ">
			<img src="/MyUsed/images/AddressSearch.PNG" onclick="sample6_execDaumPostcode()" width="33" height="33" border="0" style='cursor:pointer;' title="�����ȣã��"><br />
			<input type="text" id="sample6_address" name="addr" placeholder="�ּ�" size="50"><br /><br/>
			<input type="text" id="sample6_address2" name="addrr" placeholder="���ּ�" size="60"> <br/> <br/>
			
			<input type="text" name="name" placeholder="�����Ǻ�"/>
			<input type="text" name="ph" placeholder="�ڵ�����ȣ [-����]"/>
	
		
   	</div>
   	
   	<!-- �ٸ� �̹��� -->
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