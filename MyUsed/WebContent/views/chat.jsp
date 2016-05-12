<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>My Used</title>

<script src="/Vertx/js/jquery-1.10.2.min.js"></script>
<script src="/Vertx/js/socket.io.js"></script>

<script>
	$(document).ready(function() {
			var socket = io.connect("http://192.168.50.27:12345");  //서버연결 
			socket.on('response', function(msg){	// 서버로부터 채팅메세지를 계속 받고있다...
			messenger.area.value = messenger.area.value + msg.msg + '\n';	// 채팅 메세지 받아 출력 부분..
			$('textarea').scrollTop($('textarea')[0].scrollHeight);	//채팅 전송할 때 스크롤 자동 포커스
		});
		
		// 텍스트박스내부의 채팅 내용 보내기
		$("#sendBtn").bind("click", function() {	//보내기 버튼 눌렀을 때.(onclick)
			var msg = $("textarea[name=chat]").val();	// 메시지내용을 msg변수에 저장
			var sessionId = '${sessionScope.memId}' + ' : ';	// session아이디 받는 변수
			socket.emit('msg', {msg:sessionId + msg});	// 서버로 채팅 메세지 보내는 부분
			messenger.chat.focus();		// 메시지 전송하고 포커스 맞추기.
			messenger.chat.value = "";	// 메시지 전송하고 text공백.
			$('textarea').scrollTop($('textarea')[0].scrollHeight);	//채팅 전송할 때 스크롤 자동 포커스
		});
		
		// 쉬프트+엔터 = 줄바꿈 , 엔터 = 보내기버튼
		$("#chati").keypress(function(event){
			if(event.keyCode == 13 && !event.shiftKey){
				$('#sendBtn').focus().click();
				return false;
			}
		});
	});
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
    	window.setInterval('countAjax()', 200); //0.2초마다한번씩 함수를 실행
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
    	window.setInterval('namelistAjax()', 200); //0.2초마다한번씩 함수를 실행
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
				<td align="center"><div id="countReturn"></div></td>
			</tr>
		
			<tr>
				<td><textarea name="area" id="areai" readonly="readonly" rows="25" cols="40"></textarea></td>
				<td>
				<div id="namelistReturn"></div>
				</td>
			</tr>
			
			<tr>
				<td><textarea name="chat" id="chati" rows="3" cols="40"></textarea></td>
			</tr>
			
			<tr align="center">
				<td><input type="button" value="보내기" id="sendBtn"/>
					<input type="button" value="나가기" onclick="Exit()"/>
				</td>
			</tr>

			<span id="msgs"></span>
		</table>
		</center>
	</form>
	
</body>
</html>