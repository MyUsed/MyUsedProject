<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/mypage/MyPage.css" />

<script src="/MyUsed/member/jquery-1.11.3.js"></script>
<script src="/MyUsed/member/animate.js"></script>
<body>

<!-- 타임라인 -->



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
				<img src="/MyUsed/images/AddFriend.png" onclick="addFriend('${knewFriend.mem_num}')" style="width:20px; height:20px; margin-top:-4px; cursor:pointer;">
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
			<div id="line"><hr></div>
		</div>
		<div id="knewpeopleindex">
		다른 친구들과 공유한 내용을 보려면 친구요청을 전송하세요!
		</div>
	</div>
	</c:if>
	
	<div id="simpleinfo">
		&nbsp;&nbsp;
		<font style="font-weight:bold;" color="#212121">
		소개</font>
	</div>
	
	
	<div id="picture">
		&nbsp;&nbsp;
		<a onclick="movePictureMenu('${mem_num}')" onmouseover="this.style.textDecoration='none'">
			<font style="font-weight:bold;" color="#212121">
			사진</font>
		</a>
		<table border="0" width="98%" align="center">
			<tr height="112">
				<c:forEach var="picList" items="${picList}" begin="0" end="1">
					<td width="112">
						<img src="/MyUsed/images/profile/${picList.pic}" width="111" height="111">
					</td>
				</c:forEach>
			</tr>
			<tr height="112">
				<c:forEach var="picList" items="${picList}" begin="2" end="3">
					<td width="112">
						<img src="/MyUsed/images/profile/${picList.pic}" width="111" height="111">
					</td>
				</c:forEach>
			</tr>
		</table>
	</div>
	
	<!-- 글쓰기 폼 -->
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



</body>
</html>