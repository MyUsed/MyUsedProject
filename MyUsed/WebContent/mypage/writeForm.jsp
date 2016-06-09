<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<form name="formId" enctype="multipart/form-data" action="Write.nhn" method="post">

	<table align="center" width="550" height="200">
		<tr bgcolor="#FFFFFF">
			<td align="center" colspan="9">
				<textarea rows="5" cols="73"name="content" placeholder="���� ������ �ϰ��Ű��� ?"></textarea> <br />
				<hr width="80%">
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<c:forEach var="i" begin="1" end="8">
				<td align="center" width="13%">
					<!-- �̹��� �̸�����  --> 
					<c:if test="${i==1}">
						<img src="/MyUsed/images/mainPic.PNG" width="15" height="15" title="���λ���" />
					</c:if> 
					<label for="image${i}"> 
						<img src="/MyUsed/images/cameraUp.PNG" width="25" height="25" style='cursor: pointer;' title="����" />
					</label> 
					<input type="file" name="image${i}" id="image${i}" style='display: none;'>


					<div id="image${i}_preview" style='display: none;'>
						<img src="/MyUsed/images/option.png" width="70" height="70" /> 
						<br /> 
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
					        $('#writeform').attr('style', 'height:385px;');
					        $('#list').attr('style', 'margin-top:870px;');
				            $('#image${i}_preview').slideDown(); //���ε��� �̹��� �̸����� 
				            $(this).slideUp(); //���� ��� ����
				        }
				    });
				    $('#image${i}_preview a').bind('click', function() {
				        resetFormElement($('#image${i}')); //������ ��� �ʱ�ȭ
				        //$('#image${i}').slideDown(); //���� ��� ������
				        $(this).parent().slideUp(); //�̸� ���� ���� ����
				        $('#writeform').attr('style', 'height:300px;');
				        $('#list').attr('style', 'margin-top:790px;');
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
		<tr bgcolor="#FFFFFF" align="center" height="40">
			<td colspan="8">
				<label for="button1" style="cursor:pointer;">
	 				<img src="/MyUsed/images/submit.PNG" title="����ϱ�" />
	 			</label>
	 			<input type="submit" id="button1" style="display:none;">
			</td>
		</tr>

	</table>

	<br /> <br />

</form>

<!--  ��ǰ ���� ������  -->	






</div>
	


	 
	 
	 
	 
	 
	 
