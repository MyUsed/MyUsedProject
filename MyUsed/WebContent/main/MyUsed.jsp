<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="/MyUsed/main/script.js"></script>
<script src="/MyUsed/main/animate.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>


<title>MyUsed</title>

<script type="text/javascript">
//----------------- ģ�� ��� �ǽð� --------------------------------------------------------
$(document).ready(function(){
	window.setInterval('myfriendlist()', 10000); //5�ʸ����ѹ��� �Լ��� �����Ѵ�..!! 
});
function myfriendlist(){
	 $.ajax({
	        type: "post",
	        url : "/MyUsed/FriendList.nhn",
	        success: list,	// ��������û ������ ���� �Լ�
	        error: whenError	//��������û ���н� �����Լ�
  	});
}
function list(aaa){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
    $("#sidebannerR").html(aaa);
}
function whenError(){
    alert("FriendListError");
} 




// ----------------------------------���ƿ� �̹�Ʈ ó��---------------------------------
var count;
function likeAjax(num,c){
	
	
	count = c;
	
	 $.ajax({
	        type: "post",
	        url : "likeup.nhn",
	      	data: {	// url �������� ������ �Ķ����
        	num : num //������ �ѹ�
        },
	        success: test,	// ��������û ������ ���� �Լ�
	        error: whenError	//��������û ���н� �����Լ�
  	});
}
function test(aaa){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
	
	$("#likewow"+count).html(aaa);	//id�� ajaxReturn�� �κп� �־��
    
}
function whenError(){
    alert("Error");
}


var count;
function likedownAjax(num,c){
	
	
	count = c;
	
	 $.ajax({
	        type: "post",
	        url : "likedown.nhn",
	      	data: {	// url �������� ������ �Ķ����
        	num : num //������ �ѹ�
        },
	        success: test,	// ��������û ������ ���� �Լ�
	        error: whenError	//��������û ���н� �����Լ�
  	});
}
function test(aaa){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
	
	$("#likewow"+count).html(aaa);	//id�� ajaxReturn�� �κп� �־��
    
}
function whenError(){
    alert("Error");
}


</script>


</head>
<body>



<div id="layer_fixed"><jsp:include page="layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->
<div id="sidebannerR"><jsp:include page="/mypage/friendList.jsp"/></div> <!-- ���̵��� Right  -->
<div id="advertise" ><jsp:include page="advertise.jsp"/></div>  <!-- ���� ������  -->
<div id="sidebannerL"><jsp:include page="sidebannerL.jsp"/></div> <!-- ���̵��� Left -->






<div id="contents">   <!-------------------------------- ���� ���� ------------------------------------------>


	
	
	
	
	
<!------------------------------------------------------- �˸� �޽��� --------------------------------------------------->
<div id="arrow" style='display:none;'>
	<img src="/MyUsed/images/arrow.png" width="0" height="0"> 
</div>
<div id="msgPop" style='display:none;'>
    <br/>
	<div id="closemsg">
		<label for="close4" style="cursor:pointer;">
			<img src="/MyUsed/images/close.png" width="15" height="15">
		</label>
    </div>
    
   	<input type="button" id="close4" OnClick="javascript:closeMsg()" style='display: none;'>
   	<br />
   	<div id="msgtitle">
   		<font size="3"><b>�˸� Ȯ��</b></font>
   	</div>
   	
   	<div id="msgtext">
   	
   	
   		<c:forEach var="noticelist" items="${noticelist}">
   			
   			(<strong> <a href="MyUsedMyPage.nhn?mem_num=${noticelist.call_memnum}">${noticelist.call_name}</a> </strong>) 
   			
   			<a Onclick="javascript:tradeCheck(${noticelist.call_memnum},${noticelist.pro_num})" style="cursor:pointer;">
   			<c:if test="${noticelist.categ == 'product'}">
   			<b>���� �ŷ���û �Ͽ����ϴ�.</b> 
   			</c:if>
   			</a>
   			<a href="paperMain.nhn?mynum=${noticelist.board_num}" onclick="javascript:NoticeUpdate(${noticelist.board_num},${noticelist.call_memnum})">
   			<c:if test="${noticelist.categ == 'msg'}">
   			<b>���� �޼����� �����̽��ϴ�.</b>
   			</c:if>
   			</a>
   			<a href="MyUsedMyPage.nhn?mem_num=${noticelist.board_num}" onclick="javascript:NoticeUpdateFriend(${noticelist.board_num},${noticelist.call_memnum})" >
   			<c:if test="${noticelist.categ == 'friend'}">
   			<b>���� ģ����û�� �Ͽ����ϴ�.</b>
   			</c:if>
   			</a>
   			<a href="" onclick="javascript:NoticeUpdateFriend(${noticelist.board_num},${noticelist.call_memnum})" >
   			<c:if test="${noticelist.categ == 'board'}">
   			<b>���� �Խù��� �±� �Ͽ����ϴ�.</b>
   			</c:if>
   			</a>
   			<br /> &nbsp;
   			<font size="2" color="#9A9DA4">
  			<fmt:formatDate value="${noticelist.reg}" type="both" /> 
 			</font>
   			<hr width="90%" />
   		</c:forEach>
   	
   		
   	
   	
   	
   	
 	</div>
   	
</div>
	
	
	
	
	
	
<!-- --------------------------------------------------------------------------------------------------------------- -->	
	<br /><br /><br />
	
	
	 <form name="formId" enctype="multipart/form-data" action="mainSubmit.nhn" method="post" >
	 
	 
	 <table align="center"  width="550" height="30">
	 <tr bgcolor="#FFFFFF">
	 <td align="center" colspan="8">
	 <input type="radio" name="deposit" value="update" onclick='javascript:fncChecked(1);' ${checked}><font size="3" color="#3B5998" face="Comic Sans MS"><b>SNS</b></font>
     <input type="radio" name="deposit" value="product" onclick='javascript:fncChecked(2);'${checked1}><font size="3" color="#3B5998"  face="Comic Sans MS"><b>Trade</b></font>
	 </td>
	 </tr>
	 </table>

	
	<!--  --------------------------------------------- �Ϲ� ---------------------------------------------------- -->
	 
	
<div id='div1' style='display:${view};'>
	 <table align="center"  width="550" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<font size="2" color="#3B5998" >���� ������Ʈ</font> 
		  <hr width="80%"  > 
	</td>
	</tr>
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	
		
		<textarea rows="5" cols="73" name="content" placeholder="���� ������ �ϰ��Ű��� ?"></textarea>
	
		<br/> 
		
		
		<hr width="80%"  > 
		
	
	</td>
	
	</tr>
	<tr bgcolor="#FFFFFF">
	

	
	
	
		<c:forEach var="i" begin="1" end="8">
    <td align="center"  >
<!-- �̹��� �̸�����  -->


  
 
<c:if test="${i==1}">
<img src="/MyUsed/images/mainPic.PNG" width="15" height="15" title="���λ���"/>
</c:if>
        <label for="image${i}">
        <img src="/MyUsed/images/cameraUp.PNG" width="25" height="25" style='cursor:pointer;' title="����"/>
        </label>
   		
        <input type="file" name="image${i}" id="image${i}" style='display: none;'>
	
   
    <div id="image${i}_preview" style='display: none;'>
        <img src="/MyUsed/images/option.png" width="70" height="70"/>
        <a href="#">Remove</a>
    </div>


    <script type="text/javascript">
 
    
    $('#image${i}').on('change', function() {
        
        ext = $(this).val().split('.').pop().toLowerCase(); //Ȯ����
        
        //�迭�� ������ Ȯ���ڰ� �����ϴ��� üũ
        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($(this)); //�� �ʱ�ȭ
            window.alert('�̹��� ������ �ƴմϴ�! (gif, png, jpg, jpeg �� ���ε� ����)');
        } else {
            file = $('#image${i}').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            $('#image${i}_preview img').attr('src', blobURL);
            $('#image${i}_preview').slideDown(); //���ε��� �̹��� �̸����� 
            $(this).slideUp(); //���� ��� ����
        }
    });
    $('#image${i}_preview a').bind('click', function() {
        resetFormElement($('#image${i}')); //������ ��� �ʱ�ȭ
        $('#image${i}').slideDown(); //���� ��� ������
        $(this).parent().slideUp(); //�̸� ���� ���� ����
        return false; //�⺻ �̺�Ʈ ����
    });	
  
    function resetFormElement(e) {
        e.wrap('<form>').closest('form').get(0).reset(); 
        //�����Ϸ��� ����� ��Ҹ� ��(<form>) ���� ���ΰ� (wrap()) , 
        //��Ҹ� ���ΰ� �ִ� ���� ����� ��( closest('form')) ���� Dom��Ҹ� ��ȯ�ް� ( get(0) ),
        //DOM���� �����ϴ� �ʱ�ȭ �޼��� reset()�� ȣ��
        e.unwrap(); //���� <form> �±׸� ����
    }
    
    
    
    
	
    
    
    </script>
  
</td>
</c:forEach>
<!-- �̹��� �̸�����  -->


</tr>
	<tr bgcolor="#FFFFFF" align="center"	>
		<td colspan="8">
	 	<img src="/MyUsed/images/submit.PNG" style='cursor:pointer;' onclick="javascript_:send();" title="����ϱ�" />
	 	</td>
	</tr> 	
	
	
	</table>
	
	<br /> <br />
	
</form>

<!--  ��ǰ ���� ������  -->	



<c:forEach var="list" items="${list}"  varStatus="i">	
<form name="reple" action="reple.nhn" method="post" >

	
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
		<a href="MypageModal.nhn?num=${list.num}">	
		<img src="/MyUsed/images/${list.mem_pic}" width="470" height="300"/>
		</a>
		 <br/> <br />
		</c:if>
		<!-- �Ϲ� �Խñ� �ؽ��±� -->	
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

		

<!--  ��ǰ ���� ������  -->	

</form>	 
</c:forEach>



</div>
	

	 
<div id='div2_categ' style='display:${view2};' > 
	 <!--  �Ϲݻ�ǰ ���  -->
	 	
<table align="center"  width="550" height="30">
<tr bgcolor="#FFFFFF">
	<td align="left">
	<center><font size="2" color="#3B5998">��ǰ ���</font> </center>
		  <hr width="80%"  > 
	<select name="categ0" id="categ0">
		<option>--------1��--------</option>
		<c:forEach var="categ" items="${categList}">
			<option>${categ.categ}</option>
		</c:forEach>
	</select>
	<input id="button" type="image" src="/MyUsed/images/agree.PNG" width="15" height="" value="Ȯ��" onClick="callAjax()">
	<br />
	</td>
</tr>
</table>
	 
</div>
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 <!--  --------------------------------------------- ��ǰ ---------------------------------------------------- -->
	 
	 
<div id='div2'  style='display:${view2};'  >
	
	<table align="center"  width="550" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<br/>
	
		<textarea rows = "5" cols = "73" name="contents" placeholder="��ǰ�� ���� ������ ���ּ���" onkeyup="alarm('ī�װ��� �����ϰ� �ۼ��ϼ���!')"></textarea> <br/> 
		<font size ="2" color="#3B5998">
		* ��۷�
		����(����) <input type="radio" name="sendPay" value="yes" />
		������(����) <input type="radio" name="sendPay" value="no"  />
		</font>
		<br />
		<input type="text" name="price" size="7" value="0000" placeholder="��ǰ����"/>
		<hr width="80%"  > 	
	
	</td>
	
	</tr>
	<tr bgcolor="#FFFFFF">

	
		<c:forEach var="i" begin="1" end="8">
    <td align="center"  >
<!-- �̹��� �̸�����  -->

  
 
<c:if test="${i==1}">
<img src="/MyUsed/images/mainPic.PNG" width="15" height="15" title="���λ���"/>
</c:if>

        <label for="pimage${i}">
		<img src="/MyUsed/images/box.PNG" width="25" height="25" style='cursor:pointer;' title="��ǰ����"/>
		</label>
   
        <input type="file" name="pimage${i}" id="pimage${i}" style='display: none;'>
	
   
    <div id="pimage${i}_preview" style='display: none;'>
        <img src="/MyUsed/images/option.png" width="70" height="70"/>
        <a href="#">Remove</a>
    </div>


    <script type="text/javascript">
 
    
    $('#pimage${i}').on('change', function() {
        
        ext = $(this).val().split('.').pop().toLowerCase(); //Ȯ����
        
        //�迭�� ������ Ȯ���ڰ� �����ϴ��� üũ
        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($(this)); //�� �ʱ�ȭ
            window.alert('�̹��� ������ �ƴմϴ�! (gif, png, jpg, jpeg �� ���ε� ����)');
        } else {
            file = $('#pimage${i}').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            $('#pimage${i}_preview img').attr('src', blobURL);
            $('#pimage${i}_preview').slideDown(); //���ε��� �̹��� �̸����� 
            $(this).slideUp(); //���� ��� ����
        }
    });
    $('#pimage${i}_preview a').bind('click', function() {
        resetFormElement($('#pimage${i}')); //������ ��� �ʱ�ȭ
        $('#pimage${i}').slideDown(); //���� ��� ������
        $(this).parent().slideUp(); //�̸� ���� ���� ����
        return false; //�⺻ �̺�Ʈ ����
    });	
  
    function resetFormElement(e) {
        e.wrap('<form>').closest('form').get(0).reset(); 
        //�����Ϸ��� ����� ��Ҹ� ��(<form>) ���� ���ΰ� (wrap()) , 
        //��Ҹ� ���ΰ� �ִ� ���� ����� ��( closest('form')) ���� Dom��Ҹ� ��ȯ�ް� ( get(0) ),
        //DOM���� �����ϴ� �ʱ�ȭ �޼��� reset()�� ȣ��
        e.unwrap(); //���� <form> �±׸� ����
    }
    </script>
    
<script type="text/javascript">
/* ���ϱ� ajax */
    function choiceAjax(coun){
        $.ajax({
	        type: "post",
	        url : "choiceInsert.nhn",
	        data: {	// url �������� ������ �Ķ����
	        	num : $('#num'+coun).val(),
       			mem_num : $('#mem_num'+coun).val(),
       			mem_name : $('#mem_name'+coun).val(),
       			price : $('#price'+coun).val(),
       			pro_pic : $('#pro_pic'+coun).val(),
       			content : $('#content'+coun).val(),
	        },
	        success: choice,	// ��������û ������ ���� �Լ�
	        error: whenError	//��������û ���н� �����Լ�
     	});
    }
    function choice(choice){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
    	if(confirm("�� �Խù��� ���Ͻðڽ��ϱ�?") == true){
        	$("#ajaxChoice").html(choice);
        	console.log(resdata);
    	}
        else{
			return false;
		}
    }
    function whenError(){
        alert("Error");
    }
</script>
    
</td>
</c:forEach>
<!-- �̹��� �̸�����  -->


</tr>
	<tr bgcolor="#FFFFFF" align="center"	>
		<td colspan="8">
	 	<img src="/MyUsed/images/submit.PNG" style='cursor:pointer;' title="����ϱ�" onclick="javascript_:send();" />
	 	</td>
	</tr> 	
	</table>

	 
	 <br /> <br />

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
		
		<c:if test="${prolist.sendpay != null}"> 
		<font size="2" color="#8C8C8C">* ��۷�${prolist.sendpay}</font> <br/>
		<font size="3" color="#1F51B7" ><b><fmt:formatNumber value="${prolist.price}" type="number" />��</b></font> <br /><br />
		</c:if>
		<c:if test="${prolist.sendpay == null}"> 
		 <br/>
		<font size="3" color="#4374D9" > <b>�ŷ����Դϴ�</b> </font> <br /><br />
		</c:if>
		<font size="3" color="#D7D2FF" >
		����������������������������<font size="3" color="#A6A6A6" face="Comic Sans MS"> Detail </font>����������������������������
		</font>
		<!-- ��ǰ �Խñ� �ؽ��±� -->	
	<script type="text/javascript">
	$(document).ready(function(){
		var content = document.getElementById('procontent').innerHTML;
		var splitedArray = content.split(' ');
		var linkedContent = '';
		for(var word in splitedArray)
		{
		  word = splitedArray[word];
		   if(word.indexOf('#') == 0)
		   {
				var url = '"'+'/MyUsed/protegSearch.nhn?word='+word.split('#')+'"';
			    word = '<a href='+url+'>'+word+'</a>';
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('procontent').innerHTML = linkedContent; 
	});
	</script>
		
		 <br/>
		 <div id="procontent">
		${prolist.content}
		</div>
		
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
		
			<c:if test="${prolist.sendpay != null}"> 
			<a id="choiceB${i.count}" onclick="choiceAjax('${i.count}')"><img src="/MyUsed/images/choIcon.png" title="���ϱ�" width="25" height="25" style='cursor:pointer;'/><font size="2" color="#9A9DA4" style='cursor:pointer;'>���ϱ�</font></a>
			</c:if>
			
			<a href="ProductDetailView.nhn?num=${prolist.num}"><img align="right" style="padding:2px" src="/MyUsed/images/buyIcon.PNG" width="55" height="45" title="�����ϱ�"/></a>
			
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

