<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<title>MyUsed</title>
	<style type="text/css">
		#layer_fixed
		{
			height:50px;
			width:120%;
			color: #242424;
			font-size:12px;
			position:fixed;
			z-index:999;
			top:0px;
			left:0px;
			-webkit-box-shadow: 0 1px 2px 0 #777;
			box-shadow: 0 1px 2px 0 #777;
			background-color:#3B5998;
		}
	</style>
</head>

<body>
	<div id="layer_fixed">
		<table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
		<tr>
			<td style="vertical-align:left; padding-left: 30px; padding-right: 80px;">
			<a href="/MyUsed/main/MyUsed.jsp">
			<img src="/MyUsed/images/Mlogo2.png" width="170"  height="50">
			</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" size="70"/>
				<button type="submit"><img src="/MyUsed/images/Search.png" width="20"  height="20"></button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainFriend.png" width="45"  height="40"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainMessage.png" width="40"  height="35"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainView.png" width="40"  height="35"></a>
			</td>
			
		</tr>
		</table>
	</div>



<style type="text/css">
#sidebannerR { position:fixed; top:50px; left:50%; margin-left:470px; width:200px; height:800px; background:#EAEAEA; }
#sidebannerL { position:fixed; top:50px; right:50%; margin-right:470px; width:200px; height:800px; background:#E9EAED; }
#content { width:980px; height:3000px; margin:0 auto; background:#EAEAEA; }
</style>
</head>

<body>
<div id="sidebannerR">
	<center>
 	<font size="5">사이드고정R</font>
   	</center>
</div>
<div id="sidebannerL">
  
 	
 	<br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/modify.png" width="20" height="20">&nbsp;프로필 수정</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/newSpeed.png" width="20" height="20">&nbsp;뉴스피드</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/categ.png" width="20" height="20">&nbsp;카테고리</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/chat.png" width="20" height="20">&nbsp;메세지</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/friend.png" width="20" height="20">&nbsp;친구보기</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/picture.png" width="20" height="20">&nbsp;사진</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/favorite.png" width="20" height="20">&nbsp;즐겨찾기</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/address.png" width="20" height="20">&nbsp;주소</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/board.png" width="20" height="20">&nbsp;게시판</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/deliver.png" width="20" height="20">&nbsp;배송관리</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/like.png" width="20" height="20">&nbsp;좋아요</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/share.png" width="20" height="20">&nbsp;공유하기</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/friendSearch.png" width="20" height="20">&nbsp;친구찾기</a>
 	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/deposit.png" width="20" height="20">&nbsp;입금현황</a>
   	<br /><br />
 	&nbsp;&nbsp;&nbsp;&nbsp;
 	<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/option.png" width="20" height="20">&nbsp;설정</a>
</div>
<div id="content">
	<br /><br /><br />
	
	<table align="center"  width="800" height="200">
	<tr bgcolor="#FFFFFF">
	<td align="center">1 
	</td>
	</tr>
	<tr bgcolor="#FFFFFF">
	<td align="center">
	2 <br />
	</td>
	</tr>
	<tr bgcolor="#FFFFFF">
	<td align="center">
	3
	</td>
	</tr>
	</table>
	<br /> <br />
	<center>
 	<table align="center" border="1" cellspacing="0" bgcolor="#FFFFFF">



<tr><td width="200" rowspan="5" align="center">
<img src="/jsp/save/0876.jpg" width="200" height="300">   
</td>
</tr>

<tr height="30">
<td colspan="2"  align="center">카테고리</td>
<td colspan="2" align="center"> ${product.itemCateg}</td></tr>

<tr height="30">
<td colspan="2" align="center">판매가격</td>
<td colspan="2" width="300" align="center" >${product.itemPrice}원</td>
</tr>

<tr height="30">
<td colspan="4" align="center"><font color="black"><b>제품설명</b></font></td>
</tr>

<tr height="170">
<td colspan="4" align="center">${product.itemIntro}</td></tr>


<tr><td colspan="5" align="center">구매 개수:
<select name="orderNum">
<option>1</option>
<option>2</option>
<option>3</option>
<option>4</option>
<option>5</option>
<option>6</option>
<option>7</option>
<option>8</option>
<option>9</option>
<option>10</option>
</select>
</td></tr>

<tr align="center">
<td colspan="5" align="center">
<input type="hidden" name ="itemNum" value="${product.itemNum}">
<c:if test="${product.itemStock > 0}">      
<input type="submit" value="주문하기">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<c:if test="${product.itemStock <= 0}">
<input type="button" value="SOLD OUT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<input type="button" value="돌아가기" onClick="javascript:window.location='main.nhn'"></td>
</tr>

</table>
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	<table align="center" border="1" cellspacing="0" paddingspacing="1">



<tr><td width="200" rowspan="5" align="center">
<img src="/jsp/save/1.jpg" width="200" height="300">   
</td>
</tr>

<tr height="30">
<td colspan="2"  align="center">카테고리</td>
<td colspan="2" align="center"> ${product.itemCateg}</td></tr>

<tr height="30">
<td colspan="2" align="center">판매가격</td>
<td colspan="2" width="300" align="center" >${product.itemPrice}원</td>
</tr>

<tr height="30">
<td colspan="4" align="center"><font color="black"><b>제품설명</b></font></td>
</tr>

<tr height="170">
<td colspan="4" align="center">${product.itemIntro}</td></tr>


<tr><td colspan="5" align="center">구매 개수:
<select name="orderNum">
<option>1</option>
<option>2</option>
<option>3</option>
<option>4</option>
<option>5</option>
<option>6</option>
<option>7</option>
<option>8</option>
<option>9</option>
<option>10</option>
</select>
</td></tr>

<tr align="center">
<td colspan="5" align="center">
<input type="hidden" name ="itemNum" value="${product.itemNum}">
<c:if test="${product.itemStock > 0}">      
<input type="submit" value="주문하기">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<c:if test="${product.itemStock <= 0}">
<input type="button" value="SOLD OUT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<input type="button" value="돌아가기" onClick="javascript:window.location='main.nhn'"></td>
</tr>

</table>
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	<table align="center" border="1" cellspacing="0" paddingspacing="1">



<tr><td width="200" rowspan="5" align="center">
<img src="/jsp/save/11.jpg" width="200" height="300">   
</td>
</tr>

<tr height="30">
<td colspan="2"  align="center">카테고리</td>
<td colspan="2" align="center"> ${product.itemCateg}</td></tr>

<tr height="30">
<td colspan="2" align="center">판매가격</td>
<td colspan="2" width="300" align="center" >${product.itemPrice}원</td>
</tr>

<tr height="30">
<td colspan="4" align="center"><font color="black"><b>제품설명</b></font></td>
</tr>

<tr height="170">
<td colspan="4" align="center">${product.itemIntro}</td></tr>


<tr><td colspan="5" align="center">구매 개수:
<select name="orderNum">
<option>1</option>
<option>2</option>
<option>3</option>
<option>4</option>
<option>5</option>
<option>6</option>
<option>7</option>
<option>8</option>
<option>9</option>
<option>10</option>
</select>
</td></tr>

<tr align="center">
<td colspan="5" align="center">
<input type="hidden" name ="itemNum" value="${product.itemNum}">
<c:if test="${product.itemStock > 0}">      
<input type="submit" value="주문하기">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<c:if test="${product.itemStock <= 0}">
<input type="button" value="SOLD OUT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</c:if>
<input type="button" value="돌아가기" onClick="javascript:window.location='main.nhn'"></td>
</tr>

</table>
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	내용
 	</center>
 	
 	
 	
</div>


	
	
	<br /><br /><br />
	
	


</body>
</html>


