<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>거래요청페이지</title>
</head>
<body>
<!---------------------- 작업할때 2개만 include 해서 사용 ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->	
<center>
	
	<br/>
		<h2>* 거래신청목록 *</h2>
	<br/><br/>
		
	<table border="1">
	
		<tr align="center">
		<td bgcolor="#B2CCFF"><strong>구매자회원번호</strong></td><td bgcolor="#B2CCFF"><strong>구매자ID</strong></td><td bgcolor="#B2CCFF"><strong>구매자이름</strong></td>
		<td bgcolor="#B2CCFF"><strong>구매금액</strong></td><td bgcolor="#B2CCFF"><strong>입금상태</strong></td><td bgcolor="#B2CCFF"><strong>거래신청일</strong></td><td><font color="red"><strong></strong></font></td>
		<td bgcolor="#CC3D3D"><strong>판매상품번호</strong></td><td bgcolor="#CC3D3D"><strong>판매자ID</strong></td><td bgcolor="#CC3D3D"><strong>판매자이름</strong></td>
		<td bgcolor="#CC3D3D"><strong>판매카테고리</strong></td><td bgcolor="#CC3D3D"><strong>판매상품</strong></td>
		</tr>
		
		<c:forEach var="orderlist" items="${orderlist}">
		<tr align="center">
		<td>${orderlist.buy_memnum}</td><td>${orderlist.buy_id}</td><td>${orderlist.buy_name}</td><td bgcolor="#FFEF85"><strong>${orderlist.buy_price}</strong></td>
		<td><c:if test="${orderlist.state == 0}"><font color="blue">입금전</font></c:if>
			<c:if test="${orderlist.state == 1}"><font color="red">입금완료</font></c:if>
		</td>
		<td><fmt:formatDate value="${orderlist.reg}" type="date"/></td><td><font color="red"><strong>>>>>></strong></font></td>
		<td>${orderlist.sell_pronum}</td><td>${orderlist.sell_id}</td><td>${orderlist.sell_name}</td>
		<td>${orderlist.sell_categ}</td><td><img src="/MyUsed/images/${orderlist.sell_propic}" width="30" height="30"/></td>
		</tr>
		</c:forEach>
	
	</table>
		
</center>		
	
		
		
	
	
</body>
</html>