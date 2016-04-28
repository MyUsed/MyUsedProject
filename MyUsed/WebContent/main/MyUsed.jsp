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
			background-color:#4c6396;
		}
	</style>
</head>

<body>
	<div id="layer_fixed">
		<table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
		<tr>
			<td style="vertical-align:left; padding-left: 20px; padding-right: 20px;">
			<font size="6"><img src="/jsp/project/images/MyUsed.PNG" border="0"  height="30"></font>
			</td>
			<td style="vertical-align:right; padding-left: 500px; padding-left: 0px;">
				<input type="text" size="50"/>
				<button type="submit" class="btn btn-success">Search</button>
			</td>
			
		</tr>
		</table>
	</div>



<style type="text/css">
#sidebannerR { position:fixed; top:50px; left:50%; margin-left:500px; width:200px; height:500px; background:#BDBDBD; }
#sidebannerL { position:fixed; top:50px; right:50%; margin-right:500px; width:200px; height:500px; background:#BDBDBD; }
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
    <center>
 	<font size="5">사이드고정L</font>
   	</center>
</div>
<div id="content">
	<br /><br /><br />
	<br /><br /><br />
	<br /><br /><br />
	
	<center>
 	<table align="center" border="1" cellspacing="0" paddingspacing="1">



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


