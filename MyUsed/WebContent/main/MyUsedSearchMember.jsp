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
                   document.formId.action = "mainTest.nhn";  // submit 하기 위한 페이지 

                   document.formId.submit();
                   document.formId.image_preview();
                  
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
			<a href="http://localhost:8000/MyUsed/MyUsed.nhn">
			<img src="/MyUsed/images/Mlogo2.png" width="170"  height="50">
			</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
			<!-- 친구찾기 -->
				<input type="text" size="70" name="member"/>
				<button type="submit"><img src="/MyUsed/images/Search.png" width="20"  height="20"></button>
			
			
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<img src="/MyUsed/images/profile.png" width="15"  height="15">
				<a href="/MyUsed/MyUsedMyPage.nhn">${name}</a> | 
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
#content { width:630px; height:9000px; margin-left:180px; background:#EAEAEA; }
#knewpeople { position:fixed; width:311px; height:9000px; left:60%; margin-right:300px;background:#E9EAED; }

#memlist { width:465px; 
		   height:120px; 
		   background:#FFFFFF; 
		   text-align:left;
		   margin-left:0px;
		   padding-top:25px;
		   padding-left:10px;
		   }
#memlist1 {width:70px;
		   height:70px;
		   }
#memlist2 {width:300px; 
		   height:70px; 
		   text-align:left;
		   margin-top:-70px;
		   margin-left:80px;
		   padding-top:10px;
		   padding-left:10px;
		   }
#memlist3 {width:70px; 
		   height:70px; 
		   text-align:left;
		   margin-top:-70px;
		   margin-left:373px;
		   padding-top:10px;
		   }
#gap { width:465px; 
	height:10px; 
	margin-left:0px;}
</style>
</head>

<body>
<div id="sidebannerR">
	<center>
 	<font size="5">사이드고정R</font>
   	</center>
</div>
<div id="sidebannerL">
결과 유형
</div>

<div id="knewpeople">
알 수 도 있는 친구ㅇ


</div>

<div id="content">
	<br /><br /><br /><br />
	<center>
	<c:if test="${searchList.size() <= 0}">
	
	<table border="1" bordercolor="#FFBB00">
	<tr height="80">
		<td bgcolor="#FFFFA1" width="400">
			<font color="#000000"><b>&nbsp;${member}님을 찾을 수가 없습니다.</b></font><br />
			<font color="#8C8C8C">&nbsp;검색어의 철자를 확인하시거나 다른 검색어를 사용해 보세요.</font>
		</td>
	</tr>
	</table>	
	</c:if>
	
	<c:if test="${searchList.size() > 0}">
		<c:forEach var="search" items="${searchList}">
			<div id="memlist">
				<div id="memlist1">
					<img src="/MyUsed/images/" width="70" height="70">
				</div>
				<div id="memlist2">
					<b>${search.name}</b> <br />
					설명설명설명
				</div>
				
				<div id="memlist3">
					<input type="button" value="친구추가">
				</div>
			</div>
			<div id="gap"></div>
		</c:forEach>
	</c:if>
	</center>
</div>	

</body>
</html>


