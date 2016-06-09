<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />

<title>비밀번호 확인</title>
<style type="text/css">
		
</style>

<script language="javascript">
  function comfrimpw(){
	  
	  if('${memDTO.password}' == pw.value){
			alert('비밀번호 확인이 완료되었습니다');
	    	opener.document.userinput.signup_pw.onfocus="";	//포커스 이벤트 끄기
			self.close();	//팝업창 닫기
	  }else{
			alert('비밀번호를 다시 확인해주세요');
	  }
  }

</script>

</head>
<body bgcolor="#E9EAED">
	<br />
	<table border="0" align="center">
		<tr>
			<td colspan="2" align="center">
				<img src="/MyUsed/images/profile/${sessionproDTO.profile_pic}" width="150" height="150" style="margin-bottom:5px;">
			</td>
		</tr>
		<tr height="60px">
			<td colspan="2" align="center">
				<font style="font-size:130%; font-weight:bold;">
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${memDTO.num}">${memDTO.name}</a>
				님이 맞으십니까?
				</font><br />
				비밀번호를 입력해주세요.
			</td>
		</tr>
		<tr height="20px">
			<td align="left">
				<input type="text" value="${memDTO.id}" style="width:210px" class="signup_input">
			</td>
		</tr>
		<tr height="30px">
			<td align="left">
				<input type="password" id="pw"  style="width:210px" class="signup_input" placeholder="비밀번호를 입력하세요">
			</td>
		</tr>
		<tr height="45px">
			<td align="center">
			<input type="button" onclick="comfrimpw()" value="확  인" class="btn btn-success" style="width:150px">
			</td>
		</tr>
	</table>
</body>

</html>


