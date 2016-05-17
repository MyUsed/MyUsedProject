<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
a{text-decoration:none}
</style>

<body bgcolor="#06090F">



<br /> 




<form action="replesubmit.nhn" method="post" >


<input type="hidden" name="boardnum" value="${num}"/>
<input type="hidden" name="content" value="${content}"/>


<table align="right"  width="370" height="60"  bgcolor="#FFFFFF" >
<tr align="right">
<td>
<a href="MyUsed.nhn"><img src="/MyUsed/images/cancel.PNG" title="돌아가기"/></a>
</td>
</tr>
<tr>

<td style="padding:0 0 0 20px;" >
 <br/>
 
<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${mem_num}"> 
<img src="/MyUsed/images/default.jpg" width="40"  height="40"> </a>
<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${mem_num}"> 
<font size="3" color="#4565A1"><strong>${name}</strong></font>
</a> <br />
<font size="2" color="#9A9DA4">${time}</font>
 

 <br/> <br />
 
 
	
		
${content}  <br /><br />


</td>
	
</tr>

<tr >
<td  bgcolor="#F6F7F9">
	  <hr width="99%"  > 
좋아요 / 댓글 / 공유
	  <hr width="99%"  > 
</td>

</tr>
<tr>

<td style="padding:0 0 0 20px;" bgcolor="#F6F7F9" >	

<p style='overflow: auto; width: 370; height: 300'>
<c:forEach var="replelist" items="${replelist}"> 
<a  href="/MyUsed/MyUsedMyPage.nhn?mem_num=${replelist.mem_num}"> 
<font face="Comic Sans MS" size="3" color="#4565A1"> ${replelist.name} </font>
</a>
 ${replelist.content} <br/>
 <font size="2" color="#9A9DA4">${replelist.reg}</font>

<br />
</c:forEach>

</p>
</td>
</tr>
<tr>
<td  bgcolor="#F6F7F9">
<img  src="/MyUsed/images/default.jpg" width="35"  height="35"/> 
<input style="padding:7px;" type="text" name="reple" size="35" placeholder="댓글을 입력하세요..." />
<input type="image" src="/MyUsed/images/replesubmit.PNG" width="30" height="20" title="댓글달기"/>
</td>
</tr>




</table>

<table align="center" style="padding:10px;" width="800" height="625"  bgcolor="#000000" >
<tr align="center" >
<td>
<c:if test="${board_pic != null}">
<img src="/MyUsed/images/${board_pic}" />
</c:if>
</td>
</tr>
</table>


</form>

</body>