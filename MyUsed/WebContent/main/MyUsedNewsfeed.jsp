<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/main/script.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Newsfeed</title>
</head>
<body>

<br /><br />
<center>

<a onclick="javascript:openstate()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
<font style="font-weight:bold; font-size:120%">
	State </font>
</a> &nbsp;&nbsp;

<a onclick="javascript:openproduct()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
<font style="font-weight:bold; font-size:120%">
	Product</font>
</a>

</center>

<br />




<div id="newsfeed" style="display:block;">

<c:if test="${newsfeed == null}">
<center>
 	<table align="center"  width="500" height="100" border="2" bordercolor="#FFFFA1">
 		<tr>
 			<td align="center" bgcolor="#FAED7D">
 				<font style="font-weight:bold; font-size:130%;">�Խõ� ���� �����ϴ�.</font><br />
 				<font style="font-size:90%;" color="#5D5D5D">ģ���� ����Ͽ� �� ���� �޾ƺ�����! </font>
 			</td>
 		</tr>
 	</table>

</center>
</c:if>


<c:forEach var="list" items="${newsfeed}">	
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${list.mem_num}"><font face="Comic Sans MS">( ${list.name} )</font></a>
		<font face="Comic Sans MS" size="2" color="#A6A6A6" > ���� ���� �Խ��Ͽ����ϴ�</font>  
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:if test="${list.mem_num == memDTO.num}">
		<a href="delete.nhn?num=${list.num}"><img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 1em;" width="20" height="20" align="right" title="�Խñ� ����"/></a>
		</c:if>
		<hr width="100%" > 
		</td>
		</tr>
		
		<tr  bgcolor="#FFFFFF">
		<td align="center">
		<c:if test="${list.mem_pic != null}">
		<a href="reple.nhn?num=${list.num}">
		<img src="/MyUsed/images/${list.mem_pic}" width="470" height="300"/>
		</a>
		 <br/> <br />
		</c:if>
		<!-- �Ϲ� �Խñ� �ؽ��±� -->	
	<script type="text/javascript">
	$(document).ready(function(){
		var content = document.getElementById('listcontent_${list.num}').innerHTML;
		var splitedArray = content.split(' ');	// ������ �������� �ڸ�
		var resultArray = [];	//���� ����� ���� �迭�� �̸� ������
		
		// ������ �������� �߸� �迭�� ��ҵ��� �˻���
		for(var i = 0; i < splitedArray.length ; i++){
			// �� �� <br>�� ���ԵǾ��ִ� �迭�� ��Ұ� �ִٸ�
			if(splitedArray[i].indexOf('<br>') > -1){
				
				// <br> �������� �߶� �ӽ� �迭�� array�� �ִ´� -> �̶� array�� ���̴� 2�� �� �� �ۿ� ����
				var array = splitedArray[i].split('<br>');
				// �̶� <br>�� #�� ���� �ܾ��� �տ� ���� �� ���ְ� �ڿ� ���� ���� �ֱ� ������ indexOf�� �̿��� ��ġ�� �Ǵ��Ѵ�.
				if(splitedArray[i].indexOf('<br>') < splitedArray[i].indexOf('#')){	//br�� �տ� �������
					resultArray[i] = array[0]+'<br>';	// array�� ù��° ��ҿ� <br>�� �ٿ��ش�
					resultArray[i+1] = array[1];
					i++;	//resultArray�� ũ�Ⱑ 1 �þ������ i�� ++����
				}else{	//br�� �ڿ� �������
					resultArray[i] = array[0];
					resultArray[i+1] = '<br>'+array[1];	// array�� �ι�° ��ҿ� <br>�� �ٿ��ش�
					i++;	//resultArray�� ũ�Ⱑ 1 �þ������ i�� ++����
				}
			// <br>�� ���Ե������� ��ҵ��� �׳� resultArray�� �־��ش�.
			}else{
				resultArray[i] = splitedArray[i];
			}
		}
		var linkedContent = '';
		for(var word in resultArray)
		{
		  word = resultArray[word];
		   if(word.indexOf('#') == 0)
		   {
				var url = '"'+'/MyUsed/tegSearch.nhn?word='+word.split('#')+'"';
			    word = '<a href='+url+'>'+word+'</a>';
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('listcontent_${list.num}').innerHTML = linkedContent; 
	});
	</script>
		
		
		<div id="listcontent_${list.num}">${list.content}</div>
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"  > 
		
		<script type="text/javascript">
			/****** ���ÿ��� ******/
			function openNreple${list.num}() {
				if(nreple_${list.num}.style.display == 'block'){
				    $('#nreple_${list.num}').slideUp();
				    $('#nreple_${list.num}').attr('style', 'display:none;');			
				}else{
				    $.ajax({
				        type: "post",
				        url : "/MyUsed/reple.nhn",
				        data: {	// url �������� ������ �Ķ����
				        	num : '${list.num}',
				        	page: 0
				        },
				        success: nreple${list.num},	// ��������û ������ ���� �Լ�
				        error: whenError_reple	//��������û ���н� �����Լ�
				 	});
					
				}
			}
			function nreple${list.num}(relist){	// ��û������ ������������ aaa ������ �ݹ�ȴ�.
			    $('#nreple_${list.num}').attr('style', 'background:#FFFFFF; border:1px solid #D5D5D5; display:block;');
			    $('#nreple_${list.num}').slideDown();	// ��� ������
			    $('#nreple_${list.num}').html(relist);
			    console.log(resdata);
			}
			function whenError_reple(){
			    alert("���� ����");
			}
		</script>
		
		���ƿ�  / �����ϱ� /
		<a onclick="javascript:openNreple${list.num}()" style="cursor:pointer;">
			<img src="/MyUsed/images/reple.PNG" width="25" height="20"/>
			<font size="2" color="#9A9DA4">��� ${list.reples}��</font>
		</a>
		</td>
		</tr>
				
		<tr bgcolor="#FFFFFF">
		<td>
		
		</td>
		</tr>
		

	</table>
		<!-- �Ϲ� �Խñ� �ؽ��±� -->	
	
	<div id="nreple_${list.num}" style=" border:2px solid #000000; display:none;"></div>
	
	</div>


 	<br />	

</c:forEach >
</div>






<!-- -------��ǰ---------------------------------------------------------------------------------------------- -->


<div id="newsfeed_pro" style="display:none;">

<c:if test="${pronewsfeed == null}">
<center>
 	<table align="center"  width="500" height="100" border="2" bordercolor="#FFFFA1">
 		<tr>
 			<td align="center" bgcolor="#FAED7D">
 				<font style="font-weight:bold; font-size:130%;">�Խõ� ��ǰ�� �����ϴ�.</font><br />
 				<font style="font-size:90%;" color="#5D5D5D">ģ���� ����Ͽ� ���� ��ϵ� ��ǰ�� �޾ƺ�����! </font>
 			</td>
 		</tr>
 	</table>

</center>
</c:if>


<c:forEach var="prolist" items="${pronewsfeed}" varStatus="i">
	
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${prolist.mem_num}"><font face="Comic Sans MS" >( ${prolist.name} )</font></a>
		<font face="Comic Sans MS" size="2" color="#A6A6A6" > ���� ��ǰ�� �Խ��Ͽ����ϴ�  </font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:if test="${prolist.mem_num == memDTO.num}">
		<a href="prodelete.nhn?num=${prolist.num}"><img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 1em;" width="20" height="20" align="right" title="�Խñ� ����"/></a>
		</c:if>
		
		<hr width="100%" > 
		</td>
		</tr>
		
		<tr  bgcolor="#FFFFFF">
		<td align="center">
		
		<c:if test="${prolist.pro_pic != null}"> 
		<a href="ProductDetailView.nhn?num=${prolist.num}">
		<img src="/MyUsed/images/${prolist.pro_pic}" width="370" height="350" /> 
		</a>
		<br/>
		</c:if>
		
		
		 <font size="5" color="#1F51B7" >${prolist.price}</font> <br /><br />
		
		<font size="3" color="#0042ED" >
		-------------------------------- * �󼼼��� * -------------------------------- 
		</font>
		<!-- ��ǰ �Խñ� �ؽ��±� -->	
		<script type="text/javascript">
	$(document).ready(function(){
		var content = document.getElementById('procontent_${prolist.num}').innerHTML;
		var splitedArray = content.split(' ');	// ������ �������� �ڸ�
		var resultArray = [];	//���� ����� ���� �迭�� �̸� ������
		
		// ������ �������� �߸� �迭�� ��ҵ��� �˻���
		for(var i = 0; i < splitedArray.length ; i++){
			// �� �� <br>�� ���ԵǾ��ִ� �迭�� ��Ұ� �ִٸ�
			if(splitedArray[i].indexOf('<br>') > -1){
				
				// <br> �������� �߶� �ӽ� �迭�� array�� �ִ´� -> �̶� array�� ���̴� 2�� �� �� �ۿ� ����
				var array = splitedArray[i].split('<br>');
				// �̶� <br>�� #�� ���� �ܾ��� �տ� ���� �� ���ְ� �ڿ� ���� ���� �ֱ� ������ indexOf�� �̿��� ��ġ�� �Ǵ��Ѵ�.
				if(splitedArray[i].indexOf('<br>') < splitedArray[i].indexOf('#')){	//br�� �տ� �������
					resultArray[i] = array[0]+'<br>';	// array�� ù��° ��ҿ� <br>�� �ٿ��ش�
					resultArray[i+1] = array[1];
					i++;	//resultArray�� ũ�Ⱑ 1 �þ������ i�� ++����
				}else{	//br�� �ڿ� �������
					resultArray[i] = array[0];
					resultArray[i+1] = '<br>'+array[1];	// array�� �ι�° ��ҿ� <br>�� �ٿ��ش�
					i++;	//resultArray�� ũ�Ⱑ 1 �þ������ i�� ++����
				}
			// <br>�� ���Ե������� ��ҵ��� �׳� resultArray�� �־��ش�.
			}else{
				resultArray[i] = splitedArray[i];
			}
		}
		var linkedContent = '';
		for(var word in resultArray)
		{
		  word = resultArray[word];
		   if(word.indexOf('#') == 0)
		   {
				var url = '"'+'/MyUsed/protegSearch.nhn?word='+word.split('#')+'"';
			    word = '<a href='+url+'>'+word+'</a>';
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('procontent_${prolist.num}').innerHTML = linkedContent; 
	});
	</script>
	
		 <br/>
		 <div id="procontent_${prolist.num}">${prolist.content}</div>
		
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"  > 
		
		
		���ƿ� 
		<input type="image" src="/MyUsed/images/chiceIcon.png" width="20" height="20" id="choiceB${i.count}" onclick="choiceAjax('${i.count}')" title="���ϱ�"/>
		<input type="hidden" name="num" id="num${i.count}" value="${prolist.num}" />
		<input type="hidden" name="mem_num" id="mem_num${i.count}" value="${prolist.mem_num}" />
		<input type="hidden" name="mem_name" id="mem_name${i.count}" value="${prolist.name}" />
		<input type="hidden" name="price" id="price${i.count}" value="${prolist.price}" />
		<input type="hidden" name="pro_pic" id="pro_pic${i.count}" value="${prolist.pro_pic}" />
		<input type="hidden" name="content" id="content${i.count}" value="${prolist.content}" /> 
		
		 <a href="ProductDetailView.nhn?num=${prolist.num}"><img src="/MyUsed/images/reple.PNG"/><font size="2" color="#9A9DA4">��� ${prolist.reples}��</font></a>
		
			<a href="ProductDetailView.nhn?num=${prolist.num}"><img align="right" style="padding:2px" src="/MyUsed/images/buyIcon.PNG" width="35" height="35" /></a>
			<div id="ajaxChoice"></div>
			
		</td>
		</tr>

	</table>
 	<br />	
 	

<!--  ��ǰ ���� ������  -->	
	 
</c:forEach>


</div>


</body>
</html>