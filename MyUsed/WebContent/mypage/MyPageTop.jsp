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


	<div id="coverImage">
		<img src="/MyUsed/images/cover/${coverDTO.cover_pic}" width="798" height="220"/>
	
		<div id="covertext">
			<font color="#FFFFFF">
			<c:if test="${mynum == mem_num}">
        		<label for="cimage" style="cursor:pointer;">커버 사진 업로드</label> | 
        	</c:if>
        	<label for="chistory" style="cursor:pointer;">히스토리</label>
   			</font>
        	<input type="button" id="cimage" OnClick="javascript:openCoverImageUpload()" style='display: none;'>
        	<input type="button" id="chistory" OnClick="javascript:openCoverImageHistory()" style='display: none;'>
        	
		</div>
	
	</div>
	
	<!-- 프로필 이미지 업로드 버튼 -->
	<div id="profileImageback" >
		<center>
		<div id="profileImage" >
		<img src="/MyUsed/images/profile/${proDTO.profile_pic}" width="160" height="160"/>
	
			<div id="profiletext">
				<font color="#FFFFFF">
				<c:if test="${mynum == mem_num}">
        			<label for="image" style="cursor:pointer;">프로필 업로드</label> | 
        		</c:if>
        		<label for="history" style="cursor:pointer;">히스토리</label>
   				</font>
        		<input type="button" id="image" OnClick="javascript:openImageUpload()" style='display: none;'>
        		<input type="button" id="history" OnClick="javascript:openImageHistory()" style='display: none;'>
			</div>
		</div>	
		</center>
	</div>
	
	<div id="name">
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${mem_num}" onmouseover="this.style.textDecoration='none'">
		<font color="#FFFFFF">${name}</font></a>
	</div>
	
	
	
	<div id="menu">	
	
		<div id="menu0"><!-- 공란 -->	</div>
		<div id="menu1" onclick="menuMove('/MyUsed/MyUsedMyPage.nhn?mem_num=${mynum}')" onmouseover="mouseOver1()" onmouseout="mouseOut1()">
			타임라인
		</div>
		<div id="menu2" onclick="menuMove('/MyUsed/MyUsedMyPage.nhn?mem_num=${mynum}')" onmouseover="mouseOver2()" onmouseout="mouseOut2()">
			정보
		</div>	
		<div id="menu3" onclick="moveFriendMenu('${mem_num}')" onmouseover="mouseOver3()" onmouseout="mouseOut3()">
			친구
		</div>	
		<div id="menu4" onclick="movePictureMenu('${mem_num}')" onmouseover="mouseOver4()" onmouseout="mouseOut4()">
			사진
		</div>	
		<div id="menu5" onclick="menuMove('/MyUsed/paperMain.nhn?mynum=${mynum}')" onmouseover="mouseOver5()" onmouseout="mouseOut5()">
			쪽지
		</div>	
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
	
	
</body>
</html>