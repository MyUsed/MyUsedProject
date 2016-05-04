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
        

                   document.formId.method = "post"     // method 선택, get, post
                   document.formId.action = "mainTest.nhn";  // submit 하기 위한 페이지 

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
				<a href="/MyUsed/MyUsed.nhn">홈</a> | 
				<a href="/MyUsed/MyUsed.nhn">친구찾기</a>
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainFriend.png" width="45"  height="40"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainMessage.png" width="40"  height="35"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainView.png" width="40"  height="35"></a>
			</td>
			
		</tr>
		</table>
	</div>



<style type="text/css">
#sidebannerR { position:fixed; top:50px; left:50%; margin-left:470px; width:200px; height:800px; background:#EAEAEA; }
#sidebannerL { position:fixed; top:50px; right:50%; margin-right:470px; width:200px; height:800px; background:#E9EAED; }
#content { width:980px; height:3000px; margin:0 auto; background:#EAEAEA; }
</style>
</head>

<body>
<div id="sidebannerR">
	<center>
 	<font size="5">사이드고정R</font>
   	</center>
</div>
<div id="sidebannerL">
  
 	
 	<br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/modify.png" width="20" height="20">&nbsp;프로필 수정</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/newSpeed.png" width="20" height="20">&nbsp;뉴스피드</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/categ.png" width="20" height="20">&nbsp;카테고리</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/chat.png" width="20" height="20">&nbsp;메세지</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/friend.png" width="20" height="20">&nbsp;친구보기</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/picture.png" width="20" height="20">&nbsp;사진</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/favorite.png" width="20" height="20">&nbsp;즐겨찾기</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/address.png" width="20" height="20">&nbsp;주소</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/board.png" width="20" height="20">&nbsp;게시판</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/deliver.png" width="20" height="20">&nbsp;배송관리</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/like.png" width="20" height="20">&nbsp;좋아요</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/share.png" width="20" height="20">&nbsp;공유하기</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/friendSearch.png" width="20" height="20">&nbsp;친구찾기</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/deposit.png" width="20" height="20">&nbsp;입금현황</a>
   	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/option.png" width="20" height="20">&nbsp;설정</a>
</div>
<div id="content">
	<br /><br /><br />
	
	
	 <form name="formId" enctype="multipart/form-data" action="mainTest.nhn" method="post" >
	
	<table align="center"  width="800" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<font size="3" color="#3B5998" >상품등록</font> 
		  <hr width="80%"  > 
	</td>
	</tr>
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<br/>
		
		<textarea rows = "5" cols = "90" name="content" placeholder="상품에 대한 설명을 써주세요"></textarea> 
	
		<hr width="80%"  > 
		
	
	</td>
	
	</tr>
	<tr bgcolor="#FFFFFF">
	

	
	
	
		<c:forEach var="i" begin="1" end="8">
    <td align="center"  >
<!-- 이미지 미리보기  -->

<style>
  body {
    margin: 20px;
    font-family: "맑은 고딕";
}
  #image_preview {
    display:none;
}
  </style>
  
  <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>


        <label for="image${i}">Image${i}</label>
   
        <input type="file" name="image${i}" id="image${i}" style='display: none;' >
	
   
    <div id="image${i}_preview" style='display: none;'>
        <img src="/MyUsed/images/option.png" width="50" height="50"/>
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
            $('#image${i}_preview').slideDown(); //업로드한 이미지 미리보기 
            $(this).slideUp(); //파일 양식 감춤
        }
    });

    $('#image${i}_preview a').bind('click', function() {
        resetFormElement($('#image${i}')); //전달한 양식 초기화
        $('#image${i}').slideDown(); //파일 양식 보여줌
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
</c:forEach>
<!-- 이미지 미리보기  -->


</tr>
	<tr bgcolor="#FFFFFF" align="center"	>
		<td colspan="8">
	 	<img src="/MyUsed/images/submit.PNG" onclick="javascript_:send();" />
	 	</td>
	</tr> 	
	
	
	</table>
	
	 </form>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<br /> <br />
	<center>
 	<table align="center" border="1" cellspacing="0" bgcolor="#FFFFFF">



<tr><td width="200" rowspan="5" align="center">
<img src="/jsp/save/0876.jpg" width="200" height="300">   
</td>
</tr>

<tr height="30">
<td colspan="2"  align="center">카테고리</td>
<td colspan="2" align="center"> ${product.itemCateg}</td></tr>

<tr height="30">
<td colspan="2" align="center">판매가격</td>
<td colspan="2" width="300" align="center" >${product.itemPrice}원</td>
</tr>

<tr height="30">
<td colspan="4" align="center"><font color="black"><b>제품설명</b></font></td>
</tr>

<tr height="170">
<td colspan="4" align="center">${product.itemIntro}</td></tr>


<tr><td colspan="5" align="center">구매 개수:
<select name="orderNum">
<option>1</option>
<option>2</option>
<option>3</option>
<option>4</option>
<option>5</option>
<option>6</option>
<option>7</option>
<option>8</option>
<option>9</option>
<option>10</option>
</select>
</td></tr>

<tr align="center">
<td colspan="5" align="center">
<input type="hidden" name ="itemNum" value="${product.itemNum}">
<c:if test="${product.itemStock > 0}">      
<input type="submit" value="주문하기">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<c:if test="${product.itemStock <= 0}">
<input type="button" value="SOLD OUT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<input type="button" value="돌아가기" onClick="javascript:window.location='main.nhn'"></td>
</tr>

</table>
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	<table align="center" border="1" cellspacing="0" paddingspacing="1">



<tr><td width="200" rowspan="5" align="center">
<img src="/jsp/save/1.jpg" width="200" height="300">   
</td>
</tr>

<tr height="30">
<td colspan="2"  align="center">카테고리</td>
<td colspan="2" align="center"> ${product.itemCateg}</td></tr>

<tr height="30">
<td colspan="2" align="center">판매가격</td>
<td colspan="2" width="300" align="center" >${product.itemPrice}원</td>
</tr>

<tr height="30">
<td colspan="4" align="center"><font color="black"><b>제품설명</b></font></td>
</tr>

<tr height="170">
<td colspan="4" align="center">${product.itemIntro}</td></tr>


<tr><td colspan="5" align="center">구매 개수:
<select name="orderNum">
<option>1</option>
<option>2</option>
<option>3</option>
<option>4</option>
<option>5</option>
<option>6</option>
<option>7</option>
<option>8</option>
<option>9</option>
<option>10</option>
</select>
</td></tr>

<tr align="center">
<td colspan="5" align="center">
<input type="hidden" name ="itemNum" value="${product.itemNum}">
<c:if test="${product.itemStock > 0}">      
<input type="submit" value="주문하기">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<c:if test="${product.itemStock <= 0}">
<input type="button" value="SOLD OUT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<input type="button" value="돌아가기" onClick="javascript:window.location='main.nhn'"></td>
</tr>

</table>
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	<table align="center" border="1" cellspacing="0" paddingspacing="1">



<tr><td width="200" rowspan="5" align="center">
<img src="/jsp/save/11.jpg" width="200" height="300">   
</td>
</tr>

<tr height="30">
<td colspan="2"  align="center">카테고리</td>
<td colspan="2" align="center"> ${product.itemCateg}</td></tr>

<tr height="30">
<td colspan="2" align="center">판매가격</td>
<td colspan="2" width="300" align="center" >${product.itemPrice}원</td>
</tr>

<tr height="30">
<td colspan="4" align="center"><font color="black"><b>제품설명</b></font></td>
</tr>

<tr height="170">
<td colspan="4" align="center">${product.itemIntro}</td></tr>


<tr><td colspan="5" align="center">구매 개수:
<select name="orderNum">
<option>1</option>
<option>2</option>
<option>3</option>
<option>4</option>
<option>5</option>
<option>6</option>
<option>7</option>
<option>8</option>
<option>9</option>
<option>10</option>
</select>
</td></tr>

<tr align="center">
<td colspan="5" align="center">
<input type="hidden" name ="itemNum" value="${product.itemNum}">
<c:if test="${product.itemStock > 0}">      
<input type="submit" value="주문하기">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<c:if test="${product.itemStock <= 0}">
<input type="button" value="SOLD OUT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<input type="button" value="돌아가기" onClick="javascript:window.location='main.nhn'"></td>
</tr>

</table>
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	
 	
 	
</div>


	
	
	<br /><br /><br />
	
	


</body>
</html>


