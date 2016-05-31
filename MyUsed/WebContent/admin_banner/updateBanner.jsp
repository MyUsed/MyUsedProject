<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>광고 수정 페이지</title>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>

<!---------------------- 작업할때 2개만 include 해서 사용 ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->
<center>
	
	
	
		<h2> * 광고 수정 * </h2>
		
		 <form name="formId" enctype="multipart/form-data" action="updateBannerSubmit.nhn" method="post" >
		<table width="800" height="500">
		
			<tr>
			<td colspan="2" height="10" align="center">
				<strong>광고 정보</strong>
			</td>
			</tr>
			<tr>
			
			<td rowspan="2" align="center"> <br/>
			
			
			
			<div id="image_preview" style='display: block;'>
		        <img src="/MyUsed/images/${applyDTO.img}" width="250" height="400"/>
		    </div>
		    
		    	<label for="image">
       		 <img src="/MyUsed/images/cameraUp.PNG" width="35" height="35" style='cursor:pointer;' title="사진"/>
        		</label>
   		  		<input type="file" name="image" id="image" style='display: none;'>
    <script type="text/javascript">

    $('#image').on('change', function() {
        
        ext = $(this).val().split('.').pop().toLowerCase(); //확장자
        
        //배열에 추출한 확장자가 존재하는지 체크
        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($(this)); //폼 초기화
            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
        } else {
            file = $('#image').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            $('#image_preview img').attr('src', blobURL);
            $('#image_preview').slideDown(); //업로드한 이미지 미리보기 
            $(this).slideUp(); //파일 양식 감춤
        }
    });
    $('#image_preview a').bind('click', function() {
        resetFormElement($('#image')); //전달한 양식 초기화
        $('#image').slideDown(); //파일 양식 보여줌
        $(this).parent().slideUp(); //미리 보기 영역 감춤
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
		    
			
			
			
			
			
			
			<br /><br />
			<a href="bannerInsert.nhn?img=${applyDTO.img}&url=${applyDTO.url}">
			
			</a>
			</td>
			<td align="center">
	
			<strong>* link Address </strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <a href="http://${applyDTO.url}">http://${applyDTO.url}</a> <br/>
		    <strong>* Change Address</strong>&nbsp;&nbsp;
		    <input type="text" name="url" placeholder="ex) www.naver.com"/> <br/><br/><br/>
		    <input type="image" src="/MyUsed/images/updateBanner.PNG" width="50" height="40" title="수정완료" style='cursor:pointer;'/>
			</td>
			
			</tr>
			<tr>
			
			
			
			
			</tr>
			
		</table>
	
	</form>
		
	
	

</center>

</body>
</html>