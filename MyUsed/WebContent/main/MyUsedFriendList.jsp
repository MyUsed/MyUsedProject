<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->

<script src="/MyUsed/member/jquery-1.11.3.js"></script>
<!-- <script src="/MyUsed/member/animate.js"></script> -->
<script type="text/javascript">
/* 친구 삭제 새창열기 */
function deleteFriend(mem_num){
    url = "/MyUsed/DeleteFriend.nhn?mem_num="+mem_num;
    
    // 새로운 윈도우를 엽니다.
    open(url, "confirm", 
	"toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
}

/* 친구 카테고리 변경 새창열기 */
function modifyFriendCateg(mem_num){
    url = "/MyUsed/ModifyFriendCateg.nhn?mem_num="+mem_num;
    
    // 새로운 윈도우를 엽니다.
    open(url, "confirm", 
	"toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=400, height=200");

}

function subView(aa){
	var subView = document.getElementById("subView"+aa);
	subView.attr('style','display:block;width:120px; box-shadow:1px 1px 1px #BDBDBD;');
}
function subNone(aa){
	var num = document.getElementById("subView"+aa);
	subView.attr('style','display:none;');
}

</script>

<style type="text/css">

#header{height:80px; border-bottom:1px solid #d9d9d9;}
.header_wrap1{width:1100px; margin:0 auto;}
.header_wrap1 h1{float:left; margin:27px 0;}
.nav1{float:right; text-align:center;}
.gnb1>li{ float:left; width:80px; height:80px; list-style:none;}
.sub1{position:relative; background:#fff;  margin-top:10px; }
.sub1>li{height:30px; margin-left:-41px; list-style:none; }
</style>

</head>
<div style="margin-top:0px; width:90%; height:5px; margin-left:5%; background-color:#EAEAEA;"></div>
<div style="margin-top:50px; width:90%; height:auto; margin-left:5%; background-color:#FFFFFF;">
<br />
<font style="font-size:140%; font-weight:bold;">
&nbsp;&nbsp;친구 목록
</font>
<hr width="100%">
<br />
<table border="0" width="100%" align="center" bgcolor="#FFFFFF">
<table border="0" width="80%" align="center">
	<c:forEach var="friend" items="${friendpicList}">
		<script type="text/javascript">

		function subView${friend.mem_num}(){
			$("#subView${friend.mem_num}").attr('style','display:block;width:120px; box-shadow:1px 1px 1px #BDBDBD;');
		}
		function subNone${friend.mem_num}(){
			$("#subView${friend.mem_num}").attr('style','display:none;');
		}

		</script>
		<tr height="100">
			<td width="100" align="center">
				<img src="/MyUsed/images/profile/${friend.profile_pic}" width="100" height="100" onclick="http://localhost:8000/MyUsed/MyUsedMyPage.nhn?mem_num=${friend.mem_num}">
			</td>
			<td align="center" width="50%">
				<a href="http://localhost:8000/MyUsed/MyUsedMyPage.nhn?mem_num=${friend.mem_num}">
					<font style="font-size:110%; font-weight:bold;">
						${friend.name} 
					</font><br />
				</a>
						${friend.categ} 
			</td>
			<td align="left" valign="middle">
				<br /><br />
				<div style="position:absolute; margin-top:-30px; margin-left:50px; cursor:pointer;" onmouseover="subView${friend.mem_num}()" onmouseout="subNone${friend.mem_num}()">
				<font color="#223C6F">친구 ▼</font></div>
				 	<ul id="subView${friend.mem_num}" class="sub1" style="position:absolute; display:none;">
	      				<li><a onclick="deleteFriend('${friend.mem_num}')" style="cursor:pointer;">친구 끊기</a></li>
            			<li><a onclick="modifyFriendCateg('${friend.mem_num}')" style="cursor:pointer;">카테고리 변경</a></li>
            			<li><a href="/MyUsed/paperMain.nhn?mynum=${memDTO.num}" style="cursor:pointer;">쪽지 보내기</a></li>
        			</ul> 
			</td>
		</tr>
		<tr height="10">
			<td colspan="3">&nbsp;</td>
	</tr>
	</c:forEach>
</table>
</table>
<br /><br />

</div>