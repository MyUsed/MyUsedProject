<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 
<html lang="ko"> -->
 <head>

<style type="text/css">
#body { position:absolute; top:50px; width:100%; height:700px; background:#FFFFFF; }

#index { position:absolute; 
	top:30px; 
	width:50%; 
	height:80px;
	margin-left:25%;
	background:#EAEAEA; }
	
#box { position:absolute; 
	top:140px; 
	width:50%; 
	height:500px;
	margin-left:25%;
	border-top:solid 2px #BDBDBD;
	background:#EAEAEA; }
</style>
</head> 

<div id="body">
	<div id="index">
		<table width="100%" height="100%">
			<tr>
				<td width="20%" style="padding:0 0 0 20px; border-right:solid 4px #FFFFFF;">
					<font size="4" color="#000000"><b>1단계</b></font>
					<br />
					<font size="2" color="#000000"><b>프로필정보</b></font>
				</td>
				<td width="20%" style="padding:0 0 0 20px; border-right:solid 4px #FFFFFF;" bgcolor="#4c6396">
					<font size="4" color="#FFFFFF"><b>2단계</b></font>
					<br />
					<font size="2" color="#FFFFFF"><b>관심사선택</b></font>
				</td>
				<td width="20%" style="padding:0 0 0 20px; border-right:solid 4px #FFFFFF;">
					<font size="4" color="#000000"><b>3단계</b></font>
					<br />
					<font size="2" color="#000000"><b>프로필사진</b></font>
				</td>
				<td width="40%">
					&nbsp;
				</td>
			</tr>
		</table>
	</div>
	
	<div id="box">
		<br />
		<table border="0" width="85%" height="15%" align="center">
			<tr>
				<td colspan="2">
					<font size="4" color="#000000"><b>관심사 선택</b></font>
					<br />
					이 정보는 MyUsed에 가입한 회원님의 친구를 찾는데 도움이 됩니다.
				</td>
			</tr>
		</table>
		<form id="form1">
		<table border="0" width="85%" height="70%" align="center">
		<%-- 	<tr height="40">
				<td colspan="2">
					&nbsp;
				</td>
			</tr>
			<c:forEach var="friendCateg" items="${friendCateg}">
			<tr height="35">
				<td align="right" width="30%">
					<b>${friendCateg.categ}</b>&nbsp;&nbsp;
				</td>
				<td align="left" width="70%">
					&nbsp;
					<input type="text" name="" style="width:250px">
				</td>
			</tr>
			</c:forEach> --%>
			<tr valign="bottom">
				<td align="left">
					◀뒤로
				</td>
				<td align="right">
					건너뛰기&nbsp;
					<input type="button" value="저장 후 계속" id="button" name="button">
				</td>
			</tr>		
		</table>
		</form>
	</div>



</div>

	
