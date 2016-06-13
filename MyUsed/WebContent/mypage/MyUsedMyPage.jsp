<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/mypage/MyPage.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/mypage/MyPage_imageUpload.css" />

<script src="/MyUsed/member/jquery-1.11.3.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="/MyUsed/member/animate.js"></script>
<script src="/MyUsed/mypage/MyPageScript.js"></script>
<head>
<title>${name}</title>
</head>

<body>
	<div id="modal" style="position:fixed; background:red; width:100%; height:100%; display:none; z-index:900;"></div>

	<div id="layer_fixed"><jsp:include page="/mypage/layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->
	<div id="sidebannerL"></div><!-- 왼쪽 여백 -->
	<div id="sidebannerR"><jsp:include page="/mypage/friendList.jsp"/></div><!-- 오른족 친구 목록 -->
	<div id="advertise" ></div><!-- 광고 -->

	<div id="content">
		<!-- 마이페이지 상단(커버, 프로필, 메뉴) -->
		<div id="mypageTop"><jsp:include page="/mypage/MyPageTop.jsp"/></div>

		<!-- 마이페이지 하단 -->
		<div id="mypageBottom">
			<!--  타임라인이 기본  -->
			<jsp:include page="/mypage/MyPageBottom_timeline.jsp"/>
		</div>
	
	</div>
	

<!------------------------------------------------------------------------------------------->
<!------------------------------ 프로필 , 커버 이미지 등록창/친구 관련 메시지-------------------------------->
<!------------------------------------------------------------------------------------------->
<!-- 프로필 이미지 -->
<div id="imageUploadback" style='display: none;'>
</div>
<div id="imageUpload" style='display: none;'>
	<div id="closebotton">
		<label for="close" style="cursor:pointer;">
			<img src="/MyUsed/images/close.png" width="30" height="30">
		</label>
    </div>
    
   	<input type="button" id="close" OnClick="javascript:closeImageUpload()" style='display: none;'>
   	<br />
   	<center>
   	
   	<font size="4"><b>프로필 이미지 업로드</b></font>
   	
   	<hr width="80%">
   	<form action="/MyUsed/MyUsedUploadPro.nhn" enctype="multipart/form-data" method="post" >
		
		<input type="file" value="이미지 찾기" id="profilepic" name="profilepic" class="btn btn-success"> <br />
		<input type="hidden" name="mem_num" value="${mem_num}">
		
		
		<div id="imageview">
			<div id="view" style="display:none;">
				<img src="/MyUsed/images/option.png" width="250" height="250" /><br />
				<a href="#">Remove</a>
			</div>
		</div>

		<br />
        <input type="submit" value="프로필 업로드" class="btn btn-success" >
	</form> 
	</center>  	
</div>
	
<!-- 프로필 히스토리 -->

	
<div id="imagehistoryback" style='display: none;'>
</div>
<div id="imagehistory" style='display: none;'>
	<div id="closebotton_h">
		<label for="close1" style="cursor:pointer;">
			<img src="/MyUsed/images/close.png" width="30" height="30">
		</label>
    </div>
    
   	<input type="button" id="close1" OnClick="javascript:closeImageHistory()" style='display: none;'>
   	<br />
   	<center>
   	
   	<font size="4"><b>프로필 이미지 히스토리</b></font>
   	<script type="text/javascript">
    	function openConfirmDelete(deletepro) {
        	url = "/MyUsed/MyUsedDeleteAll.nhn?mem_num=" + deletepro.mem_num.value;
        
        	// 새로운 윈도우를 엽니다.
        	open(url, "confirm", 
        	"toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
    	}
   	</script>
   	<c:if test="${mem_num == mynum}">
   		<div id="deletepro">
   			<form name="deletepro">
   				<input type="hidden" name="mem_num" value="${mem_num}">
   				<label for="deleteALl">모두 삭제</label>
   				<input type="button" id="deleteALl" OnClick="javascript:openConfirmDelete(this.form)" style='display: none;'>
   			</form>   			
   		</div>
   	</c:if>
   	
   	<hr width="95%">
   	
   	<!-- 이미지 정렬  // 클릭하면 큰 이미지 나오는거 마저하기-->
   	<table border="1" bordercolor="#FFFFFF" cellpadding="1" style="margin-left:450px; z-index:400">
   		<tr height="115">
   		<c:forEach begin="0" step="1" end="3" var="prohis" items="${prohisList}">
   			<td width="115">
   				<img src="/MyUsed/images/profile/${prohis.profile_pic}" onclick="javascript:openviewProfile('${prohis.profile_pic}')" style="cursor:pointer;" width="115" height="115">
			</td>
		</c:forEach>
		</tr>
		
   		<tr height="115">
   		<c:forEach begin="4" step="1" end="7" var="prohis" items="${prohisList}">
   			<td width="115">
   			<img src="/MyUsed/images/profile/${prohis.profile_pic}" onclick="javascript:openviewProfile('${prohis.profile_pic}')" style="cursor:pointer;" width="115" height="115">
			</td>
		</c:forEach>
		</tr>
		
   		<tr height="115">
   		<c:forEach begin="7" step="1" end="10" var="prohis" items="${prohisList}">
   			<td width="115">
   				<img src="/MyUsed/images/profile/${prohis.profile_pic}" onclick="javascript:openviewProfile('${prohis.profile_pic}')" style="cursor:pointer;" width="115" height="115">
			</td>
		</c:forEach>
		</tr>
   	
   	</table>
   	</center>
   	
   	
   	
</div>



<!-- 커버 이미지 -->


<div id="CoverUploadback" style='display: none;'>
</div>
<div id="CoverUpload" style='display: none;'>
	<div id="closebotton">
		<label for="close2" style="cursor:pointer;">
			<img src="/MyUsed/images/close.png" width="30" height="30">
		</label>
    </div>
    
   	<input type="button" id="close2" OnClick="javascript:closeCoverImageUpload()" style='display: none;'>
   	<br />
   	<center>
   	
   	<font size="4"><b>커버 이미지 업로드</b></font>
   	
   	<hr width="80%">
   	<form action="/MyUsed/MyUsedCoverUploadPro.nhn" enctype="multipart/form-data" method="post" >
		
		<input type="file" value="이미지 찾기" id="coverpic" name="coverpic" class="btn btn-success"> <br />
		<input type="hidden" name="mem_num" value="${mem_num}">
		
	
		
		<div id="imageview">
			<div id="cview" style="display:none;">
				<img src="/MyUsed/images/option.png" width="250" height="250" /><br />
				<a href="#" style="display:">Remove</a>
			</div>
		</div>
		
		<br />
        <input type="submit" value="커버 이미지 업로드" class="btn btn-success" >
	</form> 
	</center>  	
</div>


<div id="Coverhistoryback" style='display: none;'>
</div>

<div id="Coverhistory" style='display: none;'>
<div id="closebotton_h">
		<label for="close3" style="cursor:pointer;">
			<img src="/MyUsed/images/close.png" width="30" height="30">
		</label>
    </div>
    
   	<input type="button" id="close3" OnClick="javascript:closeCoverImageHistory()" style='display: none;'>
   	<br />
   	<center>
   	
   	<font size="4"><b>커버 이미지 히스토리</b></font>
   	<script type="text/javascript">
    	function openConfirmDelete(deletepro) {
        	// 아이디를 입력했는지 검사
        	url = "/MyUsed/MyUsedDeleteCoverAll.nhn?mem_num=" + deletepro.mem_num.value;
        
        	// 새로운 윈도우를 엽니다.
        	open(url, "confirm", 
        	"toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
    	}
   	</script>
   	<c:if test="${mem_num == mynum}">
   		<div id="deletepro">
   			<form name="deletepro">
   				<input type="hidden" name="mem_num" value="${mem_num}">
   				<label for="deleteALl">모두 삭제</label>
   				<input type="button" id="deleteALl" OnClick="javascript:openConfirmDelete(this.form)" style='display: none;'>
   			</form>   			
   		</div>
   	</c:if>
   	
   	<hr width="95%">
   	
   	<!-- 이미지 정렬 -->
   	<table border="1" bordercolor="#FFFFFF" cellpadding="1" style="margin-left:450px; z-index:400">
   		<tr height="115">
   		<c:forEach begin="0" step="1" end="3" var="coverhis" items="${coverhisList}">
   			<td width="115">
   				<img src="/MyUsed/images/profile/${coverhis.cover_pic}" onclick="javascript:openviewProfile('${coverhis.cover_pic}')" style="cursor:pointer;" width="115" height="115">
			</td>
		</c:forEach>
		</tr>
		
   		<tr height="115">
   		<c:forEach begin="4" step="1" end="7" var="coverhis" items="${coverhisList}">
   			<td width="115">
   				<img src="/MyUsed/images/profile/${coverhis.cover_pic}" onclick="javascript:openviewProfile('${coverhis.cover_pic}')" style="cursor:pointer;" width="115" height="115">
			</td>
		</c:forEach>
		</tr>
		
   		<tr height="115">
   		<c:forEach begin="7" step="1" end="10" var="coverhis" items="${coverhisList}">
   			<td width="115">
   				<img src="/MyUsed/images/profile/${coverhis.cover_pic}" onclick="javascript:openviewProfile('${coverhis.cover_pic}')" style="cursor:pointer;" width="115" height="115">
			</td>
		</c:forEach>
		</tr>
   	
   	</table>
   	
   	</center>
</div>


<!-- 프로필, 커버 이미지 히스토리 볼때 -->
<div id="viewImage" style="display:none;"></div>



<!-- 메시지 -->
<div id="arrow" style='display:none;'>
	<img src="/MyUsed/images/arrow.png" width="25" height="20"> 
</div>
<div id="msgPop" style='display:none;'>
    
	<div id="closemsg">
		<label for="close4" style="cursor:pointer;">
			<img src="/MyUsed/images/close.png" width="15" height="15">
		</label>
    </div>
    
   	<input type="button" id="close4" OnClick="javascript:closeMsg()" style='display: none;'>
   	<br />
   	<div id="msgtitle">
   		<font size="3"><b>친구</b></font>
   	</div>
   	
   	<div id="msgtext">
 
 	<table width="90%" height="100%">
   		<tr>
   			<td><b>친구 신청 대기<font color="#4374D9">(${friendState0.size()}건)</font></b></td>
   		</tr>
   		<tr height="25%">
   			<td valign="top" style="padding-left:5px;">
 				<c:forEach var="friendState0" items="${friendState0}">
 					<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${friendState0.mem_num}">
 					${friendState0.name} 
 					</a><br />
 				</c:forEach>
			</td>
   		</tr>
   		<tr>
   			<td><b>거절된 친구 신청<font color="#4374D9">(${friendState_m1.size()}건)</font></b></td>
   		</tr>
   		<tr height="25%">
   			<td valign="top" style="padding-left:5px;">
 				<c:forEach var="friendState_m1" items="${friendState_m1}">
 					<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${friendState_m1.mem_num}">
 						${friendState_m1.name} 
 					</a>
 					<input type="button" value="확인" onClick="javascript:window.location='MyUsedRejectionFriend.nhn?agree=${0}&mem_num=${friendState_m1.mem_num}&num=${num}'">
 					<br />
 				</c:forEach>
			</td>
   		</tr>
   		<tr>
   			<td><b>나에게 들어온 친구신청<font color="#4374D9">(${friendState1.size()}건)</font></b></td>
   		</tr>
   		<tr height="25%">
   			<td valign="top" style="padding-left:5px;">
 			<c:forEach var="friendState1" items="${friendState1}">
 				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${friendState1.mem_num}">
 					${friendState1.name}
 				</a>
 				<input type="button" value="수락" onClick="javascript:window.location='MyUsedAgreeFriend.nhn?agree=${0}&mem_num=${friendState1.mem_num}&num=${num}'">
 				<input type="button" value="거절" onClick="javascript:window.location='MyUsedAgreeFriend.nhn?agree=${1}&mem_num=${friendState1.mem_num}&num=${num}'">
 				<br />
 			</c:forEach>
			</td>
   		</tr>
   	
   	</table>
 
 
 	</div>
   	
   	
   	
   	
   	
   	
   	
</div>



</body>
</html>


