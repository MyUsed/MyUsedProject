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
                   document.formId.action = "mainSubmit.nhn";  // submit 하기 위한 페이지 
                   document.formId.submit();
                   document.formId.image_preview();
                  
              }
              
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





<body>
	<div id="layer_fixed">
	
	<form action="/MyUsed/MyUsedSearchMember.nhn" method="post">
	<table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
		<tr>
			<td style="vertical-align:left; padding-left: 30px; padding-right: 80px;">
			<a href="MyUsed.nhn">
			<img src="/MyUsed/images/Mlogo2.png" width="170"  height="50">
			</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
			<!-- 친구찾기 -->
				<input type="text" size="70" name="member"/>
				<button type="submit"><img src="/MyUsed/images/Search.png" width="20"  height="20"></button>
			
			
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<img src="/MyUsed/images/profile.png" width="15"  height="15">
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${num}">${name}</a> | 
				<a href="/MyUsed/MyUsed.nhn">홈</a> | 
				<a href="/MyUsed/MyUsed.nhn">친구찾기</a>
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainFriend.png" width="45"  height="40"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainMessage.png" width="40"  height="35"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainView.png" width="40"  height="35"></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!-- 추후 이미지로 바꾸기(페이스북처럼 드롭다운메뉴로) -->
				<c:if test="${sessionScope.memId != null }">
					<a href="/MyUsed/MyUsedLogout.nhn">로그아웃</a>
				</c:if>
			</td>
			
		</tr>
	</table>
	</form>
	</div>



<style type="text/css">
#sidebannerR { position:fixed; top:50px; left:43%; margin-left:540px; width:240px; height:800px; background:#EAEAEA; }
#sidebannerL { position:fixed; top:50px; right:50%; margin-right:465px; width:205px; height:800px; background:#E9EAED; }
#contents { width:630px; height:9000px; margin:0 auto; margin-left:180px;background:#EAEAEA; }
#advertise {  position:fixed; width:300px; height:9000px; left:61%; margin-right:300px;background:#EAEAEA; }
</style>
</head>

<body>


<div id="sidebannerR">
	<center>
 	<font size="5">사이드고정R</font>
   	</center>
</div>

<div id="advertise" >
<br /> <br /> <br />
<center>
	<table align="center" width="280" height="550">
	<tr bgcolor="#FFFFFF">
	<td align="center">
		<hr width="90%" />
	<a href="http://www.iei.or.kr/">
	<img src="/MyUsed/images/adver.PNG" width="270" height="370"/>
		<hr width="90%" />
	</a>
	<a href="http://www.iei.or.kr/"><u>국비지원 바로가기</u></a>
	</td>
	</tr>
	</table>
	
	
	
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




<div id="contents">
	<br /><br /><br />
	
	
	 <form name="formId" enctype="multipart/form-data" action="mainSubmit.nhn" method="post" >
	 
	 
	 <table align="center"  width="550" height="30">
	 <tr bgcolor="#FFFFFF">
	 <td align="center" colspan="8">
	 <input type="radio" name="deposit" value="update" onclick='javascript:fncChecked(1);' checked>상태 업데이트
     <input type="radio" name="deposit" value="product" onclick='javascript:fncChecked(2);'>상품 등록
	 </td>
	 </tr>
	 </table>
	
	
	<!--  일반게시글 등록  -->
	 
	
	 <div id='div1'>
	 <table align="center"  width="550" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<font size="2" color="#3B5998" >상태 업데이트</font> 
		  <hr width="80%"  > 
	</td>
	</tr>
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<br/>
	
		<textarea rows = "5" cols = "73" name="content" placeholder="무슨 생각을 하고계신가요 ?"></textarea> <br/> 
		
		
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
   
        <input type="file" name="image${i}" id="image${i}" style='display: none;'>
	
   
    <div id="image${i}_preview" style='display: none;'>
        <img src="/MyUsed/images/option.png" width="70" height="70"/>
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
	 </div>
	
	
	
	 
	 <!--  일반상품 등록  -->
	 
	  <div id='div2' style='display:none;' >
	
	<table align="center"  width="550" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<font size="2" color="#3B5998" >상품 등록</font> 
		  <hr width="80%"  > 
	</td>
	</tr>
	<tr bgcolor="#FFFFFF">
	<td align="center" colspan="8">
	<br/>
		<select name="categ">
                   <option>카테고리</option>
                   <option>의류</option>
                   <option>전자제품</option>
                   <option>가구</option>
                   <option>티켓</option>
                   <option>기타</option>
        </select>
        <br />
		<textarea rows = "5" cols = "73" name="pcontent" placeholder="상품에 대한 설명을 써주세요"></textarea> <br/> 
		<font size ="2" color="#3B5998">
		* 배송료
		포함(선불) <input type="radio" name="sendPay" value="yes" />
		미포함(착불) <input type="radio" name="sendPay" value="no"  />
		</font>
		<br />
		<input type="text" name="price" size="7" placeholder="상품가격"/>
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
   
        <input type="file" name="image${i}" id="image${i}" style='display: none;'>
	
   
    <div id="image${i}_preview" style='display: none;'>
        <img src="/MyUsed/images/option.png" width="70" height="70"/>
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
	
	
	</div>
	
	
	
	 </form>
	 
	 <br /> <br />








<!--  상품 보기 페이지  -->	
	

<c:forEach var="list" items="${list}">
	
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${list.mem_num}">( ${list.name} )</a> 님이 글을 게시하였습니다
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="delete.nhn?num=${list.num}">게시글삭제</a>
		<hr width="100%" > 
		</td>
		</tr>
		
		<tr  bgcolor="#FFFFFF">
		<td align="center">
		${list.content}
		
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"  > 
		좋아요 / 댓글달기 / 공유하기 / 구매하기 
		</td>
		</tr>

	</table>
 	<br />	
 	

<!--  상품 보기 페이지  -->	
	 
</c:forEach>
	 
	 
	 
</div>
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

 	

</body>
</html>

