<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<html lang="ko">
<head>

 		<script type="text/javascript">
        
              function send(){     
        

                   document.formId.method = "post"     // method ����, get, post
                   document.formId.action = "mainTest.nhn";  // submit �ϱ� ���� ������ 

                   document.formId.submit();
                   document.formId.image_preview();
                  
              }
              
            
              
   
              
             
         </script>




	
	<title>MyUsed</title>
	<style type="text/css">
		#layer_fixed
		{
			height:50px;
			width:120%;
			color: #242424;
			font-size:12px;
			position:fixed;
			z-index:999;
			top:0px;
			left:0px;
			-webkit-box-shadow: 0 1px 2px 0 #777;
			box-shadow: 0 1px 2px 0 #777;
			background-color:#3B5998;
		}
		
		input[type=text] {
 		padding: 5px;
 		text-align: center;
 		margin: 0px;
		}
		
		
	</style>
</head>





<body>
	<div id="layer_fixed">
				<table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
		<tr>
			<td style="vertical-align:left; padding-left: 30px; padding-right: 80px;">
			<a href="http://localhost:8000/MyUsed/MyUsed.nhn">
			<img src="/MyUsed/images/Mlogo2.png" width="170"  height="50">
			</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" size="70"/>
				<button type="submit"><img src="/MyUsed/images/Search.png" width="20"  height="20"></button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<img src="/MyUsed/images/profile.png" width="15"  height="15">
				<a href="/MyUsed/MyUsedMyPage.nhn">${name}</a> | 
				<a href="/MyUsed/MyUsed.nhn">Ȩ</a> | 
				<a href="/MyUsed/MyUsed.nhn">ģ��ã��</a>
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainFriend.png" width="45"  height="40"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainMessage.png" width="40"  height="35"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainView.png" width="40"  height="35"></a>
			</td>
			
		</tr>
		</table>
	</div>



<style type="text/css">
#sidebannerR { position:fixed; top:50px; left:45%; margin-left:540px; width:240px; height:800px; background:#EAEAEA; }
#sidebannerL { position:fixed; top:50px; right:50%; margin-right:465px; width:205px; height:800px; background:#E9EAED; }
#content { width:670px; height:9000px; margin:0 auto; margin-left:190px;background:#EAEAEA; }
#advertise {  position:fixed; width:410px; height:9000px; left:57%; margin-right:320px;background:#EAEAEA; }

</style>
</head>

<body>


<div id="sidebannerR">
	<center>
 	<font size="5">���̵����R</font>
   	</center>
</div>

<div id="advertise" >
<br /> <br /> <br />
<center>
	<table align="center" width="280" height="550">
	<tr bgcolor="#FFFFFF">
	<td align="center">
		<hr width="90%" />
	<a href="http://www.iei.or.kr/">
	<img src="/MyUsed/images/adver.PNG" width="270" height="370"/>
		<hr width="90%" />
	</a>
	<a href="http://www.iei.or.kr/"><u>�������� �ٷΰ���</u></a>
	</td>
	</tr>
	</table>
	
	
	
</center>
	
</div>


<div id="sidebannerL">
  
 	
 	<br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/modify.png" width="20" height="20">&nbsp;������ ����</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/newSpeed.png" width="20" height="20">&nbsp;�����ǵ�</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/categ.png" width="20" height="20">&nbsp;ī�װ�</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/chat.png" width="20" height="20">&nbsp;�޼���</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/friend.png" width="20" height="20">&nbsp;ģ������</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/picture.png" width="20" height="20">&nbsp;����</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/favorite.png" width="20" height="20">&nbsp;���ã��</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/address.png" width="20" height="20">&nbsp;�ּ�</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/board.png" width="20" height="20">&nbsp;�Խ���</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/deliver.png" width="20" height="20">&nbsp;��۰���</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/like.png" width="20" height="20">&nbsp;���ƿ�</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/share.png" width="20" height="20">&nbsp;�����ϱ�</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/friendSearch.png" width="20" height="20">&nbsp;ģ��ã��</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/deposit.png" width="20" height="20">&nbsp;�Ա���Ȳ</a>
   	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/option.png" width="20" height="20">&nbsp;����</a>
</div>




<div id="content">
	<br /><br /><br />
	
	
	 <form name="formId" enctype="multipart/form-data" action="mainTest.nhn" method="post" >
	
	<table align="center"  width="570" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<font size="3" color="#3B5998" >��ǰ���</font> 
		  <hr width="80%"  > 
	</td>
	</tr>
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<br/>
		<select name="categ">
                   <option>ī�װ�</option>
                   <option>�Ƿ�</option>
                   <option>������ǰ</option>
                   <option>����</option>
                   <option>Ƽ��</option>
                   <option>��Ÿ</option>
        </select>
        <br />
		<textarea rows = "5" cols = "80" name="content" placeholder="��ǰ�� ���� ������ ���ּ���"></textarea> <br/> 
		<font size ="2" color="#3B5998">
		* ��۷�
		����(����) <input type="radio" name="sendPay" value="yes" />
		������(����) <input type="radio" name="sendPay" value="no"  />
		</font>
		<br />
		<input type="text" name="price" placeholder="��ǰ����"/>
		<hr width="80%"  > 
		
	
	</td>
	
	</tr>
	<tr bgcolor="#FFFFFF">
	

	
	
	
		<c:forEach var="i" begin="1" end="8">
    <td align="center"  >
<!-- �̹��� �̸�����  -->

<style>
  body {
    margin: 20px;
    font-family: "���� ���";
}
  #image_preview {
    display:none;
}
  </style>
  
  <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>


        <label for="image${i}">Image${i}</label>
   
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
	 	<img src="/MyUsed/images/submit.PNG" onclick="javascript_:send();" />
	 	</td>
	</tr> 	
	
	
	</table>
	
	 </form>
	 
	 <br /> <br />

<!--  ��ǰ ���� ������  -->	
	

<c:forEach begin="1" end="10">
	
 	<table align="center"  width="570" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		(   )���� ��ǰ�� �����մϴ�
		<hr width="100%" > 
		</td>
		</tr>
		
		<tr  bgcolor="#FFFFFF">
		<td align="center">
		<img src="/MyUsed/images/sample.jpg" width="550" height="350"/>
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"  > 
		���ƿ� / ��۴ޱ� / �����ϱ� / �����ϱ� 
		</td>
		</tr>

	</table>
 	<br />	
 	

<!--  ��ǰ ���� ������  -->	
	 
</c:forEach>
	 
	 
	 
</div>
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

 	

</body>
</html>


