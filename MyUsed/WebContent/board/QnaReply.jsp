<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
Test.!!!!!
seq:${seq_num}:
ref:${qna_ref}:
<body>
<form action ="QnaReplyPro.nhn?qna_ref=${qna_ref}" method="post">
<input type="hidden" name="qna_num" value="${qna_num}">
<input type="hidden" name="qna_ref" value="${qna_ref}">
<input type="hidden" name="qna_re_step" value="${qna_re_step}">
<input type="hidden" name="qna_re_level" value="${qna_re_level}">

<table border="1">
	<tr>
		<td>ID</td>
		<td></td>
	</tr>
	<tr>	
		<td>����</td>
		<td>	
			<input type="text" name="title">
		</td>
	</tr>	
	<tr>
		<td>����</td>
		<td colspan="2"><textarea name="contents" cols="30" style="width:99%;"></textarea></td>
	</tr>
	<tr>
		<td>��й�ȣ</td>
		<td><input type="text"  name="pw"/>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="����"/>
			<input type="reset" value="�ٽ��ۼ�"/>
			<input type="button" value="�ڷ�" onclick="history.go(-1)"/>
		</td>	
	</tr>	
</table>
</form>
</body>
