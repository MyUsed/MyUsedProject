<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="/MyUsed/main/script.js"></script>
<script src="/MyUsed/main/animate.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<title>${content} 검색결과</title>
</head>
<body>



<div id="layer_fixed"><jsp:include page="layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->
<div id="sidebannerR"><jsp:include page="sidebannerR.jsp"/></div> <!-- 사이드배너 Right  -->
<div id="advertise" ><jsp:include page="advertise.jsp"/></div>  <!-- 광고 페이지  -->
<div id="sidebannerL"><jsp:include page="sidebannerL.jsp"/></div> <!-- 사이드배너 Left -->
<div id="contents">
 <!-------------------------------- 메인 내용 ------------------------------------------>
	<br /><br /><br />
	


<!--  상품 보기 페이지  -->	



<form name="reple" action="reple.nhn" method="post" >

	
<c:forEach var="list" items="${list}">	
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${list.mem_num}"><font face="Comic Sans MS">( ${list.name} )</font></a>
		<font face="Comic Sans MS" size="2" color="#A6A6A6" > 님이 글을 게시하였습니다</font>  
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:if test="${list.mem_num == memDTO.num}">
		<a href="delete.nhn?num=${list.num}"><img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 1em;" width="20" height="20" align="right" title="게시글 삭제"/></a>
		</c:if>
		<hr width="100%" > 
		</td>
		</tr>
		
		<tr  bgcolor="#FFFFFF">
		<td align="center">
		<c:if test="${list.mem_pic != null}">
		<a href="reple.nhn?num=${list.num}">
		<img src="/MyUsed/images/${list.mem_pic}" width="470" height="300"/>
		</a>
		 <br/> <br />
		</c:if>
		<!-- 일반 게시글 해시태그 -->	
	<script type="text/javascript">
	$(document).ready(function(){
		var content = document.getElementById('listcontent_${list.num}').innerHTML;
		var splitedArray = content.split(' ');
		var linkedContent = '';
		for(var word in splitedArray)
		{
		  word = splitedArray[word];
		   if(word.indexOf('#') == 0)
		   {
				var url = '"'+'/MyUsed/tegSearch.nhn?word='+word.split('#')+'"';
			    word = '<a href='+url+'>'+word+'</a>';
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('listcontent_${list.num}').innerHTML = ' '+linkedContent; 
	});
	</script>
		
		
		<div id="listcontent_${list.num}">
		${list.content}
		</div>
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"  > 
		
		좋아요  / 공유하기 / <a href="reple.nhn?num=${list.num}"><img src="/MyUsed/images/replego.PNG"/></a>
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		
		
		
		</td>
		</tr>
		

	</table>
</c:forEach>

</form>


</div>

<br /><br />




</body>
</html>