<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>

#fri_msgPop { position:fixed; 
		width:350px; 
		height:400px;
		margin-top:21px;
		margin-left:48%;
		padding-left:20px;
		font-size:90%;
		background:#FFFFFF;
		box-shadow: 2px 2px 1px #A6A6A6;
		border:1px solid #EAEAEA;
		z-index:500; }	
		
#fri_msgtitle { position:fixed; 
		width:300px; 
		height:24px;
		margin-top:10px;
		border-bottom:1px solid #D5D5D5;}		

#fri_msgtext { position:fixed; 
		width:328px; 
		height:311px;
		margin-top:50px;
		font-size:100%; }		

#fri_closemsg{position:fixed; 
			width:15px; 
			height:15px;
			margin-top:10px;
			margin-left:305px;}
			
#fri_arrow { position:fixed; 
		width:25px; 
		height:25px;
		margin-top:8px;
		margin-left:968px;
		z-index:999; }

</style>

<!-- 메시지 -->
<div id="fri_arrow" style='display:none;'>
	<img src="/MyUsed/images/arrow.png" width="25" height="20"> 
</div>
<div id="fri_msgPop" style='display:none;'>
    
	<div id="fri_closemsg">
		<label for="fri_close4" style="cursor:pointer;">
			<img src="/MyUsed/images/close.png" width="15" height="15">
		</label>
    </div>
    
   	<input type="button" id="fri_close4" OnClick="javascript:fri_closeMsg()" style='display: none;'>
   	<br />
   	<div id="fri_msgtitle">
   		<font size="3"><b>친구</b></font>
   	</div>
   	
   	<div id="fri_msgtext">
 
 	<table width="90%" height="100%" >
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
