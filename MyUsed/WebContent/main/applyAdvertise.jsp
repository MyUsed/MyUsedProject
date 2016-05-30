<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="/MyUsed/main/script.js"></script>
<script src="/MyUsed/main/animate.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>


 

</head>
<body>

<div id="layer_fixed"><jsp:include page="layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->
<div id="sidebannerR"><jsp:include page="sidebannerR.jsp"/></div> <!-- ���̵��� Right  -->
<div id="advertise" ><jsp:include page="advertise.jsp"/></div>  <!-- ���� ������  -->
<div id="sidebannerL"><jsp:include page="sidebannerL.jsp"/></div> <!-- ���̵��� Left -->

		
	<div id="contents">   <!-------------------------------- ���� ���� ------------------------------------------>
	<br /><br /><br />
	
	<center>
	 <form name="formId" enctype="multipart/form-data" action="applyBannerSubmit.nhn" method="post" >
	 
		<h2> <font color="#4565A1">����/���޹���</font></h2> <br />		
		<table width="600" height="500" >
		
			<tr>
			<td colspan="3" height="10" align="center">
				<strong><font color="#4565A1">- ��û - </font></strong>
			</td>
			</tr>
			<tr>
			
			<td rowspan="2" align="center" width="300" height="350">
			
			  
		    <div id="image_preview" style='display: none;'>
		        <img src="/MyUsed/images/option.png" width="300" height="350"/>
		        <a href="#">Remove</a>
		    </div>
		    
		    	<label for="image">
       		 <img src="/MyUsed/images/cameraUp.PNG" width="35" height="35" style='cursor:pointer;' title="����"/>
        		</label>
   		  		<input type="file" name="image" id="image" style='display: none;'>
    <script type="text/javascript">

    $('#image').on('change', function() {
        
        ext = $(this).val().split('.').pop().toLowerCase(); //Ȯ����
        
        //�迭�� ������ Ȯ���ڰ� �����ϴ��� üũ
        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($(this)); //�� �ʱ�ȭ
            window.alert('�̹��� ������ �ƴմϴ�! (gif, png, jpg, jpeg �� ���ε� ����)');
        } else {
            file = $('#image').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            $('#image_preview img').attr('src', blobURL);
            $('#image_preview').slideDown(); //���ε��� �̹��� �̸����� 
            $(this).slideUp(); //���� ��� ����
        }
    });
    $('#image_preview a').bind('click', function() {
        resetFormElement($('#image')); //������ ��� �ʱ�ȭ
        $('#image').slideDown(); //���� ��� ������
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

			<td align="center">
			<input type="text" name="hostname" style="padding:2px"  placeholder="��ü��" size="10" /> 
			<input type="text" name="name" style="padding:2px"  placeholder="����"  size="10"/> <br/> <br/>
			
			<input type="text" name="ph" style="padding:2px"  placeholder="��ȭ��ȣ ( -���� )" /> <br/><br/>
			<input type="text" name="email" style="padding:2px"  placeholder="�����ּ�" /> <br/> <br/>
			
			
			  
   		  
			<textarea name="" rows="5" cols="35" placeholder="����" ></textarea> <br /> <br />
			
			Http://<input type="text" name="url" style="padding:2px"  placeholder="URL" size="24" />  <br/> 
			</td>
			
			
			</tr>
			<tr>
			
			<td colspan="2" align="center">
			<input type="image" src="/MyUsed/images/okIcon.png" style='cursor:pointer;' width="50" height="50" title="����ϱ�" />
			</td>
			
			
			</tr>
			
		</table>
	
	 
	 </form>
	 <br/>
	</center> 
	 </div>

	
</body>
</html>