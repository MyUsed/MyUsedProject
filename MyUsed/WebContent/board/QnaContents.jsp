<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>QNA_Board</title>
</head>
<body>
	<h1>QNA 게시판</h1>
	<table border="1" style="width:500px;">
		<tr>
			<td>번호</td><td>${contents.seq_num}</td>
			<td>ID</td><td>${contents.mem_id}</td>
		</tr>
		<tr>
			<td colspan="1">제목</td><td>${contents.title}</td>
			<td>조회수</td><td>${contents.readcount}</td>
		</tr>
		<tr>	
			<td align="center"colspan="4">내용 </td>
		</tr>
		<tr>	
			<td colspan="4">${contents.contents}</td>	
		</tr>
		<c:if test="${count!=0 }">
		<c:forEach var="list" items="${list}">	
		<tr>
			<td>번호</td><td>${list.reply_num}</td><td>${list.reg }</td>
		</tr>
		<tr>
			<td>내용</td><td colspan="3">${list.reply_cts}</td>
		</tr>
		</c:forEach>
		</c:if>
</table>
<input type="button" value="댓글달기"onclick="location.href='/MyUsed/QnaReply.nhn?qna_ref=${contents.qna_ref}'"/>
<input type="button" value="뒤로" onclick="location.href='/MyUsed/Qna.nhn'"/>
<input type="button" value="수정" onclick="location.href='/MyUsed/QnaModify.nhn?seq_num=${contents.seq_num}'"/>
<input type="button" value="삭제" onclick="location.href='/MyUsed/QnaDelete.nhn?seq_num=${contents.seq_num}'"/>

</body>
</html>