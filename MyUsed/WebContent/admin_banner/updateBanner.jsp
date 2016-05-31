<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>���� ���� ������</title>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>

<!---------------------- �۾��Ҷ� 2���� include �ؼ� ��� ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->
<center>
	
	
	
		<h2> * ���� ���� * </h2>
		
		 <form name="formId" enctype="multipart/form-data" action="updateBannerSubmit.nhn" method="post" >
		<table width="800" height="500">
		
			<tr>
			<td colspan="2" height="10" align="center">
				<strong>���� ����</strong>
			</td>
			</tr>
			<tr>
			
			<td rowspan="2" align="center"> <br/>
			
			
			
			<div id="image_preview" style='display: block;'>
		        <img src="/MyUsed/images/${applyDTO.img}" width="250" height="400"/>
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
		    
			
			
			
			
			
			
			<br /><br />
			<a href="bannerInsert.nhn?img=${applyDTO.img}&url=${applyDTO.url}">
			
			</a>
			</td>
			<td align="center">
	
			<strong>* link Address </strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <a href="http://${applyDTO.url}">http://${applyDTO.url}</a> <br/>
		    <strong>* Change Address</strong>&nbsp;&nbsp;
		    <input type="text" name="url" placeholder="ex) www.naver.com"/> <br/><br/><br/>
		    <input type="image" src="/MyUsed/images/updateBanner.PNG" width="50" height="40" title="�����Ϸ�" style='cursor:pointer;'/>
			</td>
			
			</tr>
			<tr>
			
			
			
			
			</tr>
			
		</table>
	
	</form>
		
	
	

</center>

</body>
</html>