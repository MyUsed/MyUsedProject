<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/member/MyPage.css" />
<!-- <link rel="stylesheet" type="text/css" href="/member/style.css"> -->

<script src="/MyUsed/member/jquery-1.11.3.js"></script>
<script src="/MyUsed/member/animate.js"></script>
<head>
<title>${name}</title>

 		<script type="text/javascript">
        
              function send(){             

                   document.formId.method = "post"     // method 선택, get, post
                   document.formId.action = "/MyUsed/main/test.jsp";  // submit 하기 위한 페이지 

                   document.formId.submit();
                  
              }
             
              /* 프로필 이미지 */
              function openImageUpload() {
      	        	imageUploadback.style.display = '';
      	        	imageUpload.style.display = '';
      	    	}

              function closeImageUpload() {
      	        	imageUploadback.style.display = 'none';
      	        	imageUpload.style.display = 'none';      	        	
      	    	}

              function openImageHistory() {
            	  	imagehistoryback.style.display = '';
      	        	imagehistory.style.display = '';      	        	
      	    	}

              function closeImageHistory() {
            	  	imagehistoryback.style.display = 'none';
    	        	imagehistory.style.display = 'none';     	        	
      	        	
      	    	}
              
              /* 커버 이미지 */
              
              function openCoverImageUpload() {
            	  	CoverUploadback.style.display = '';
            	  	CoverUpload.style.display = '';
      	    	}

              function closeCoverImageUpload() {
            	  	CoverUploadback.style.display = 'none';
            	  	CoverUpload.style.display = 'none';      	        	
      	    	}

              function openCoverImageHistory() {
            	  	Coverhistoryback.style.display = '';
            	  	Coverhistory.style.display = '';      	        	
      	    	}

              function closeCoverImageHistory() {
            	  	Coverhistoryback.style.display = 'none';
            	  	Coverhistory.style.display = 'none';     	        	
      	        	
      	    	}
              
 			/* 메시지 보기 */
              function openMsg() {
            	  	msgPop.style.display = '';
            	  	arrow.style.display = '';
      	    	}

              function closeMsg() {
            	  	msgPop.style.display = 'none';  
            	  	arrow.style.display = 'none';    	        	
      	    	}


         </script>




	<meta charset="utf-8"/>
	<title>MyUsed</title>
	<style type="text/css">
		#layer_fixed
		{
			height:50px;
			width:120%;
			color: #242424;
			font-size:12px;
			position:fixed;
			z-index:900;
			top:0px;
			left:0px;
			-webkit-box-shadow: 0 1px 2px 0 #777;
			box-shadow: 0 1px 2px 0 #777;
			background-color:#3B5998;
		}
		
		input[type=text] {
 		padding: 3px;
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
			<a href="/MyUsed/MyUsed.nhn">
			<img src="/MyUsed/images/Mlogo2.png" width="170"  height="50">
			</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
			<!-- 친구찾기 -->
				<input type="text" size="70" name="member"/>
				<button type="submit"><img src="/MyUsed/images/Search.png" width="20"  height="20"></button>
			
			
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<img src="/MyUsed/images/profile/${proDTO.profile_pic}" width="15"  height="15">
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${mynum}">${sessionName}</a> | 
				<a href="/MyUsed/MyUsed.nhn">홈</a> | 
				<a href="/MyUsed/MyUsed.nhn">친구찾기</a>
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainFriend.png" width="45"  height="40"></a>
				
				<!-- 개인 알림  -->
				<label for="msg">
					<img src="/MyUsed/images/mainMessage.png" width="40"  height="35">
				</label>
				<input type="button" id="msg" OnClick="javascript:openMsg()" style='display: none;'>
				
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainView.png" width="40"  height="35"></a>
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<!-- 추후 이미지로 바꾸기(페이스북처럼 드롭다운메뉴로) -->
				<c:if test="${sessionScope.memId != null }">
					<a href="/MyUsed/MyUsedLogout.nhn">로그아웃</a>
				</c:if>
			</td>
			
		</tr>
		</table>
	</div>




<body>
<div id="sidebannerR">
 	
 	<!-- 친구 목록(state 2) -->
 	<div id="friendlist_side"></div>
 
 	<br />
 	<div id="friendlist_img_line">
 	<c:forEach var="friprofileList" items="${friprofileList}">
 	<div id="friendlist_img">
		<img src="/MyUsed/images/profile/${friprofileList.profile_pic}" width="49" height="49">
 	</div>
 	</c:forEach>
 	</div>
 	
 	<div id="friendlist_line">
 	<c:forEach var="friendState2" items="${friendState2}">
 	<div id="friendlist">
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${friendState2.mem_num}">
 			<font color="#000000">${friendState2.name}</font>
 		</a>  
 		<c:if test="${friendState2.onoff == 0}">
 			<%--로그아웃 상태 --%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<font color="#FF0000">OFF</font>
 		</c:if>
 		<c:if test="${friendState2.onoff == 1}">
 			<%--로그인 상태 --%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<font color="#2F9D27">ON</font>
 		</c:if>
 		<br />
 	</div>
 	</c:forEach>
 	</div>
 	
</div>

<div id="sidebannerL">
</div>

<div id="content">
	<div id="coverImage">
		<img src="/MyUsed/images/cover/${coverDTO.cover_pic}" width="798" height="220"/>
	
		<div id="covertext">
			<font color="#FFFFFF">
			<c:if test="${mynum == mem_num}">
        		<label for="cimage">커버 사진 업로드</label> | 
        	</c:if>
        	<label for="chistory">히스토리</label>
   			</font>
        	<input type="button" id="cimage" OnClick="javascript:openCoverImageUpload()" style='display: none;'>
        	<input type="button" id="chistory" OnClick="javascript:openCoverImageHistory()" style='display: none;'>
        	
		</div>
	
	</div>
	<div id="menu">	
	
	<div id="menu0"><!-- 공란 -->	</div>
	<div id="menu1"><a href="/MyUsed/MyUsedMyPage.nhn">타임라인</a></div>
	<div id="menu2"><a href="/MyUsed/MyUsedMyPage.nhn">정보</a></div>	
	<div id="menu3"><a href="/MyUsed/MyUsedMyPage.nhn">친구</a></div>	
	<div id="menu4"><a href="/MyUsed/MyUsedMyPage.nhn">사진</a></div>	
	<div id="menu5"><a href="paperMain.nhn?mynum=${mem_num}">쪽지</a></div>


	<div id="menu6">
    <nav class="nav">
	<ul class="gnb">
	<li ><a href="#">더 보기▼</a>
		<ul class="sub">
	      	<li><a href="/MyUsed/MyUsed.nhn">aaaaaa</a></li>
            <li><a href="/MyUsed/MyUsed.nhn">bbbbbb</a></li>
            <li><a href="/MyUsed/MyUsed.nhn">cccccc</a></li>
            <li><a href="/MyUsed/MyUsed.nhn">dddddd</a></li>
        </ul>
    </li>
    </ul>
    </nav> 

	</div>
	
	
	</div>

	<!-- 프로필 이미지 업로드 -->
	<div id="profileImageback" >
		<center>
		<div id="profileImage" >
		<img src="/MyUsed/images/profile/${proDTO.profile_pic}" width="160" height="160"/>
	
			<div id="profiletext">
				<font color="#FFFFFF">
				<c:if test="${mynum == mem_num}">
        			<label for="image">프로필 업로드</label> | 
        		</c:if>
        		<label for="history">히스토리</label>
   				</font>
        		<input type="button" id="image" OnClick="javascript:openImageUpload()" style='display: none;'>
        		<input type="button" id="history" OnClick="javascript:openImageHistory()" style='display: none;'>
			</div>
		</div>	
		</center>
	</div>
	
	<div id="name">
		<font color="#FFFFFF">${name}</font>
	</div>
	
	<!-- 세션아이디의 num과(mynum) 해당페이지의 mem_num과 같은 사람일때만 보임 -->
	<c:if test="${mem_num == mynum}">
	<div id="knewpeople">
		<div id="knewpeopletitle">
			알 수 도 있는 친구
			<div id="line">
				<hr>
			</div>
		</div>
		
		<div id="knewpeopleindex">
		<table>
			<tr height="115" align="center">
				<c:forEach var="knewFriendList_image" items="${knewFriendList_image}" begin="0" end="5" >
				<td width="130">
					<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${knewFriendList_image.mem_num}">
					<img src="/MyUsed/images/profile/${knewFriendList_image.profile_pic}" width="110" height="110">
					</a>
				</td>
				</c:forEach>
			</tr>
			<tr height="22" align="center">
			<c:forEach var="knewFriend" items="${knewFriendList}" begin="0" end="5" >
				<td width="130">
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${knewFriend.mem_num}">
					${knewFriend.name}
				</a>
				</td>
			</c:forEach>
			</tr>
		</table>
		</div>
	</div>
	</c:if>
	
<c:if test="${mem_num != mynum}">
	<div id="knewpeople">
		<div id="knewpeopletitle">
			${name}님을 아세요?
			<div id="line">
				<hr>
			</div>
		</div>
		
		<div id="knewpeopleindex">
		다른 친구들과 공유한 내용을 보려면 친구요청을 전송하세요!
		</div>
	</div>
	</c:if>
	
	<div id="simpleinfo">
	소개
	
	</div>
	<div id="picture">
	사진
	
	</div>
	
	<div id="writeform">
		<div id="writeformtitle">
			기능
		</div>
		<div id="propic">
			프로필사진
		</div>
		<div id="writearea">
			<textarea rows="7" cols="60"></textarea>
		</div>
		<div id="bottom">
			하부버튼
		</div>
	</div>
	
	
	<%-- for문 걸어서 반복 --%>
	<div id="article">
	게시물
	
	</div>
	
</div>


<!-- 프로필 이미지 -->

<div id="imageUploadback" style='display: none;'>
</div>
<div id="imageUpload" style='display: none;'>
	<div id="closebotton">
		<label for="close">
			<img src="/MyUsed/images/close.png" width="30" height="30">
		</label>
    </div>
    
   	<input type="button" id="close" OnClick="javascript:closeImageUpload()" style='display: none;'>
   	<br />
   	<center>
   	
   	<font size="4"><b>프로필 이미지 업로드</b></font>
   	
   	<hr width="80%">
   	<form action="/MyUsed/MyUsedUploadPro.nhn" enctype="multipart/form-data" method="post" >
		
		<input type="file" value="이미지 찾기" name="profilepic" class="btn btn-success"> <br />
		<input type="hidden" name="mem_num" value="${mem_num}">
		
		<script type="text/javascript">
 
    
    $('#profilepic').on('change', function() {
        
        ext = $(this).val().split('.').pop().toLowerCase(); //확장자
        
        //배열에 추출한 확장자가 존재하는지 체크
        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($(this)); //폼 초기화
            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
        } else {
            file = $('profilepic').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            $('#imageview img').attr('src', blobURL);
            $('#imageview').slideDown(); //업로드한 이미지 미리보기 
            $(this).slideUp(); //파일 양식 감춤
        }
    });
    $('#imageview a').bind('click', function() {
        resetFormElement($('#profilepic')); //전달한 양식 초기화
        $('#profilepic').slideDown(); //파일 양식 보여줌
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
		
		<div id="imageview">
		
		</div>
		
		<br />
        <input type="submit" value="프로필 업로드" class="btn btn-success" >
	</form> 
	</center>  	
</div>
	
	
<div id="imagehistoryback" style='display: none;'>
</div>
<div id="imagehistory" style='display: none;'>
<div id="closebotton">
		<label for="close1">
			<img src="/MyUsed/images/close.png" width="30" height="30">
		</label>
    </div>
    
   	<input type="button" id="close1" OnClick="javascript:closeImageHistory()" style='display: none;'>
   	<br />
   	<center>
   	
   	<font size="4"><b>프로필 이미지 히스토리</b></font>
   	
   	<hr width="80%">
   	
   	<!-- 이미지 정렬 -->
   	
   	
   	</center>
</div>
	


<!-- 커버 이미지 -->


<div id="CoverUploadback" style='display: none;'>
</div>
<div id="CoverUpload" style='display: none;'>
	<div id="closebotton">
		<label for="close2">
			<img src="/MyUsed/images/close.png" width="30" height="30">
		</label>
    </div>
    
   	<input type="button" id="close2" OnClick="javascript:closeCoverImageUpload()" style='display: none;'>
   	<br />
   	<center>
   	
   	<font size="4"><b>커버 이미지 업로드</b></font>
   	
   	<hr width="80%">
   	<form action="/MyUsed/MyUsedCoverUploadPro.nhn" enctype="multipart/form-data" method="post" >
		
		<input type="file" value="이미지 찾기" name="coverpic" class="btn btn-success"> <br />
		<input type="hidden" name="mem_num" value="${mem_num}">
		
	
		
		<div id="imageview">
		
		</div>
		
		<br />
        <input type="submit" value="커버 이미지 업로드" class="btn btn-success" >
	</form> 
	</center>  	
</div>


<div id="Coverhistoryback" style='display: none;'>
</div>

<div id="Coverhistory" style='display: none;'>
<div id="closebotton">
		<label for="close3">
			<img src="/MyUsed/images/close.png" width="30" height="30">
		</label>
    </div>
    
   	<input type="button" id="close3" OnClick="javascript:closeCoverImageHistory()" style='display: none;'>
   	<br />
   	<center>
   	
   	<font size="4"><b>커버 이미지 히스토리</b></font>
   	
   	<hr width="80%">
   	
   	<!-- 이미지 정렬 -->
   	
   	
   	</center>
</div>


<!-- 메시지 -->
<div id="arrow" style='display:none;'>
	<img src="/MyUsed/images/arrow.png" width="25" height="20"> 
</div>
<div id="msgPop" style='display:none;'>
    
	<div id="closemsg">
		<label for="close4">
			<img src="/MyUsed/images/close.png" width="15" height="15">
		</label>
    </div>
    
   	<input type="button" id="close4" OnClick="javascript:closeMsg()" style='display: none;'>
   	<br />
   	<div id="msgtext">
   		<font size="3"><b>메시지 확인</b></font>
   	</div>
   	<br />
 	<b>친구 신청 대기(state 0)</b>
 	<br />
 	<c:forEach var="friendState0" items="${friendState0}">
 		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${friendState0.mem_num}">
 			${friendState0.name} 
 		</a><br />
 	</c:forEach>
 	
 	<br />
 	
 	<b>거절된 친구 신청(state -1)</b><br />
 	<c:forEach var="friendState_m1" items="${friendState_m1}">
 		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${friendState_m1.mem_num}">
 			${friendState_m1.name} 
 		</a><br />
 		<input type="button" value="확인" onClick="javascript:window.location='MyUsedRejectionFriend.nhn?agree=${0}&mem_num=${friendState_m1.mem_num}&num=${num}'">
 		<br />
 	</c:forEach>
 	
 	<br />
 	<b>나에게 들어온 친구신청(state 1)</b><br />
 	<c:forEach var="friendState1" items="${friendState1}">
 		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${friendState1.mem_num}">
 			${friendState1.name}
 		</a><br />
 		<input type="button" value="수락" onClick="javascript:window.location='MyUsedAgreeFriend.nhn?agree=${0}&mem_num=${friendState1.mem_num}&num=${num}'">
 		<input type="button" value="거절" onClick="javascript:window.location='MyUsedAgreeFriend.nhn?agree=${1}&mem_num=${friendState1.mem_num}&num=${num}'">
 		<br />
 	</c:forEach>
 	
 	<br />
   	
</div>



</body>
</html>


