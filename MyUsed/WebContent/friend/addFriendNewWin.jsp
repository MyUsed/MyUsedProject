<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />
<head>
<title>ģ�� ���
</title>
</head>
<body>

<div style="width:100%; height:100%; text-align:center; padding-top:8%;">

<form action="/MyUsed/AddFriendPro.nhn" method="get">
	<font size="3"><b>
	<a onclick="window.open('/MyUsed/MyUsedMyPage.nhn?mem_num=${frimemDTO.num}')" style="cursor:pointer;">
	${frimemDTO.name}</a>
	���� ģ���� ����Ͻðڽ��ϱ�?</b></font>
	<br />
	<font color="#A6A6A6">�˸��� ī�װ��� �����ϼ���.</font>
	<br /><br />
	<select name="categ" style="width:120px;">
		<c:forEach var="friendCateg" items="${friendCateg}">
			<option>${friendCateg.categ}</option>
        </c:forEach>
    </select>
	<br/><br />
	<input type="hidden" value="${mem_num}" name="mem_num">
	<input type="submit" value="���" style="width:70px;" class="btn btn-success">&nbsp;&nbsp;
	<input type="submit" value="���" style="width:70px;" onclick="self.close()"  class="btn btn-success">
</form>
</div>

</body>
</html>