<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/main/jquery-1.11.3.js"></script>
<script src="/MyUsed/main/modal.js"></script>

<style type="text/css">
a{text-decoration:none}
figure,figcaption,img{ display:block; }
.modal_gallery li{ list-style:none; float:left; width:150px; margin:3px;}
.modal_gallery li img{ width:100%; cursor:pointer;}
</style>

</head>
<body>
 
<table align="center" style="padding:10px;" width="800" height="625"  bgcolor="#000000" >
	<tr align="center" >
		<td>
			<c:if test="${board_pic != null}">
				<img src="/MyUsed/images/${board_pic}" />
			</c:if>
		</td>
	</tr>
	<tr align="center">
		<td>
		<div class="modal_gallery">
  			<ul>
				<c:forEach var="piclist" items="${piclist}"> 
					<li><img src="/MyUsed/images/${piclist.mem_pic}" width="50" height="90" alt="${piclist.name} 님의 사진입니다"/></li>
				</c:forEach>
  			</ul>
		</div>
		</td>
	</tr>
</table>



</body>
</html>