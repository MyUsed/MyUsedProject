<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<form name="formId" enctype="multipart/form-data" action="Write.nhn" method="post">

	<table align="center" width="550" height="200">
		<tr bgcolor="#FFFFFF">
			<td align="center" colspan="9">
				<textarea rows="5" cols="73"name="content" placeholder="무슨 생각을 하고계신가요 ?"></textarea> <br />
				<hr width="80%">
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<c:forEach var="i" begin="1" end="8">
				<td align="center" width="13%">
					<!-- 이미지 미리보기  --> 
					<c:if test="${i==1}">
						<img src="/MyUsed/images/mainPic.PNG" width="15" height="15" title="메인사진" />
					</c:if> 
					<label for="image${i}"> 
						<img src="/MyUsed/images/cameraUp.PNG" width="25" height="25" style='cursor: pointer;' title="사진" />
					</label> 
					<input type="file" name="image${i}" id="image${i}" style='display: none;'>


					<div id="image${i}_preview" style='display: none;'>
						<img src="/MyUsed/images/option.png" width="70" height="70" /> 
						<br /> 
						<a href="#">Remove</a>
					</div> 
					
					<script type="text/javascript">
				    $('#image${i}').on('change', function() {
				        
				        ext = $(this).val().split('.').pop().toLowerCase(); //확장자
				        
				        //배열에 추출한 확장자가 존재하는지 체크
				        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
				            resetFormElement($(this)); //폼 초기화
				            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
				        } else {
				            file = $('#image${i}').prop("files")[0];
				            blobURL = window.URL.createObjectURL(file);
				            $('#image${i}_preview img').attr('src', blobURL);
					        $('#writeform').attr('style', 'height:385px;');
					        $('#list').attr('style', 'margin-top:870px;');
				            $('#image${i}_preview').slideDown(); //업로드한 이미지 미리보기 
				            $(this).slideUp(); //파일 양식 감춤
				        }
				    });
				    $('#image${i}_preview a').bind('click', function() {
				        resetFormElement($('#image${i}')); //전달한 양식 초기화
				        //$('#image${i}').slideDown(); //파일 양식 보여줌
				        $(this).parent().slideUp(); //미리 보기 영역 감춤
				        $('#writeform').attr('style', 'height:300px;');
				        $('#list').attr('style', 'margin-top:790px;');
				        return false; //기본 이벤트 막음
				    });	
				  
				    function resetFormElement(e) {
				        e.wrap('<form>').closest('form').get(0).reset(); 
				        //리셋하려는 폼양식 요소를 폼(<form>) 으로 감싸고 (wrap()) , 
				        //요소를 감싸고 있는 가장 가까운 폼( closest('form')) 에서 Dom요소를 반환받고 ( get(0) ),
				        //DOM에서 제공하는 초기화 메서드 reset()을 호출
				        e.unwrap(); //감싼 <form> 태그를 제거
				    }
				    </script>
				</td>
			</c:forEach>
			<!-- 이미지 미리보기  -->

		</tr>
		<tr bgcolor="#FFFFFF" align="center" height="40">
			<td colspan="8">
				<label for="button1" style="cursor:pointer;">
	 				<img src="/MyUsed/images/submit.PNG" title="등록하기" />
	 			</label>
	 			<input type="submit" id="button1" style="display:none;">
			</td>
		</tr>

	</table>

	<br /> <br />

</form>

<!--  상품 보기 페이지  -->	






</div>
	


	 
	 
	 
	 
	 
	 
