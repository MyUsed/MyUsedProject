<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<script src="/MyUsed/member/jquery-1.11.3.js"></script>
<script src="/MyUsed/member/animate.js"></script>

<script type="text/javascript">

/* 메뉴 마우스 오버시 색상 변경 */
function mOver1(){
	document.getElementById("profile").style.background="#EAEAEA";
}
function mOut1(){
	document.getElementById("profile").style.background="#FFFFFF";
}

function mOver2(){
	document.getElementById("cover").style.background="#EAEAEA";
}
function mOut2(){
	document.getElementById("cover").style.background="#FFFFFF";
}

function mOver3(){
	document.getElementById("state").style.background="#EAEAEA";
}
function mOut3(){
	document.getElementById("state").style.background="#FFFFFF";
}

function mOver4(){
	document.getElementById("product").style.background="#EAEAEA";
}
function mOut4(){
	document.getElementById("product").style.background="#FFFFFF";
}

/* 탭 끄고 켜기 */
function viewprofile(){
	$("#profilepic").attr('style', 'display:block;');
	$("#coverpic").attr('style', 'display:none;');
	$("#statepic").attr('style', 'display:none;');
	$("#productpic").attr('style', 'display:none;');
}
function viewcover(){
	$("#profilepic").attr('style', 'display:none;');
	$("#coverpic").attr('style', 'display:block;');
	$("#statepic").attr('style', 'display:none;');
	$("#productpic").attr('style', 'display:none;');
}
function viewstate(){
	$("#profilepic").attr('style', 'display:none;');
	$("#coverpic").attr('style', 'display:none;');
	$("#statepic").attr('style', 'display:block;');
	$("#productpic").attr('style', 'display:none;');
}
function viewproduct(){
	$("#profilepic").attr('style', 'display:none;');
	$("#coverpic").attr('style', 'display:none;');
	$("#statepic").attr('style', 'display:none;');
	$("#productpic").attr('style', 'display:block;');
}


/* 프로필 사진 크게보기 */
function bigPic1(pic) {
    URL = "/MyUsed/images/profile/"+pic;
    $('#viewPic1 img').attr('style', 'display:block;');
    $('#viewPic1 img').attr('src', URL);
    $('#viewPic1').slideDown(); //업로드한 이미지 미리보기 
    $(this).slideUp(); //파일 양식 감춤
}

function closePic1() {
    $('#viewPic1 img').slideUp(); //미리 보기 영역 감춤
}

/* 커버 사진 크게보기 */
function bigPic2(pic) {
    URL = "/MyUsed/images/cover/"+pic;
    $('#viewPic2 img').attr('style', 'display:block;');
    $('#viewPic2 img').attr('src', URL);
    $('#viewPic2').slideDown(); //업로드한 이미지 미리보기 
    $(this).slideUp(); //파일 양식 감춤
}

function closePic2() {
    $('#viewPic2 img').slideUp(); //미리 보기 영역 감춤
}

/* 일반/상품 사진 크게보기 */
function bigPic3(pic) {
    URL = "/MyUsed/images/"+pic;
    $('#viewPic3 img').attr('style', 'display:block;');
    $('#viewPic3 img').attr('src', URL);
    $('#viewPic3').slideDown(); //업로드한 이미지 미리보기 
    $(this).slideUp(); //파일 양식 감춤
}

function closePic3() {
    $('#viewPic3 img').slideUp(); //미리 보기 영역 감춤
}
</script>


<style type="text/css">

#header1{height:80px; border-bottom:1px solid #d9d9d9;}
.header_wrap1{width:1100px; margin:0 auto;}
.header_wrap1 h1{float:left; margin:27px 0;}
.nav1{float:right; text-align:center;}
.gnb1>li{ float:left; width:80px; height:80px; list-style:none;}
.sub1{position:relative; background:#fff;  margin-top:10px; }
.sub1>li{height:30px; margin-left:-41px; list-style:none; }

#profile{position:absolute; width:55px; height:25px; left:46%; margin-top:-4px; 
border:1px solid #EAEAEA; text-align:center; padding-top:1px; cursor:pointer;}
#cover{position:absolute; width:55px; height:25px; left:50%; margin-top:-4px;
 border:1px solid #EAEAEA; text-align:center; padding-top:1px; cursor:pointer;}
#state{position:absolute; width:55px; height:25px; left:54%; margin-top:-4px; 
border:1px solid #EAEAEA; text-align:center; padding-top:1px; cursor:pointer;}
#product{position:absolute; width:55px; height:25px; left:58%; margin-top:-4px; 
border:1px solid #EAEAEA; text-align:center; padding-top:1px; cursor:pointer;}


</style>

</head>


<div style="margin-top:0px; width:90%; height:5px; margin-left:5%; background-color:#EAEAEA;"></div>
<div style="margin-top:50px; width:90%; height:auto; margin-left:5%; background-color:#FFFFFF;">
<br />


<font style="font-size:140%; font-weight:bold;">
&nbsp;&nbsp;사진
</font>

<div id="profile" onmouseover="mOver1()" onmouseout="mOut1()" onclick="viewprofile()">
프로필</div>

<div id="cover" onmouseover="mOver2()" onmouseout="mOut2()" onclick="viewcover()">
커버</div>

<div id="state" onmouseover="mOver3()" onmouseout="mOut3()" onclick="viewstate()">
상태</div>

<div id="product" onmouseover="mOver4()" onmouseout="mOut4()" onclick="viewproduct()">
상품</div>


<hr width="100%">


<table border="0" width="100%" align="center" bgcolor="#FFFFFF">
<tr><td>

<div id="viewPic1" style="position:absolute; width:568px; margin-left:30px; display:none;">
	<img src="/MyUsed/images/profile/" width="100%" height="100%" onclick="closePic1()">
</div>
<div id="viewPic2" style="position:absolute; width:568px; margin-left:30px; display:none;">
	<img src="/MyUsed/images/profile/" width="100%" height="100%" onclick="closePic2()">
</div>
<div id="viewPic3" style="position:absolute; width:568px; margin-left:30px; display:none;">
	<img src="/MyUsed/images/" width="100%" height="100%" onclick="closePic3()">
</div>


<!-------------- 프로필 사진 ---------------------->
<div id="profilepic"  style="display:block;">
<table align="center">
	<tr height="142">
		<c:forEach var="profile" items="${profileList}" begin="0" end="3">
			<td width="142" align="center">
				<img src="/MyUsed/images/profile/${profile.profile_pic}" width="140" height="140" onclick="bigPic1('${profile.profile_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="profile" items="${profileList}" begin="4" end="7">
			<td width="142" align="center">
				<img src="/MyUsed/images/profile/${profile.profile_pic}" width="140" height="140" onclick="bigPic1('${profile.profile_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="profile" items="${profileList}" begin="8" end="11">
			<td width="142" align="center">
				<img src="/MyUsed/images/profile/${profile.profile_pic}" width="140" height="140" onclick="bigPic1('${profile.profile_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="profile" items="${profileList}" begin="12" end="15">
			<td width="142" align="center">
				<img src="/MyUsed/images/profile/${profile.profile_pic}" width="140" height="140" onclick="bigPic1('${profile.profile_pic}')">
			</td>
		</c:forEach>
	</tr>
</table>
</div>

<!-------------- 커버 사진 ---------------------->

<div id="coverpic"  style="display:none;">
<table align="center">
	<tr height="142">
		<c:forEach var="cover" items="${coverList}" begin="0" end="3">
			<td width="142" align="center">
				<img src="/MyUsed/images/cover/${cover.cover_pic}" width="140" height="140" onclick="bigPic2('${cover.cover_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="cover" items="${coverList}" begin="4" end="7">
			<td width="142" align="center">
				<img src="/MyUsed/images/cover/${cover.cover_pic}" width="140" height="140" onclick="bigPic2('${cover.cover_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="cover" items="${coverList}" begin="8" end="11">
			<td width="142" align="center">
				<img src="/MyUsed/images/cover/${cover.cover_pic}" width="140" height="140" onclick="bigPic2('${cover.cover_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="cover" items="${coverList}" begin="12" end="15">
			<td width="142" align="center">
				<img src="/MyUsed/images/cover/${cover.cover_pic}" width="140" height="140" onclick="bigPic2('${cover.cover_pic}')">
			</td>
		</c:forEach>
	</tr>
</table>
</div>

<!-------------- 일반 사진 ---------------------->
<div id="statepic"  style="display:none;">
<table align="center">
	<tr height="142">
		<c:forEach var="state" items="${stateList}" begin="0" end="3">
			<td width="142" align="center">
				<img src="/MyUsed/images/${state.mem_pic}" width="140" height="140" onclick="bigPic3('${state.mem_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="state" items="${stateList}" begin="4" end="7">
			<td width="142" align="center">
				<img src="/MyUsed/images/${state.mem_pic}" width="140" height="140" onclick="bigPic3('${state.mem_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="state" items="${stateList}" begin="8" end="11">
			<td width="142" align="center">
				<img src="/MyUsed/images/${state.mem_pic}" width="140" height="140" onclick="bigPic3('${state.mem_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="state" items="${stateList}" begin="12" end="15">
			<td width="142" align="center">
				<img src="/MyUsed/images/${state.mem_pic}" width="140" height="140" onclick="bigPic3('${state.mem_pic}')">
			</td>
		</c:forEach>
	</tr>
</table>
</div>


<!-------------- 상품 사진 ---------------------->
<div id="productpic"  style="display:none;">
<table align="center">
	<tr height="142">
		<c:forEach var="product" items="${productList}" begin="0" end="3">
			<td width="142" align="center">
				<img src="/MyUsed/images/${product.pro_pic}" width="140" height="140" onclick="bigPic3('${product.pro_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="product" items="${productList}" begin="4" end="7">
			<td width="142" align="center">
				<img src="/MyUsed/images/${product.pro_pic}" width="140" height="140" onclick="bigPic3('${product.pro_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="product" items="${productList}" begin="8" end="11">
			<td width="142" align="center">
				<img src="/MyUsed/images/${product.pro_pic}" width="140" height="140" onclick="bigPic3('${product.pro_pic}')">
			</td>
		</c:forEach>
	</tr>
	
	<tr height="142">
		<c:forEach var="product" items="${productList}" begin="12" end="15">
			<td width="142" align="center">
				<img src="/MyUsed/images/${product.pro_pic}" width="140" height="140" onclick="bigPic3('${product.pro_pic}')">
			</td>
		</c:forEach>
	</tr>
</table>
</div>






</td></tr>
</table>



<br /><br />

</div>