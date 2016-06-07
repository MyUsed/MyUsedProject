<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body bgcolor="#E9EAED">

	<center >
	
	<h3> * 거래요청된 상품 * </h3>
	
	<img src="/MyUsed/images/${orderInfo.sell_propic}" width="80" height="80"/>
	
	
	<h3> * 배송보낼 주소 *  </h3>
	
	<br/>
		
		<table>
			
			<tr>
				<td><b>구매자</b></td><td><a href="MyUsedMyPage.nhn?mem_num=${orderInfo.buy_memnum}">${orderInfo.buy_name}</a></td>	
			</tr>
			<tr>
				<td><b>받으시는분</b></td> <td>${orderInfo.send_name}</td>
			</tr>	
			<tr>
				<td><img src="/MyUsed/images/phoneIcon.png" width="30" height="30"/></td><td>${orderInfo.send_ph}</td>
			</tr>	
			<tr>
				<td><img src="/MyUsed/images/addrNumIcon.PNG" width="30" height="30"/></td><td>${orderInfo.send_adrnum}</td>
			</tr>	
			<tr>
				<td><img src="/MyUsed/images/addhouse.png" width="30" height="30"/></td><td>${orderInfo.send_addr}-${orderInfo.send_addrr}</td>
			</tr>	
			
		
		</table>
	
					<br/>
		
	
   </center>
	
	
	

	
	
</body>
</html>