<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="ko">
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="/MyUsed/main/script.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>


<style type="text/css">
/* #sidebannerR { position:fixed; top:50px; left:43%; margin-left:540px; width:240px; height:800px; background:#EAEAEA; }
#sidebannerL { position:fixed; top:50px; right:50%; margin-right:465px; width:205px; height:800px; background:#E9EAED; } */
#content { width:100%; height:3000px; margin-left:0px; background:#EAEAEA; }
/* #knewpeople { position:fixed; width:311px; height:9000px; left:60%; margin-right:300px;background:#E9EAED; } */

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
		   padding-top:20px;
		   padding-left:10px;
		   }
#memlist3 {width:70px; 
		   height:70px; 
		   text-align:left;
		   margin-top:-70px;
		   margin-left:340px;
		   padding-top:10px;
		   }
#gap { width:465px; 
	height:10px; 
	margin-left:0px;}
</style>

</head>



<body>


<!-- <div id="knewpeople">
알 수 도 있는 친구ㅇ


</div> -->

<div id="content">
	<br /><br />
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
	
	<c:if test="${searchMemList.size() > 0}">
		<c:forEach var="search" items="${searchMemList}">
			<div id="memlist">
				<div id="memlist1">
					<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${search.num}"">
						<img src="/MyUsed/images/profile/${search.profile_pic}" width="70" height="70">
					</a>
				</div>
				<div id="memlist2">
					<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${search.num}"">
						<b>${search.name}</b> <br />
					</a>
				</div>
				
				<div id="memlist3">
				
					<form action="MyUsedAddFriend.nhn">
						<input type="hidden" name="num" value="${num}">
						<input type="hidden" name="mem_num" value="${search.num}">
						<input type="hidden" name="id" value="${search.id}">
						<select name="fri_categ">
                    		<c:forEach var="friendCateg" items="${friendCateg}">
                    			<option>${friendCateg.categ}</option>
                    		</c:forEach>
                		</select>
                		<input type="submit" value="친구추가" class="btn btn-success">
                	</form>
                
				</div>
				
			</div>
			<div id="gap"></div>
		</c:forEach>
	</c:if>
	</center>
</div>	

</body>
</html>


