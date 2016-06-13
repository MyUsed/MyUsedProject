<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="/MyUsed/main/script.js"></script>
<script src="/MyUsed/main/animate.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<style type="text/css">
#sidebannerL { position:fixed; top:50px; right:50%; margin-right:35%; width:15%; height:100%; background:#E9EAED; }
#contents { width:52%; height:9000px; margin-top:30px; margin-left:13%; background:#EAEAEA; }
#advertise {  position:fixed; width:22%; height:100%; left:64%; margin-right:30%;background:#EAEAEA; }
#sidebannerR { position:fixed; 
		top:50px; 
		height:500%; 
		left:86%; 
		width:14%;
		margin-left:0%;  
		padding-left:1%;
		background:#EAEAEA; 
		z-index:100;
	}
	
</style>

<title>${content} �˻����</title>
</head>
<body>



<div id="layer_fixed"><jsp:include page="layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->
<div id="sidebannerR"><jsp:include page="/mypage/friendList.jsp"/></div> <!-- ���̵��� Right  -->
<div id="advertise" ><jsp:include page="advertise.jsp"/></div>  <!-- ���� ������  -->
<div id="sidebannerL"><jsp:include page="sidebannerL.jsp"/></div> <!-- ���̵��� Left -->
<div id="contents">
 <!-------------------------------- ���� ���� ------------------------------------------>
	<br />
	


<!--  ��ǰ ���� ������  -->	

	
<br />	
<div style="padding-left:70px;font-size:110%;font-weight:bold;">${content} �˻����</div>
<br />

<c:forEach var="prolist" items="${prolist}" varStatus="i">

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
		<hr width="100%"> 

		<img id="love" src="/MyUsed/images/likeDown.png"  style='cursor:pointer;' />
		<input type="hidden" name="num" id="num${i.count}" value="${prolist.num}" />
		<input type="hidden" name="mem_num" id="mem_num${i.count}" value="${prolist.mem_num}" />
		<input type="hidden" name="mem_name" id="mem_name${i.count}" value="${prolist.name}" />
		<input type="hidden" name="price" id="price${i.count}" value="${prolist.price}" />
		<input type="hidden" name="pro_pic" id="pro_pic${i.count}" value="${prolist.pro_pic}" />
		<input type="hidden" name="content" id="content${i.count}" value="${prolist.content}" /> 
		
		 <a href="ProductDetailView.nhn?num=${prolist.num}"><img src="/MyUsed/images/reple.PNG"/><font size="2" color="#9A9DA4">��� ${prolist.reples}��</font></a>
		
			<a id="choiceB${i.count}" onclick="choiceAjax('${i.count}')"><img src="/MyUsed/images/chooseIcon.png" title="���ϱ�" width="25" height="25" style='cursor:pointer;'/><font size="2" color="#9A9DA4" style='cursor:pointer;'>���ϱ�</font></a>
			<a href="ProductDetailView.nhn?num=${prolist.num}"><img align="right" style="padding:2px" src="/MyUsed/images/buyIcon.PNG" width="55" height="45" title="�����ϱ�"/></a>
			
			<div id="ajaxChoice"></div>
			
		</td>
		
		</tr>

	</table>
 	<br />	
 	

<!--  ��ǰ ���� ������  -->	
	 
</c:forEach>

	

</div>

<br /><br />




</body>
</html>