<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	 	
<table align="center"  width="550" height="20">
<tr bgcolor="#FFFFFF">
	<td align="left" style="padding-left:10px">
	<select name="categ0" id="categ0">
		<option>--------1차--------</option>
		<c:forEach var="categ" items="${categList}">
			<option>${categ.categ}</option>
		</c:forEach>
	</select>
	<input id="button" type="image" src="/MyUsed/images/agree.PNG" width="15" height="" value="확인" onClick="callAjax()">
	<br />
	</td>
</tr>
</table>
	 
	 
	 
	 
	 
	 
	 <!--  --------------------------------------------- 상품 ---------------------------------------------------- -->
	 
	 <%-- 
<div id='div2'  style='display:${view2};'  > --%>
	
	<table align="center"  width="550" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<br/>
	
		<textarea rows = "5" cols = "73" name="contents" placeholder="상품에 대한 설명을 써주세요" onkeyup="alarm('카테고리를 선택하고 작성하세요!')"></textarea> <br/> 
		<font size ="2" color="#3B5998">
		* 배송료
		포함(선불) <input type="radio" name="sendPay" value="yes" />
		미포함(착불) <input type="radio" name="sendPay" value="no"  />
		</font>
		<br />
		<input type="text" name="price" size="7" value="0000" placeholder="상품가격"/>
		<hr width="80%"  > 	
	
	</td>
	
	</tr>
	<tr bgcolor="#FFFFFF">

	
		<c:forEach var="i" begin="1" end="8">
    <td align="center"  >
<!-- 이미지 미리보기  -->

  
 
<c:if test="${i==1}">
<img src="/MyUsed/images/mainPic.PNG" width="15" height="15" title="메인사진"/>
</c:if>

        <label for="pimage${i}">
		<img src="/MyUsed/images/box.PNG" width="25" height="25" style='cursor:pointer;' title="상품사진"/>
		</label>
   
        <input type="file" name="pimage${i}" id="pimage${i}" style='display: none;'>
	
   
    <div id="pimage${i}_preview" style='display: none;'>
        <img src="/MyUsed/images/option.png" width="70" height="70"/>
        <a href="#">Remove</a>
    </div>


    <script type="text/javascript">
 
    
    $('#pimage${i}').on('change', function() {
        
        ext = $(this).val().split('.').pop().toLowerCase(); //확장자
        
        //배열에 추출한 확장자가 존재하는지 체크
        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($(this)); //폼 초기화
            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
        } else {
            file = $('#pimage${i}').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            $('#pimage${i}_preview img').attr('src', blobURL);
	        $('#writeform').attr('style', 'height:356px;');
	        $('#prolist').attr('style', 'margin-top:915px;');
            $('#pimage${i}_preview').slideDown(); //업로드한 이미지 미리보기 
            $(this).slideUp(); //파일 양식 감춤
        }
    });
    $('#pimage${i}_preview a').bind('click', function() {
        resetFormElement($('#pimage${i}')); //전달한 양식 초기화
        //$('#pimage${i}').slideDown(); //파일 양식 보여줌
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
    
<script type="text/javascript">
/* 찜하기 ajax */
    function choiceAjax(coun){
        $.ajax({
	        type: "post",
	        url : "choiceInsert.nhn",
	        data: {	// url 페이지도 전달할 파라미터
	        	num : $('#num'+coun).val(),
       			mem_num : $('#mem_num'+coun).val(),
       			mem_name : $('#mem_name'+coun).val(),
       			price : $('#price'+coun).val(),
       			pro_pic : $('#pro_pic'+coun).val(),
       			content : $('#content'+coun).val(),
	        },
	        success: choice,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
     	});
    }
    function choice(choice){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
    	if(confirm("이 게시물을 찜하시겠습니까?") == true){
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
<!-- 이미지 미리보기  -->


</tr>
	<tr bgcolor="#FFFFFF" align="center"	>
		<td colspan="8">
	 	<img src="/MyUsed/images/submit.PNG" style='cursor:pointer;' title="등록하기" onclick="javascript_:send();" />
	 	</td>
	</tr> 	
	</table>

	 
	 <br /> <br />


	 
	 
	 
	 
	 
	 
