<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

function callAjax_friend(mem_num){
    $.ajax({
        type: "post",
        url : "/MyUsed/MyUsedFriend.nhn",
        data: {	// url 페이지도 전달할 파라미터
        	mem_num : mem_num
        },
        success: test,	// 페이지요청 성공시 실행 함수
        error: whenError	//페이지요청 실패시 실행함수
 	});
}
function test(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
    $("#contents").html(aaa);
    console.log(resdata);
}
function whenError(){
    alert("Error");
}

function enter(){
	if(event.keyCode = 13){
		searchword();
	}
}



</script>


	<table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
		<tr>
			<td style="vertical-align:left; padding-left: 30px; padding-right: 80px;">
			<a href="/MyUsed/MyUsed.nhn">
			<img src="/MyUsed/images/Mlogo2.png" width="170"  height="50">
			</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
			<!-- 친구찾기 -->
				<input type="text" size="70" name="sword" id="sword" onkeypress="enter()"/>
				<button onclick="searchword()" ><img src="/MyUsed/images/Search.png" width="20"  height="20"></button>
			
			
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<img src="/MyUsed/images/profile/${proDTO.profile_pic}" width="30"  height="30">
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${num}" onmouseover="this.style.textDecoration='none'"><font color="#F6F6F6">${name} |</font></a> 
				<a href="/MyUsed/MyUsed.nhn" onmouseover="this.style.textDecoration='none'"><font color="#F6F6F6">홈 |</font></a>
				<label for="friend"><font color="#F6F6F6" style="font-weight:lighter; cursor:pointer;">친구찾기</font></label>
				<input type="button" id="friend" onclick="javascript:callAjax_friend('${num}')" style="display:none;">
				
				
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainFriend.png" width="45"  height="40" title="친구"></a>
				<a href="paperMain.nhn?mynum=${num}"><img src="/MyUsed/images/mainMessage.png" width="40"  height="35" title="채팅"></a>
				
				<!-- 개인 알림  -->
				<label for="msg">
					<img src="/MyUsed/images/mainView.png" width="40" height="35"  title="알림" style='cursor:pointer;'>
				</label>
				<input type="button" id="msg" OnClick="javascript:openMsg();" style='display: none;' >
				
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!-- 추후 이미지로 바꾸기(페이스북처럼 드롭다운메뉴로) -->
				<c:if test="${sessionScope.memId != null }">
					<a href="/MyUsed/MyUsedLogout.nhn" onmouseover="this.style.textDecoration='none'"><font color="#F6F6F6">로그아웃</font></a>
				</c:if>
			</td>
			
		</tr>
	</table>
	