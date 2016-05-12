<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>My Used</title>
	<script>
		function openChat(){
			var url = "chat.nhn";
			window.open(url, "chat", "width=500, height=600, resizable=yes, location=no, status=no, toolbar=no, menubar=no, left=400, top=30");
			
		}

	</script>

</head>
<body>

	<form name="checkForm"  method="post">
			<input type="button" id="button" value="자유 채팅방" onclick="openChat();"/><br/>	
	</form>
	
</body>
</html>