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

<!-- 사진 -->

<div id="picView">
	<img src="/MyUsed/images/profile/" width="100%" height="100%" onclick="closePic()">
</div>


<div id="picture_back">
	<div id="picture_title">
		사진
		<br />
		<font style="font-size:75%; text-shadow:none;" color="#5D5D5D">
			<a onclick="" style="cursor:pointer;" onmouseover="this.style.textDecoration='none'">
				${memDTO.name}님의 사진
			</a> &nbsp;&nbsp;&nbsp;&nbsp;
			<a onclick="" style="cursor:pointer;" onmouseover="this.style.textDecoration='none'">
				
			</a>
		</font>
	</div>
	
	<div id="picture_image">
	<table border="0" style="width:98%;" align="center">
		<tr height="156">
			<c:forEach var="picList" items="${picList}" begin="0" end="4">
			<td width="157" align="center">
				<img src="/MyUsed/images/profile/${picList.pic}" onclick="openPic('${picList.pic}')" width="155" height="155">
			</td>
			</c:forEach>
		</tr>
		
		<tr height="156">
			<c:forEach var="picList" items="${picList}" begin="5" end="9">
			<td width="157" align="center">
				<img src="/MyUsed/images/profile/${picList.pic}" onclick="openPic('${picList.pic}')" width="155" height="155">
			</td>
			</c:forEach>
		</tr>
		
		<tr height="156">
			<c:forEach var="picList" items="${picList}" begin="10" end="14">
			<td width="157" align="center">
				<img src="/MyUsed/images/profile/${picList.pic}" onclick="openPic('${picList.pic}')" width="155" height="155">
			</td>
			</c:forEach>
		</tr>
		
		<tr height="156">
			<c:forEach var="picList" items="${picList}" begin="15" end="19">
			<td width="157" align="center">
				<img src="/MyUsed/images/profile/${picList.pic}" onclick="openPic('${picList.pic}')" width="155" height="155">
			</td>
			</c:forEach>
		</tr>
		
		
		<tr height="156">
			<c:forEach var="picList" items="${picList}" begin="20" end="24">
			<td width="157" align="center">
				<img src="/MyUsed/images/profile/${picList.pic}" onclick="openPic('${picList.pic}')" width="155" height="155">
			</td>
			</c:forEach>
		</tr>
	
	</table>
	</div>
	
	
	

</div>






</body>
</html>