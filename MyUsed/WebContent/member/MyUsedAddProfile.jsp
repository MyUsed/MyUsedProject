<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />

<title>������ �߰�</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<script type="text/javascript">
function callAjax(){
    $.ajax({
	        type: "post",
	        url : "/MyUsed/MyUsedAddProfile2.nhn",
	        data: {	// url �������� ������ �Ķ����
	        	/* num : num.value, */
	        },
	        success: successRequest,	// ��������û ������ ���� �Լ�
	        error: whenError	//��������û ���н� �����Լ�
 	});
}
function successRequest(aaa){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
    $("#body2").html(aaa);
    console.log(resdata);
}
function whenError(){
    alert("Error");
}
/** �Ķ���� �ѱ涧 callAjax�ٲٱ� */
</script>

<style type="text/css">
#layer_fixed{
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
#body { position:absolute; top:50px; width:100%; height:700px; background:#FFFFFF; }
/* #body2 { position:absolute; top:50px; width:100%; height:700px; z-index:100; } */

#index { position:absolute; 
	top:30px; 
	width:50%; 
	height:80px;
	margin-left:25%;
	background:#EAEAEA; }
	
#box { position:absolute; 
	top:140px; 
	width:50%; 
	height:500px;
	margin-left:25%;
	border-top:solid 2px #BDBDBD;
	background:#EAEAEA; }
		
</style>


</head>

<body>

<div id="layer_fixed">
<form action="/MyUsed/MyUsedSearchMember.nhn" method="post">
	<table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
		<tr>
			<td style="vertical-align:left; padding-left: 30px; padding-right: 80px;">
			<a href="/MyUsed/MyUsed.nhn">
			<img src="/MyUsed/images/Mlogo2.png" width="170"  height="50">
			</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
			<!-- ģ��ã�� -->
				<input type="text" size="70" name="member"/>
				<button type="submit"><img src="/MyUsed/images/Search.png" width="20"  height="20"></button>
			
			
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<img src="/MyUsed/images/profile/${sessionproDTO.profile_pic}" width="15"  height="15">
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${memDTO.num}">${memDTO.name}</a> | 
				<a href="/MyUsed/MyUsed.nhn">Ȩ</a> | 
				<a href="/MyUsed/MyUsed.nhn">ģ��ã��</a>
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainFriend.png" width="45"  height="40"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainMessage.png" width="40"  height="35"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainView.png" width="40"  height="35"></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!-- ���� �̹����� �ٲٱ�(���̽���ó�� ��Ӵٿ�޴���) -->
				<c:if test="${sessionScope.memId != null }">
					<a href="/MyUsed/MyUsedLogout.nhn">�α׾ƿ�</a>
				</c:if>
			</td>
			
		</tr>
	</table>
	</form>
</div>

<div id="body2"></div>		
		
<div id="body">
	<div id="index">
		<table width="100%" height="100%">
			<tr>
				<td width="20%" style="padding:0 0 0 20px; border-right:solid 4px #FFFFFF;" bgcolor="#4c6396">
					<font size="4" color="#FFFFFF"><b>1�ܰ�</b></font>
					<br />
					<font size="2" color="#FFFFFF"><b>����������</b></font>
				</td>
				<td width="20%" style="padding:0 0 0 20px; border-right:solid 4px #FFFFFF;">
					<font size="4" color="#000000"><b>2�ܰ�</b></font>
					<br />
					<font size="2" color="#000000"><b>���ɻ缱��</b></font>
				</td>
				<td width="20%" style="padding:0 0 0 20px; border-right:solid 4px #FFFFFF;">
					<font size="4" color="#000000"><b>3�ܰ�</b></font>
					<br />
					<font size="2" color="#000000"><b>�����ʻ���</b></font>
				</td>
				<td width="40%">
					&nbsp;
				</td>
			</tr>
		</table>
	</div>
	
	<div id="box">
		<br />
		<table border="0" width="85%" height="15%" align="center">
			<tr>
				<td colspan="2">
					<font size="4" color="#000000"><b>������ ���� �Է�</b></font>
					<br />
					�� ������ MyUsed�� ������ ȸ������ ģ���� ã�µ� ������ �˴ϴ�.
				</td>
			</tr>
		</table>
		
		<form id="form1">
		<table border="0" width="85%" height="70%" align="center">
			<tr height="40">
				<td colspan="2">
					&nbsp;
				</td>
			</tr>
			<c:forEach var="friendCateg" items="${friendCateg}">
			<tr height="35">
				<td align="right" width="30%">
					<b>${friendCateg.categ}</b>&nbsp;&nbsp;
				</td>
				<td align="left" width="70%">
					&nbsp;
					<%-- �������� ī�װ��� name���ϴ°� �����غ��� --%>
					<input type="text" name="categ" id="categ" style="width:250px;">
				</td>
			</tr>
			</c:forEach>
			<tr valign="bottom">
				<td align="left">
					���ڷ�
				</td>
				<td align="right">
					�ǳʶٱ�&nbsp;
					<input type="button" id="button" value="���� �� ���" onclick="callAjax()">
				</td>
			</tr>		
		</table>
		</form>
		
	</div>



</div>

</body>

	
