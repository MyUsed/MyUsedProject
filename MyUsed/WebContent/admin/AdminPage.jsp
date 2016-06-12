<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> 관리자 페이지 </title>
<link rel="stylesheet" type="text/css" href="/MyUsed/admin/admin.css" />

</head>
<body>
	
<!---------------------- 작업할때 2개만 include 해서 사용 ------------------------------->
<div id="AdminTop"><jsp:include page="AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->


<div id="board"> <!-- 게시판 공지사항 -->
<b>공지사항</b> <a href="admin_notice.nhn"><font size="2">더보기</font></a>
<table border="1" width="550" height="130" style="border:2px double #747474; border-collapse:collapse;">

	<c:forEach var="admin_Notice" items="${admin_Notice}" begin="0" end="4">
	<tr>
	<td width="70">공지사항</td>
	<td width="350"> ${admin_Notice.title} </td>
	<td width="110" align="center">
	<c:if test="${fn:length(admin_Notice.reg) > 11}">
	${fn:substring(admin_Notice.reg,0,10)}
	</c:if>
	</td>
	</tr>
	</c:forEach>

</table>
</div>

<div id="call">  <!-- 처리요청 건수 -->
<b>게시글 통계</b>
<table border="1" width="250" height="130" style="border:2px double #747474; border-collapse:collapse;">
	<tr>
	<td bgcolor="#EAEAEA" width="150">총 게시글</td><td align="right"><b><font color="red">${total_board} 건</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">신고접수 게시글</td><td align="right"><b><font color="red">0 건</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">댓글 1000개 이상</td><td align="right"><b><font color="red">${board_reples} 건</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">좋아요 1000개 이상</td><td align="right"><b><font color="red">${board_likes} 건</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">당일 업데이트</td><td align="right"><b><font color="red">0 건</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">최근 일주일 업로드</td><td align="right"><b><font color="red">0 건</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">최근 한달 업로드</td><td align="right"><b><font color="red">0 건</font></b></td>
	</tr>
	
</table>
</div>



<div id="info"> <!-- 회원정보 토탈  -->
<b>회원 통계</b> <a href="MyUsedMemTotal.nhn"><font size="2">더보기</font></a>
<table border="1" width="250" height="130" style="border:2px double #747474; border-collapse:collapse;">
	<tr>
	<td bgcolor="#EAEAEA" width="130">총 회원수</td><td align="right"><b>${total_mem}</b> 명</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">접속중 회원</td><td align="right"><b>${mem_login}</b> 명</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">신고접수 회원</td><td align="right"><b>${mem_report}</b> 명</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">일반 회원</td><td align="right"><b>${nomal_mem}</b> 명</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">네이버 회원</td><td align="right"><b>${naver_mem}</b> 명</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">30대 회원</td><td align="right"><b>0</b> 명</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">40대 이상</td><td align="right"><b>0</b> 명</td>
	</tr>
</table>
</div>





<div id="trade"> <!-- 거래 현황 -->
	
	<div id="trade_1"> <center><br/> <b>거래신청</b> <br/> <br/><b><font color="red">${trade_all} 건</font></b></center></div> 
	
	<div id="trade_2"> 
	<center><br/><b>입금상태</b><br/><font size="2">입금완료</font> <b><font color="red">${trade_deposit} 건</font></b><br/>
	<font size="2">송금완료</font> <b><font color="red">${trade_finish} 건</font></b></center>
	</div>
	
	<div id="trade_3"> <center> <b>배송중</b> <br/><b><font color="red">${trade_send} 건</font></b></center></div>
	<div id="trade_4"> <center> <b>배송완료</b> <br/><b><font color="red">${trade_finish} 건</font></b></center></div>
	<div id="trade_5"> <center><br/> <b>거래완료</b> <br/> <br/><b><font color="red">${trade_finish} 건</font></b></center></div>
	
	
	<div id="arrow_1"><center> ▷ ▶</center></div>
	<div id="arrow_2"><center> ▷ ▶</center></div>
	<div id="arrow_3"><center> ▷ ▶</center></div>
	
	
</div>



<div id="state"> <!-- 진행상태 -->
	<b>거래 입출금 내역</b>
	<br/><br/><br/><br/> <center> <input type="button" value="   조회   "/> </center>
</div>

<div id="product"> <!-- 상품현황 -->
	<b>상품 현황</b><br/>
	<table border="1" width="250" height="160" style="border:2px double #747474; border-collapse:collapse;">
		<tr>
		<td bgcolor="#EAEAEA" width="150">총 상품판매글</td><td align="right"><b><font color="red">${total_pro} 건</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">거래중인 상품</td><td align="right"><b><font color="red">${trade_all} 건</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">거래완료 상품</td><td align="right"><b><font color="red">${trade_finish} 건</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">거래 요청된 상품</td><td align="right"><b><font color="red">${trade_all} 건</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">거래 취소된 상품</td><td align="right"><b><font color="red">0 건</font></b></td>
		</tr>
	</table>
</div>

<div id="advertice"> <!-- 광고현황 -->
	<b>광고 현황</b> <a href="applyBanner.nhn"><font size="2">더보기</font></a>
	<table border="1" width="250" height="160" style="border:2px double #747474; border-collapse:collapse;">
		<tr>
		<td bgcolor="#EAEAEA" width="150">총 광고신청 수</td><td align="right"><b><font color="red">${total_banner} 건</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">광고 심사 통과</td><td align="right"><b><font color="red">${banner_pass} 건</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">광고 심사 탈락</td><td align="right"><b><font color="red">${banner_fail} 건</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">입찰중인 광고</td><td align="right"><b><font color="red">${banner_pass} 건</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">등록된 광고 수</td><td align="right"><b><font color="red">1 건</font></b></td>
		</tr>
	</table>
</div>

<div id="money"> <!-- 인기현황 -->
	<b>매출 현황</b>
	<table border="1" width="250" height="160" style="border:2px double #747474; border-collapse:collapse;">
		<tr>
		<td bgcolor="#EAEAEA" width="100">이달 총 매출</td><td align="right"><b>3.243.000</b> 원</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="100">전달 총 매출</td><td align="right"><b>0</b> 원</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="100">미정</td><td align="right"><b>0</b> 원</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="100">미정</td><td align="right"><b>0</b> 원</td>
		</tr>
	</table>
</div>

<div id="member"> <!-- 직원 -->
	<b>직원 관리</b> <a href="AdminMember.nhn"><font size="2">수정하러가기</font></a><br>
	<table border="1" width="250" height="160" style="border:2px double #747474; border-collapse:collapse;">
		<tr>
		<td bgcolor="#EAEAEA" width="150">총 직원 수</td><td align="right"><b>${total_adminMem}</b> 명</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">팀장</td><td align="right"><b>${adminMem_Team1}</b> 명</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">과장</td><td align="right"><b>${adminMem_Team2}</b> 명</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">대리</td><td align="right"><b>${adminMem_Team3}</b> 명</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">사원</td><td align="right"><b>${adminMem_Team4}</b> 명</td>
		</tr>
	</table>
</div>






</body>
</html>