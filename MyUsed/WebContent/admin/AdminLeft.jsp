<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>


	<table bgcolor="white" align="left" border="1" width="15%" height="100%">
	<tr bgcolor="white" height="10" align="center"><td><font face="Comic Sans MS" size="4" color="blue" > <strong>QuickMenu</strong></font>  </td></tr>
	<tr><td>
	<strong>- 회원관리</strong> <br/>
			<a href="/MyUsed/MyUsedMemTotal.nhn">회원정보토탈</a> <br/>
			<a href="/MyUsed/MyUsedMemInfo.nhn">개인수정요청</a> <br/>
			<a href="/MyUsed/MyUsedMemReport.nhn">신고계정관리</a> <br/>
	</td></tr>
	<tr><td>
	<strong>- 페이지관리</strong> <br/>
			<a href="/MyUsed/ModifyCateg.nhn">카테고리관리</a> <br/>
			약관수정<br/>
	</td></tr>
	<tr><td>
	<strong>- 게시글관리</strong> <br/>
			<a href="admin_boardMain.nhn">게시글검색</a> <br/>
	</td></tr>
	<tr><td>
	<strong>- 거래관리</strong> <br/>
			<a href="/MyUsed/tradeApply.nhn">거래신청</a> <br/>
			<a href="/MyUsed/tradeDeposit.nhn">입금상태</a> <br/>
			<a href="/MyUsed/tradePost.nhn">배송상태</a> <br/>
			
	</td></tr>
	<tr><td>
	<strong>- 광고관리</strong> 
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;
		<c:if test="${bannerCount != null}">
	<a href="/MyUsed/applyBanner.nhn"><font size="2" color="red">${bannerCount}건</font></a>
		</c:if> <br/>
			<a href="/MyUsed/insertBanner.nhn">광고등록</a> <br/>
			<a href="/MyUsed/updateBanner.nhn">광고수정</a><br/>
			<a href="/MyUsed/deleteBanner.nhn">광고삭제</a> <br/>
			<a href="/MyUsed/applyBanner.nhn">광고심사</a> <br/>
	</td></tr>
	<tr><td>
	<strong>- 고객센터관리</strong> <br/>
			QnA수정 <br/>
			FaQ수정 <br/>
			공지사항 수정<br/>
			게시판 생성<br/>
			<br/><br/><br/><br/><br/><br/><br/>
	</td></tr>
	
	
	
	</table>

</body>
</html>