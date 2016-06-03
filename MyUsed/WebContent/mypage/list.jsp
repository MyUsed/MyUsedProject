<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<c:forEach var="list" items="${list}">	
<form name="reple" action="reple.nhn" method="post" >

	<div style="border:1px solid #BDBDBD;">
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
			function openreple${list.num}() {
				if(reple_${list.num}.style.display == 'block'){
				    $('#reple_${list.num}').slideUp();
				    $('#reple_${list.num}').attr('style', 'display:none;');
				    $('close_${list.num}').attr('style', 'display:none;');	//�ݱ��ư					
				}else{
				    $.ajax({
				        type: "post",
				        url : "/MyUsed/reple.nhn",
				        data: {	// url �������� ������ �Ķ����
				        	num : '${list.num}'
				        },
				        success: reple${list.num},	// ��������û ������ ���� �Լ�
				        error: whenError_reple	//��������û ���н� �����Լ�
				 	});
					
				}
			}
			function reple${list.num}(relist){	// ��û������ ������������ aaa ������ �ݹ�ȴ�.
			    $('#reple_${list.num}').attr('style', 'background:#FFFFFF; border:1px solid #D5D5D5; display:block;');
			    $('#close_${list.num}').attr('style', 'display:block;');	//�ݱ��ư
			    $('#reple_${list.num}').slideDown();	// ��� ������
			    $('#reple_${list.num}').html(relist);
			    console.log(resdata);
			}
			function whenError_reple(){
			    alert("���� ����");
			}
/* 			function closereple${list.num}() {
			    $('#reple_${list.num}').slideUp();
			    $('#reple_${list.num}').attr('style', 'display:none;');
			    $('close_${list.num}').attr('style', 'display:none;');	//�ݱ��ư
			} */
		</script>
		
		���ƿ�  / �����ϱ� / <%-- <a href="reple.nhn?num=${list.num}"> --%>
		<a onclick="javascript:openreple${list.num}()" style="cursor:pointer;">
			<img src="/MyUsed/images/reple.PNG" width="25" height="20"/>
			<font size="2" color="#9A9DA4">��� ${list.reples}��</font>
		</a><%-- 
		<a onclick="javascript:closereple${list.num}()" id="close_${list.num}"style="cursor:pointer; display:none;">
			<font size="2" color="#9A9DA4" >��</font>
		</a> --%>
		</td>
		</tr>
				
		<tr bgcolor="#FFFFFF">
		<td>
		
		</td>
		</tr>
		

	</table>
		<!-- �Ϲ� �Խñ� �ؽ��±� -->	
	
	<div id="reple_${list.num}" style=" border:2px solid #000000; display:none;"></div>
	
	</div>


 	<br />	

		

</form>	 
</c:forEach>
