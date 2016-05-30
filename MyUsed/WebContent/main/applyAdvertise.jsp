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

<div id="layer_fixed"><jsp:include page="layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->
<div id="sidebannerR"><jsp:include page="sidebannerR.jsp"/></div> <!-- 사이드배너 Right  -->
<div id="advertise" ><jsp:include page="advertise.jsp"/></div>  <!-- 광고 페이지  -->
<div id="sidebannerL"><jsp:include page="sidebannerL.jsp"/></div> <!-- 사이드배너 Left -->

		
	<div id="contents">   <!-------------------------------- 메인 내용 ------------------------------------------>
	<br /><br /><br />
	
	<center>
	 <form name="formId" enctype="multipart/form-data" action="applyBannerSubmit.nhn" method="post" >
	 
		<h2> <font color="#4565A1">광고/제휴문의</font></h2> <br />		
		<table width="600" height="500" >
		
			<tr>
			<td colspan="3" height="10" align="center">
				<strong><font color="#4565A1">- 신청 - </font></strong>
			</td>
			</tr>
			<tr>
			
			<td rowspan="2" align="center" width="300" height="350">
			
			  
		    <div id="image_preview" style='display: none;'>
		        <img src="/MyUsed/images/option.png" width="300" height="350"/>
		        <a href="#">Remove</a>
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
		    
			</td>

			<td align="center">
			<input type="text" name="hostname" style="padding:2px"  placeholder="업체명" size="10" /> 
			<input type="text" name="name" style="padding:2px"  placeholder="성함"  size="10"/> <br/> <br/>
			
			<input type="text" name="ph" style="padding:2px"  placeholder="전화번호 ( -포함 )" /> <br/><br/>
			<input type="text" name="email" style="padding:2px"  placeholder="메일주소" /> <br/> <br/>
			
			
			  
   		  
			<textarea name="" rows="5" cols="35" placeholder="내용" ></textarea> <br /> <br />
			
			Http://<input type="text" name="url" style="padding:2px"  placeholder="URL" size="24" />  <br/> 
			</td>
			
			
			</tr>
			<tr>
			
			<td colspan="2" align="center">
			<input type="image" src="/MyUsed/images/okIcon.png" style='cursor:pointer;' width="50" height="50" title="등록하기" />
			</td>
			
			
			</tr>
			
		</table>
	
	 
	 </form>
	 <br/>
	</center> 
	 </div>

	
</body>
</html>