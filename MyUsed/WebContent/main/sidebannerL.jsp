<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src="/MyUsed/main/animate.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<body>




 	<br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/modify.png" width="20" height="20">&nbsp;������ ����</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/newSpeed.png" width="20" height="20">&nbsp;�����ǵ�</a>
 	<br /><br />
 	
 	<!--��ǰ ī�װ� ���� ��ȸ -->
 	<nav class="nav">
		<ul class="gnb">
 			<li><a href="#"><img src="/MyUsed/images/categ.png" width="20" height="20">&nbsp;ī�װ�</a>
 			<ul class="sub">
	      		<li>
	      			<table width="95%" height="300" border="0" align="right">
	      				<tr height="25%">
	      				<c:forEach begin="0" step="1" end="3" var="viewCateg" items="${viewCategList}">
	      					<td align="left"><a href="/MyUsed/MyUsedProductView.nhn?categ=${viewCateg.categ}&currentPage=1" onmouseover="this.style.textDecoration='none'">
	      						${viewCateg.categ}
	      					</a></td>
	      				</c:forEach>
	      				</tr>
	      				<tr height="25%">
	      				<c:forEach begin="4" step="1" end="7" var="viewCateg" items="${viewCategList}">
	      					<td align="left"><a href="/MyUsed/MyUsedProductView.nhn?categ=${viewCateg.categ}&currentPage=1" onmouseover="this.style.textDecoration='none'">
	      						${viewCateg.categ}
	      					</a></td>
	      				</c:forEach>
	      				</tr>
	      				<tr height="25%">
	      				<c:forEach begin="8" step="1" end="11" var="viewCateg" items="${viewCategList}">
	      					<td align="left"><a href="/MyUsed/MyUsedProductView.nhn?categ=${viewCateg.categ}&currentPage=1" onmouseover="this.style.textDecoration='none'">
	      						${viewCateg.categ}
	      					</a></td>
	      				</c:forEach>
	      				</tr>
	      				<tr height="25%">
	      				<c:forEach begin="12" step="1" end="15" var="viewCateg" items="${viewCategList}">
	      					<td align="left"><a href="/MyUsed/MyUsedProductView.nhn?categ=${viewCateg.categ}&currentPage=1" onmouseover="this.style.textDecoration='none'">
	      						${viewCateg.categ}
	      					</a></td>
	      				</c:forEach>
	      				</tr>
	      			</table>	      		
	      		</li>
	      	</ul>
    	</li>
    	</ul>
    </nav>
    
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/chat.nhn"><img src="/MyUsed/images/chat.png" width="20" height="20" onclick="openChat();">&nbsp;ä�ù�</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/friend.png" width="20" height="20">&nbsp;ģ������</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/picture.nhn"><img src="/MyUsed/images/picture.png" width="20" height="20">&nbsp;����</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/address.nhn"><img src="/MyUsed/images/address.png" width="20" height="20">&nbsp;�ּҷ�</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/board.png" width="20" height="20">&nbsp;�Խ���</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/deliver.png" width="20" height="20">&nbsp;��۰���</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/like.png" width="20" height="20">&nbsp;���ϱ�</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a onclick="javascript:callAjax_friend('${num}')" style="cursor:pointer;"><img src="/MyUsed/images/friendSearch.png" width="20" height="20">&nbsp;ģ��ã��</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/deposit.png" width="20" height="20">&nbsp;�Ա���Ȳ</a>
   	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/option.png" width="20" height="20">&nbsp;����</a>
</body>
