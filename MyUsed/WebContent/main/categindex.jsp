<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<html lang="ko">
<head>

 		<script type="text/javascript">
        
              function fncChecked(num)
              {
               if(num == 1)
               {
                div1.style.display = '';
                div2.style.display = 'none';
               }
               else if(num == 2)
               {
                div1.style.display = 'none';
                div2.style.display = '';  
               }
               else
               {
                div1.style.display = 'none';
                div2.style.display = 'none';
               }
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
 	
 	<br /><br />
 	
<form name="formId2" enctype="multipart/form-data" action="proSubmit.nhn" method="post" >
	 <table align="center"  width="550" height="30">
	 <tr bgcolor="#FFFFFF">
	 <td align="center" colspan="8">
	 <input type="radio" name="deposit" value="update" onclick='javascript:fncChecked(1);' ${checked}><font size="3" color="#3B5998" face="Comic Sans MS"><b>SNS</b></font>
     <input type="radio" name="deposit" value="product" onclick='javascript:fncChecked(2);'checked><font size="3" color="#3B5998"  face="Comic Sans MS"><b>Trade</b></font>
	 </td>
	 </tr>
	 
	
<tr bgcolor="#FFFFFF">
	<td align="left">
	<center><font size="2" color="#3B5998">��ǰ ���</font> </center>
		  <hr width="80%"  > 
	
	<br />
	</td>
</tr>
</table> 
	 

	 <!--  �Ϲݻ�ǰ ���  -->
	 
<div id='div2' >
	
	<table align="center"  width="550" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="left" colspan="8">

	<select name="categ1" id="categ1">
		<option>--------2��--------</option>
		<c:forEach var="categ" items="${categList}">
			<option>${categ.categ}</option>
		</c:forEach>
	</select>
	
	<input type="hidden" name="categ0" value="${categ0}"/>
	<input type="hidden" name="deposit" value="product"/>
	
	<br /><br />


		<textarea rows = "5" cols = "73" name="content" placeholder="��ǰ�� ���� ������ ���ּ���"></textarea> <br/> 
		<center>
		<font size ="2" color="#3B5998">
		* ��۷�
		����(����) <input type="radio" name="sendPay" value="(����)" />
		������(����) <input type="radio" name="sendPay" value="(������)"  />
		</font>
		<br />
		<input type="text" name="price" size="7" placeholder="��ǰ����"/>
		<hr width="80%"  > 
		</center>
	
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
</td>
</c:forEach>
<!-- �̹��� �̸�����  -->


</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td colspan="8">
	 	<input type="image" src="/MyUsed/images/submit.PNG" border="0" style='cursor:pointer;' title="����ϱ�"/>
	 	</td>
	</tr> 	
	
	
	</table>
	
</div>
</form>


<br /> <br />
<c:forEach var="prolist" items="${prolist}">
	
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${prolist.mem_num}"><font face="Comic Sans MS">( ${prolist.name} )</font></a>
		<font face="Comic Sans MS" size="2" color="#A6A6A6" > ���� ��ǰ�� �Խ��Ͽ����ϴ�</font>  
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
		<img src="/MyUsed/images/${prolist.pro_pic}" width="370" height="350"/> <br/>
		</c:if>
		
		
		 <font size="3" color="#1F51B7" ><b><fmt:formatNumber value="${prolist.price}" type="number" />��</b></font> <br /><br />
		
		<font size="3" color="#D7D2FF" >
		����������������������������<font size="3" color="#A6A6A6" face="Comic Sans MS"> Detail </font>����������������������������
		</font>
		 <br/>
		${prolist.content}
			
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"  > 
		 <a href="ProductDetailView.nhn?num=${prolist.num}"><img src="/MyUsed/images/reple.PNG"/><font size="2" color="#9A9DA4">��� ${prolist.reples}��</font></a>
		
			<a id="choiceB${i.count}" onclick="choiceAjax('${i.count}')"><img src="/MyUsed/images/choIcon.png" title="���ϱ�" width="25" height="25" style='cursor:pointer;'/><font size="2" color="#9A9DA4">���ϱ�</font></a>
			<a href="ProductDetailView.nhn?num=${prolist.num}"><img align="right" style="padding:2px" src="/MyUsed/images/buyIcon.PNG" width="55" height="45" title="�����ϱ�"/></a>
			
		</td>
		</tr>

	</table>
 	<br />	
 	

<!--  ��ǰ ���� ������  -->	
	 
</c:forEach>

	 
	 
<br /> <br />
</html>




