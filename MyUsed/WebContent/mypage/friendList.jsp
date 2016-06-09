<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">


<script src="/MyUsed/member/jquery-1.11.3.js"></script>
<script src="/MyUsed/member/animate.js"></script>
<style type="text/css">
#sidebannerR { position:fixed; 
		top:50px; 
		height:500%; 
		left:86%; 
		width:14%;
		margin-left:0%;  
		padding-left:1%;
		background:#EAEAEA; 
		z-index:100;
	}
</style>


</head>
<body>
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
 	
</body>
</html>