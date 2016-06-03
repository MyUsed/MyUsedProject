<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<style>

			
/*****친구목록******/
										
#friendlist_img {position:relative;  
		   width:50px; 
		   height:50px; 
		   margin-left:0px;
		   margin-top:10px;
		   border:1px solid #D5D5D5;
		   text-align:left;
		   }
		   
#friendlist_img_line {position:absolute;
		   width:50px; 
/* 		   height:50px; 
		   margin-top:-115px; */
		   text-align:left;
		   }	
									
#friendlist {position:relative;  
		   width:140px; 
		   height:50px; 
		   margin-top:10px;
		   margin-left:55px;
		   padding-top:33px;
		   padding-left:5px;
		   text-align:left;
		   font-weight:bold;
		   font-size: 85%;
		   }			
						
/* #friendlist_line {position:absolute;    
		   width:140px; 
		   height:50px; 
		   margin-top:-115px;
		   text-align:left;
		   }	 */
		   	
#friendlist_side {position:absolute;    
		   width:5px; 
		   height:90%; 
		   margin-top:5px;
		   margin-left:-16px;
		   border-left:1px solid #D5D5D5;
		   }	
	
			
#friendlist_all { position:absolute; 
			  width:800px; 
			  height:650px; 
			  margin-top:195px;
			  margin-right:10px; 
			  background:#FFFFFF;
			  border:1px solid #BDBDBD; }
			  
			  			  
#friendlist_line { position:absolute; 
		width:790px; 
		margin-top:-17px; 
		height:2px;  }			  
			  
#friendlist_title { position:absolute; 
			  width:799px; 
			  height:30px;  
			  margin-top:0px; 
			  margin-right:10px; 
			  font-weight:bold;
			  font-size:120%;
			  padding-top:2px;
			  padding-left:6px;
			  text-shadow: 1px 1px 1px #BDBDBD; }

#friendlist_index { position:absolute; 
			  width:760px; 
			  height:650px;  
			  margin-top:35px; 
			  margin-left:20px;
			  float:left;} 
			  


</style>

<html lang="ko">

<body>
<div style="margin-left:70px;">
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
</body>
</html>