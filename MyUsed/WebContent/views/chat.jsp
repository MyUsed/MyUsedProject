<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>My Used</title>

<script src="/Vertx/js/jquery-1.10.2.min.js"></script>
<script src="/Vertx/js/socket.io.js"></script>
<link rel="stylesheet" type="text/css" href="views/style.css" />


<script>
	var loginId = '${sessionScope.memId}';
	$(document).ready(function() {
			var socket = io.connect("http://192.168.50.27:12345");  //서버연결 
			socket.on('response', function(msg){	// 서버로부터 채팅메세지를 계속 받고있다...
				var a = msg.msg;	// msg.gsg = 아이디 : 채팅내용
				var ap = a.split(':');	// ap[0] = 아이디 , ap[1] = 채팅내용
				a = ap[0].trim();		// 앞뒤공백 자르고 var a에 대입
				if(a == loginId){		// 아이디가 sessionid와 같으면
					var ChatMsg = $("#areai").append("<div class='from-me'>"+ap[1]+"</div><div class='clear'></div>");
					ChatMsg = ChatMsg + ap[1];	// 채팅 메세지 받아 출력 부분(아이디를 출력하지 않음)
					messenger.chat.value = "";		// 메시지 출력하고 채팅창 초기화. 
				}
				else{
					var ChatMsg = $("#areai").append("<div class='from-them'>"+ap[1]+"</div><div class='clear'></div>");
					ChatMsg = ChatMsg + msg.msg;	// 채팅 메세지 받아 출력 부분(아이디를 출력함)
				}
			$('#areai').scrollTop($('#areai')[0].scrollHeight);	//채팅 전송할 때 스크롤 자동 포커스
		});
		
		// 텍스트박스내부의 채팅 내용 보내기
		$("#sendBtn").bind("click", function() {	//보내기 버튼 눌렀을 때.(onclick)
			var msg = $("textarea[name=chat]").val();	// 메시지내용을 msg변수에 저장
			var sessionId = '${sessionScope.memId}' + ' : ';	// session아이디 받는 변수
			socket.emit('msg', {msg:sessionId + msg});	// 서버로 채팅 메세지 보내는 부분
			messenger.chat.focus();		// 메시지 전송하고 포커스 맞추기.
			$('#areai').scrollTop($('#areai')[0].scrollHeight);	//채팅 전송할 때 스크롤 자동 포커스
		});
		
		// 쉬프트+엔터 = 줄바꿈 , 엔터 = 보내기버튼
		$("#chati").keypress(function(event){
			if(event.keyCode == 13 && !event.shiftKey){
				$('#sendBtn').focus().click();
				return false;
			}
		});
	});
	
	function profile(){
		if (c) return;
		document.messenger.textarea.style.backgroundImage="";
		c=true;
	}
	
	//body onload
	function focus(){
		messenger.chat.focus();
	}
	//나가기버튼
	function Exit(){
		if (confirm("채팅을 종료하시겠습니까?") == true){
			window.location="chatExit.nhn";
		}
		else{
			return;
		}
	}
	
	function unload(){
		window.location="chatExit.nhn";
	}
</script>



<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<!-- 총접속자수 나타내는 함수 -->
  <script type="text/javascript">
    $(document).ready(function(){
    	window.setInterval('countAjax()', 2000); //2초마다한번씩 함수를 실행
    });
    function countAjax(){
    	 $.ajax({
 	        type: "post",
 	        url : "/MyUsed/oncount.nhn",
 	        success: count,	// 페이지요청 성공시 실행 함수
 	        error: whenError	//페이지요청 실패시 실행함수
      	});
    }
    function count(c){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
        $("#countReturn").html(c);
    }
    function whenError(){
        alert("Error");
    }
  </script>
  
<!-- 접속자의 ID 나타내는 함수 -->
<script type="text/javascript">
    $(document).ready(function(){
    	window.setInterval('namelistAjax()', 2000); //2초마다한번씩 함수를 실행
    });
    function namelistAjax(){
    	 $.ajax({
 	        type: "post",
 	        url : "/MyUsed/namelist.nhn",
 	        success: namelist,	// 페이지요청 성공시 실행 함수
 	        error: whenError	//페이지요청 실패시 실행함수
      	});
    }
    function namelist(nl){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
        $("#namelistReturn").html(nl);
    }
    function whenError(){
        alert("Error");
    }
  </script>

</head>



<body onload="focus()" onbeforeunload="unload()" method="post">

	<form name="messenger" method="post"><br><br>
		<center>
		<table>
			<tr>
				<td align="center">자유 채팅방</td>
				<td align="center"><div id="countReturn">접속자 수: 0명</div></td>
			</tr>
		
			<tr>
				<td><div name="area" id="areai" style="width:310px; height:410px; overflow: auto; background-color: #EAEAEA; border:1px solid #B4B4B4; border-width:1px;"></div></td>
			
				<td>
					<div id="namelistReturn">
						<select name="select" multiple="multiple" size="22" style="width:150px; background-color: #EAEAEA; border:1px solid #B4B4B4; border-width:1px;" onchange="window.open(this.value);">
							<c:forEach var="list" items="${list}">
							
								<c:if test="${name == list.name}">
									<option value="paperchatForm.nhn?mynum=${mynum}&name=${list.id}">${list.name}(나)</option>
								</c:if>
								
								<c:if test="${name != list.name}">
									<option value="paperchatForm.nhn?mynum=${mynum}&name=${list.id}">${list.name}</option>
								</c:if>
								
							</c:forEach>
						</select>
					</div>
				</td>
			</tr>
			
			<tr>
				<td><textarea name="chat" id="chati" rows="3" cols="41" style="background-color: #EAEAEA;"></textarea></td>
				<td align="center">
					<input type="button" value="보내기" id="sendBtn" onclick="profile()"/>
					<input type="button" value="나가기" onclick="Exit()"/>
				</td>
			</tr>
			
			<span id="msgs"></span>

		</table>
		</center>
	</form>

	
	
	<!-- <section>
 <div class="from-me">
   <p>Hey there! What's up?</p>
 </div>
 <div class="clear"></div>
 <div class="from-them">
   <p>Checking out iOS7 you know..</p>
 </div>
 <div class="clear"></div>
 <div class="from-me">
   <p>Check out this bubble!</p>
 </div>
 <div class="clear"></div>
 <div class="from-them">
   <p>It's pretty cool!</p>
 </div>
 <div class="clear"></div>
 <div class="from-me">
   <p>Yeah it's pure CSS &amp; HTML</p>
 </div>
 <div class="clear"></div>
 <div class="from-them">
   <p>Wow that's impressive. But what's even more impressive is that this bubble is really high.</p>
 </div>
</section> -->

</body>
</html>