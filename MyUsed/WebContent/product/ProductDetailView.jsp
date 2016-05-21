<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/MyUsed/product/ProductView.css" />
<title>상품</title>

<style type="text/css">

#detailViewback { position:fixed; 
			width:100%; 
			height:600%;  
			margin-top:50px;
			background:#EAEAEA;
			filter:alpha(opacity=70); opacity:0.7; -moz-opacity:0.3;
			z-index:199; }

#detailView { position:fixed; 
			width:900px; 
			height:550px;
			margin-top:65px;
			margin-left:15%;
			text-align:center;
			background:#FFFFFF;
			border-radius:15px;
			box-shadow: 2px 2px 1px #A6A6A6;
			z-index:200; }
			
#detailimg { position:relative; 
			width:480px; 
			height:330px;
			margin-top:11px;
			margin-left:20px;
			border:1px solid #000000;
			z-index:200; }	
			
#detailimgs { position:relative; 
			width:480px; 
			height:160px;
			margin-top:10px;
			margin-left:20px;
			border:1px solid #000000;
			z-index:200; }	
			
#detailcontent { position:absolute;
			width:360px; 
			margin-top:-499px;
			margin-left:520px;
			border:1px solid #000000;
			z-index:200; }	
			
#closebotton{position:absolute; 
			width:30px; 
			height:30px;
			margin-top:10px;
			margin-left:860px;}
		

</style>

<script type="text/javascript">
$(document).ready(function(){	
    $("#close").click(function(){
        $('#body').detach();
        window.location.reload();
    });
  });
</script>

</head>
<body>


<div id="detailViewback">

</div>

<div id="detailView">
	<div id="closebotton">
		<label for="close">
			<img src="/MyUsed/images/close.png" width="30" height="30">
		</label>
    </div>
<%--     <a href="/MyUsed/MyUsedProductView.nhn?categ=${viewCateg.categ}"> --%>
   	<input type="button" id="close" style='display: none;'>
   	<br />
   	
   	<!-- 대표이미지 (추후 경로 수정)-->
   	<div id="detailimg">
   		<img src="/MyUsed/images/${productDTO.pro_pic}" width="478" height="328">
   	</div>
   	
   	<!-- 다른 이미지 -->
   	<div id="detailimgs">
   	<table border="1" width="480" height="160">
   		<tr>
   		<c:forEach begin="0" step="1" end="3" var="propic" items="${propicList}">
   			<td>
   				<img src="/MyUsed/images/${propic.pro_pic}" width="118" height="78">
   			</td>
   		</c:forEach>
   		</tr>
   	
   		<tr>
   		<c:forEach begin="4" step="1" end="7" var="propic" items="${propicList}">
   			<td>
   				<img src="/MyUsed/images/${propic.pro_pic}" width="118" height="78">
   			</td>
   		</c:forEach>
   		</tr>
   	</table>
    </div>
    
    <div id="detailcontent">
	<table align="right" width="360" height="497" border="1">
		<tr height="50" align="left">
			<td style="padding:0 0 0 10px;">
			<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${productDTO.mem_num}"> 
				<img src="/MyUsed/images/${profilepic}" width="40"  height="40"></a>
			<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${productDTO.mem_num}"> 
				<font size="3" color="#4565A1"><strong>${productDTO.name}</strong></font>
			</a>
				<font size="1">쪽지보내기</font>
			</td >
			<td align="right" style="padding:0 10px 0 0;">
			<font size="2" color="#9A9DA4">${productDTO.reg}</font>
			</td>
		</tr>
 		
		<tr>
			<td style="padding:0 0 0 20px;" colspan="2">
 			${productDTO.content} 
 			</td>
 		</tr>
 		
 		<tr height="30">
			<td align="left" style="padding:0 0 0 20px;" bgcolor="#F6F7F9" colspan="2">
				좋아요 / 댓글 / 공유
			</td>
		</tr>
		
		<tr>
			<td style="padding:0 0 0 20px;" bgcolor="#F6F7F9" colspan="2">	
				<p style='overflow: auto; width: 400; height: 330'>
				<c:forEach var="replelist" items="${replelist}"> 
					<a  href="/MyUsed/MyUsedMyPage.nhn?mem_num=${replelist.mem_num}"> 
						<font face="Comic Sans MS" size="3" color="#4565A1"> ${replelist.name} 댓글쓴이</font>
					</a>
 					${replelist.content} 댓글내용<br/>
 					<font size="2" color="#9A9DA4">${replelist.reg}</font>
					<br />
				</c:forEach>
				</p>
			</td>
		</tr>
		<tr height="50">
			<td  bgcolor="#F6F7F9" colspan="2">
				<img  src="/MyUsed/images/default.jpg" width="35"  height="35"/> 
					<input style="padding:7px;" type="text" name="reple" size="30" placeholder="댓글을 입력하세요..." />
				<input type="image" src="/MyUsed/images/replesubmit.PNG" width="30" height="20"/>
			</td>
		</tr>
	</table>
    </div>	
    
</div>



</body>
</html>