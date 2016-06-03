<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<div style="width:90%;height:3000px; margin-left:5%; background-color:#EAEAEA;">
<br /><br />

<div id="newrequest" style="background-color:#FFFFFF">
	<div id="knewpeopletitle">
		<font style="font-size:130%; font-weight:bold; top:5px;">&nbsp;&nbsp;새로운 친구 요청</font>
		<div id="line" style="height:13px; margin-top:-14px;">
			<hr>
		</div>
	</div>
		
	<div id="knewpeopleindex" style="padding-left:50px;">
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
	<br />
	</div>
</div>


<br /><br />

<div id="knewpeople" style="background-color:#FFFFFF; height:700px;">
	<div id="knewpeopletitle">
		<font style="font-size:130%; font-weight:bold; top:5px;">&nbsp;&nbsp;알 수 도 있는 친구</font>
		<div id="line" style="height:13px; margin-top:-14px;">
			<hr>
		</div>
	</div>
	<br />
	<div id="knewpeopleindex" style="position:absolute; padding-left:50px;">
		<c:forEach var="knewFriendList_image" items="${knewFriendList_image}">
			<div style="width:110px; height:120px">
			<img src="/MyUsed/images/profile/${knewFriendList_image.profile_pic}" width="110" height="110" onclick="location.href='/MyUsed/MyUsedMyPage.nhn?mem_num=${knewFriendList_image.mem_num}'" style="cursor:pointer;">
			</div>
		</c:forEach>
	</div>
	
	
	<div id="knewpeoplename" style="position:absolute; padding-left:50px; margin-top:-7px;">
		<c:forEach var="knewFriend" items="${knewFriendList}">
			<div style="width:80%; height:120px; padding-top:45px; padding-left:50px; margin-left:130px;/* border:1px solid #000000; */">
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${knewFriend.mem_num}"  onmouseover="this.style.textDecoration='none'">
					<font style="font-size:125%; font-weight:bold;">${knewFriend.name}</font>&nbsp;&nbsp; 
				</a>
				<font style="font-size:95%;" color="#A6A6A6">함께 아는 친구 ${knewFriend.count}명</font>
				
				<div style="width:40%; height:120px; padding-top:45px; margin-left:90%; margin-top:-70px; text-align:center;/*  border:1px solid #000000; */">
				<form action="MyUsedAddFriend.nhn">
					<select name="fri_categ">
                    	<c:forEach var="friendCateg" items="${friendCateg}">
                    		<option>${friendCateg.categ}</option>
                    	</c:forEach>
                	</select>
					<input type="hidden" name="num" value="${sessionproDTO.mem_num}">
					<input type="hidden" name="mem_num" value="${knewFriend.mem_num}">
					<input type="hidden" name="id" value="${knewFriend.id}">
					<input type="submit" value="친구 추가" class="btn btn-success">
				</form>
				</div>
			</div>
		</c:forEach>
	</div>
	<br /><br />
</div>	





<br /><br />

</div>