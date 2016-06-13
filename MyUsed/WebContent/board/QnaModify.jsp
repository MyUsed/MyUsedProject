<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>QNA_Board</title>
</head>
<body>
	<h1>QNA 게시판</h1>
	<form action="/MyUsed/QnamodifyPro.nhn" method="post">
	<table border="1" style="width:500px;">
		<tr>
			<td>번호</td><td>${contents.seq_num}</td>
			<td>ID</td><td>${contents.mem_id}</td>
		</tr>
		<tr>
			<td colspan="1">제목</td><td><input type="text" name="title" value="${contents.title}"/></td>
			<td>조회수</td><td>${contents.count}</td>
		</tr>
		<tr>	
			<td colspan="4" align="center">내용 </td>
		</tr>
		<tr>	
			<td colspan="4"><textarea name="contents" cols="30" style="width:99%; value="${contents.contents}"></textarea></td>	
		</tr>
	</table>
	<input type="submit" value="저장"/>
	<input type="reset" value="다시작성"/>
	<input type="button" value="뒤로" onclick="history.go(-1)"/>
	</form>
</body>
</html>