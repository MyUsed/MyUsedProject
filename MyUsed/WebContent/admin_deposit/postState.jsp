<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>배송상태 페이지</title>

<script>
	

/* 배송조회 새창 열기 */
function seachPost(post){

    url = "https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?post="+post;
    
    open(url, "confirm", 
	"toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=1000, height=600");
}



</script>

</head>
<body>
<!---------------------- 작업할때 2개만 include 해서 사용 ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->	
<center>
	<br/>
		<h2>* 배송상태목록 *</h2>
	<br/><br/>
		
	<table border="1">
	
		<tr align="center">
		<td bgcolor="#B2CCFF"><strong>구매자회원번호</strong></td><td bgcolor="#B2CCFF"><strong>구매자</strong></td><td bgcolor="#B2CCFF"><strong>판매상품</strong></td>
		<td bgcolor="#B2CCFF"><strong>판매자</strong></td><td bgcolor="#B2CCFF"><strong>은행</strong></td><td bgcolor="#B2CCFF"><strong>계좌</strong></td>
		<td bgcolor="#B2CCFF"><strong>이름</strong></td><td bgcolor="#B2CCFF"><strong>금액</strong></td><td bgcolor="#B2CCFF"><strong>송장번호</strong></td>
		<td bgcolor="#B2CCFF"><strong>배송상태</strong></td>
		</tr>
		
			<c:forEach var="selllist" items="${selllist}">
		<tr align="center">
			<td>${selllist.buy_memnum}</td>
			<td>${selllist.buy_name}</td>
			<td><img src="/MyUsed/images/${selllist.sell_propic}" width="30" height="30"/></td>
			<td>${selllist.sell_name}</td>
			<td>${selllist.bankname}</td>
			<td>${selllist.acount}</td>
			<td>${selllist.sendname}</td>
			<td bgcolor="#FFEF85">${selllist.buy_price}</td>
			<td><a Onclick="javascript:seachPost(${selllist.postnum})" style="cursor:pointer;" title="조회하기"><font color="blue">${selllist.postnum}</font></a></td>
			<td>
			<c:if test="${selllist.state == 0}"><input type="button" value="배송확인" onclick="javascript:window.location='depositCheck.nhn?seq_num=${selllist.seq_num}'"/></c:if>
			<c:if test="${selllist.state == 1}"><font color="red">배송확인</font></c:if>
			</td>
			
		</tr>
			</c:forEach>
	
	</table>
	<br />
		${pagingHtml}
	
		
</center>		
	
		
		
	
	
</body>
</html>