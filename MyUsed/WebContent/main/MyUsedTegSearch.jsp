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


<form name="reple" action="reple.nhn" method="post" >

<br />	
<div style="padding-left:70px;font-size:110%;font-weight:bold;">${content} �˻����</div>
<br />
<c:forEach var="list" items="${list}">	
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
			function mianopenreple${list.num}() {
				if(main_reple_${list.num}.style.display == 'block'){
				    $('#main_reple_${list.num}').slideUp();
				    $('#main_reple_${list.num}').attr('style', 'display:none;');				
				}else{
				    $.ajax({
				        type: "post",
				        url : "/MyUsed/reple.nhn",
				        data: {	// url �������� ������ �Ķ����
				        	num : '${list.num}',
				        	page: 0
				        },
				        success: reple${list.num},	// ��������û ������ ���� �Լ�
				        error: whenError_reple	//��������û ���н� �����Լ�
				 	});
					
				}
			}
			function reple${list.num}(relist){	// ��û������ ������������ aaa ������ �ݹ�ȴ�.
			    $('#main_reple_${list.num}').attr('style', 'background:#FFFFFF;  display:block;');
			    $('#main_reple_${list.num}').slideDown();	// ��� ������
			    $('#main_reple_${list.num}').html(relist);
			    console.log(resdata);
			}
			function whenError_reple(){
			    alert("���� ����");
			}
		</script>
		
	 <div id="likewow${i.count}"></div>
	 <a onclick="likeAjax('${list.num}','${i.count}')">
	 <c:if test="${list.likes == 0}">
	 <img id="love" src="/MyUsed/images/likeDown.png"  style='cursor:pointer;' />
	 </c:if>
	 </a>
	 <a onclick="likedownAjax('${list.num}','${i.count}')">
	 <c:if test="${list.likes != 0}">
	 <img id="love" src="/MyUsed/images/likeUp.png"  style='cursor:pointer;' />
	 </c:if>
	 </a>
	 <a onclick="javascript:mianopenreple${list.num}()" style="cursor:pointer;"><img src="/MyUsed/images/reple.PNG" width="23" height="17"/><font size="2" color="#9A9DA4">��� ${list.reples}��</font></a>
		</td>
		</tr>
				
		<tr bgcolor="#FFFFFF">
		<td>
		
		
		
		</td>
		</tr>
		
		<tr>
		<td>
		
		<!-- ���� ���� -->
		<div id="main_reple_${list.num}" style=" border:2px solid #000000; display:none;"></div>
	
		</td>
		</tr>
		


	</table>
	<br />
</c:forEach>

</form>


</div>

<br /><br />




</body>
</html>