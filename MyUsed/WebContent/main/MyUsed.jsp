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
</head>
<body>



<div id="layer_fixed"><jsp:include page="layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->
<div id="sidebannerR"><jsp:include page="sidebannerR.jsp"/></div> <!-- ���̵��� Right  -->
<div id="advertise" ><jsp:include page="advertise.jsp"/></div>  <!-- ���� ������  -->
<div id="sidebannerL"><jsp:include page="sidebannerL.jsp"/></div> <!-- ���̵��� Left -->


<div id="contents">   <!-------------------------------- ���� ���� ------------------------------------------>
	<br /><br /><br />
	
	
	 <form name="formId" enctype="multipart/form-data" action="mainSubmit.nhn" method="post" >
	 
	 
	 <table align="center"  width="550" height="30">
	 <tr bgcolor="#FFFFFF">
	 <td align="center" colspan="8">
	 <input type="radio" name="deposit" value="update" onclick='javascript:fncChecked(1);' ${checked}>State
     <input type="radio" name="deposit" value="product" onclick='javascript:fncChecked(2);'${checked1}>Product
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
        <img src="/MyUsed/images/cameraIcon.PNG" width="25" height="25"/>
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
	 	<img src="/MyUsed/images/submit.PNG" onclick="javascript_:send();" />
	 	</td>
	</tr> 	
	
	
	</table>
	
	<br /> <br />
	
</form>

<!--  ��ǰ ���� ������  -->	



<c:forEach var="list" items="${list}">	
<form name="reple" action="reple.nhn" method="post" >

	
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${list.mem_num}">( ${list.name} )</a> ���� ���� �Խ��Ͽ����ϴ�  
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
		${list.content}
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"  > 
		
		���ƿ�  / �����ϱ� / <a href="reple.nhn?num=${list.num}"><img src="/MyUsed/images/replego.PNG"/></a>
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		
		
		
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
	<td align="center">
	<font size="2" color="#3B5998" >��ǰ ���</font> 
		  <hr width="80%"  > 
	<select name="categ0" id="categ0">
		<option>--------1��--------</option>
		<c:forEach var="categ" items="${categList}">
			<option>${categ.categ}</option>
		</c:forEach>
	</select>
	<input id="button" type="button" value="Ȯ��" onClick="callAjax()">
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
	
		<textarea rows = "5" cols = "73" name="contents" placeholder="��ǰ�� ���� ������ ���ּ���"></textarea> <br/> 
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

  
 


        <label for="pimage${i}">Image${i}</label>
   
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
	<tr bgcolor="#FFFFFF" align="center"	>
		<td colspan="8">
	 	<img src="/MyUsed/images/submit.PNG" onclick="javascript_:send();" />
	 	</td>
	</tr> 	
	</table>

	 
	 <br /> <br />

<c:forEach var="prolist" items="${prolist}">
	
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${prolist.mem_num}">( ${prolist.name} )</a> ���� ���� �Խ��Ͽ����ϴ�  
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:if test="${prolist.mem_num == memDTO.num}">
		<a href="prodelete.nhn?num=${prolist.num}">�Խñۻ���</a>
		</c:if>
		
		<hr width="100%" > 
		</td>
		</tr>
		
		<tr  bgcolor="#FFFFFF">
		<td align="center">
		
		<c:if test="${prolist.pro_pic != null}"> 
		<img src="/MyUsed/images/${prolist.pro_pic}" width="370" height="350"/> <br/>
		</c:if>
		
		
		 <font size="5" color="#1F51B7" >[${prolist.price}\] </font> <br /><br />
		
		<font size="3" color="#0042ED" >
		-------------------------------- * �󼼼��� * -------------------------------- 
		</font>
		 <br/>
		${prolist.content}
		
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

