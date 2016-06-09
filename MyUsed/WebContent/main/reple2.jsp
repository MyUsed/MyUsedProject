<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="/MyUsed/main/script.js"></script>
<script src="/MyUsed/main/jquery-1.11.3.js"></script>
<script src="/MyUsed/main/modal.js"></script>

<meta charset="utf-8">
<script type="text/javascript">
	function deleteCheck() {
		if (confirm("������ �����Ͻðڽ��ϱ�?") == true) {

		} else {
			event.preventDefault();
		}
	}
</script>
<!-- //@���� �̸����� �ڵ����� �˻��ϴ� ���
<script type="text/javascript">
	function findteg(){
		if(event.keyCode != null){
			var reple = document.getElementById('reple').value;
			console.log("reple : ", reple);
			var start = reple.indexOf('@')+1;
			var end = start+reple.indexOf(' ')+1;
			var name = reple.substring(start, end);
			console.log("start num : ", start);
			console.log("end num : ", end);
			console.log("name : ", name);
			
			$.ajax({
		        type: "post",
		        url : "/MyUsed/findname.nhn?name="+name,
		        success: findname,	// ��������û ������ ���� �Լ�
		        error: whentegError	//��������û ���н� �����Լ�
	  		});
			
		}
	}
	function findname(aaa){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
		//alert(name);
		console.log(name);
	    $("#findname").html(aaa);
	}
	function whentegError(){
	    alert("name teg error");
	}
</script>
 -->
<body>

<br /> 


<form action="replesubmit.nhn" method="post" >

	<input type="hidden" name="boardnum" value="${num}"/>
	<input type="hidden" name="content" value="${content}"/>

	<table align="center"  width="90%" height="60"  bgcolor="#FFFFFF" >
	<c:if test="${replelist != null}">
	<c:forEach var="replelist" items="${replelist}">
	<tr> 
		<td width="15%">
			<a  href="/MyUsed/MyUsedMyPage.nhn?mem_num=${replelist.mem_num}"> 
				<font face="Comic Sans MS" size="3" color="#4565A1">${replelist.name}&nbsp;</font>
			</a>
			
	<script type="text/javascript">
	$(document).ready(function(){
		var content = document.getElementById('reple_${replelist.seq_num}').innerHTML;
		var splitedArray = content.split(' ');	// ������ �������� �ڸ�
		var resultArray = [];	//���� ����� ���� �迭�� �̸� ������
		
		// ������ �������� �߸� �迭�� ��ҵ��� �˻���
		for(var i = 0; i < splitedArray.length ; i++){
			// �� �� <br>�� ���ԵǾ��ִ� �迭�� ��Ұ� �ִٸ�
			if(splitedArray[i].indexOf('<br>') > -1){
				
				// <br> �������� �߶� �ӽ� �迭�� array�� �ִ´� -> �̶� array�� ���̴� 2�� �� �� �ۿ� ����
				var array = splitedArray[i].split('<br>');
				// �̶� <br>�� #�� ���� �ܾ��� �տ� ���� �� ���ְ� �ڿ� ���� ���� �ֱ� ������ indexOf�� �̿��� ��ġ�� �Ǵ��Ѵ�.
				if(splitedArray[i].indexOf('<br>') < splitedArray[i].indexOf('@')){	//br�� �տ� �������
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
		   if(word.indexOf('@') == 0)
		   {
				var url = '"'+'/MyUsed/tegfriend.nhn?name='+word.split('@')+'&writer='+'${replelist.mem_num}'+'"';
			    word = '<a href='+url+'>'+word+'</a>';
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('reple_${replelist.seq_num}').innerHTML = linkedContent; 
	});
	</script>
	
		</td>
		<td width="80%">
			<div id="reple_${replelist.seq_num}">${replelist.content}</div> 
 		</td>
 			
		<td width="5%">
 			<c:if test="${session_num == replelist.mem_num}">
 				<a href="repleDelete.nhn?seq_num=${replelist.seq_num}&boardnum=${num}" onclick="javasciprt:deleteCheck()">
					<img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 0.5em;" align="right" width="15"  height="15" title="�����ϱ�"/>
 				</a>
 			</c:if>
 			<br/>
		</td>
	<tr>
		<td colspan="3">
			<font size="2" color="#9A9DA4">
  				<fmt:formatDate value="${replelist.reg}" type="both" /> 
 			</font>
			<br />
		</td>
	</tr>
	</c:forEach>
	</c:if>
	<tr>
 		<td colspan="3">
			<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${session_num}">
				<img src="/MyUsed/images/profile/${proDTO.profile_pic}" align="left" width="40"  height="35"/>
			</a>
			<input style="padding:7px;" type="text" id="reple" name="reple" size="50" placeholder="����� �Է��ϼ���..."/> <!--  onkeydown="findteg()"  -->
			<input type="image" src="/MyUsed/images/submitReple.png" width="30" height="20" title="��۴ޱ�"/>
			
		</td>
	</tr>
	</table>
	<br />
</form>


</body>