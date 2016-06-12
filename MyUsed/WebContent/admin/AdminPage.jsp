<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> ������ ������ </title>
<link rel="stylesheet" type="text/css" href="/MyUsed/admin/admin.css" />

</head>
<body>
	
<!---------------------- �۾��Ҷ� 2���� include �ؼ� ��� ------------------------------->
<div id="AdminTop"><jsp:include page="AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->


<div id="board"> <!-- �Խ��� �������� -->
<b>��������</b> <a href="admin_notice.nhn"><font size="2">������</font></a>
<table border="1" width="550" height="130" style="border:2px double #747474; border-collapse:collapse;">

	<c:forEach var="admin_Notice" items="${admin_Notice}" begin="0" end="4">
	<tr>
	<td width="70">��������</td>
	<td width="350"> ${admin_Notice.title} </td>
	<td width="110" align="center">
	<c:if test="${fn:length(admin_Notice.reg) > 11}">
	${fn:substring(admin_Notice.reg,0,10)}
	</c:if>
	</td>
	</tr>
	</c:forEach>

</table>
</div>

<div id="call">  <!-- ó����û �Ǽ� -->
<b>�Խñ� ���</b>
<table border="1" width="250" height="130" style="border:2px double #747474; border-collapse:collapse;">
	<tr>
	<td bgcolor="#EAEAEA" width="150">�� �Խñ�</td><td align="right"><b><font color="red">${total_board} ��</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">�Ű����� �Խñ�</td><td align="right"><b><font color="red">0 ��</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">��� 1000�� �̻�</td><td align="right"><b><font color="red">${board_reples} ��</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">���ƿ� 1000�� �̻�</td><td align="right"><b><font color="red">${board_likes} ��</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">���� ������Ʈ</td><td align="right"><b><font color="red">0 ��</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">�ֱ� ������ ���ε�</td><td align="right"><b><font color="red">0 ��</font></b></td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="150">�ֱ� �Ѵ� ���ε�</td><td align="right"><b><font color="red">0 ��</font></b></td>
	</tr>
	
</table>
</div>



<div id="info"> <!-- ȸ������ ��Ż  -->
<b>ȸ�� ���</b> <a href="MyUsedMemTotal.nhn"><font size="2">������</font></a>
<table border="1" width="250" height="130" style="border:2px double #747474; border-collapse:collapse;">
	<tr>
	<td bgcolor="#EAEAEA" width="130">�� ȸ����</td><td align="right"><b>${total_mem}</b> ��</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">������ ȸ��</td><td align="right"><b>${mem_login}</b> ��</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">�Ű����� ȸ��</td><td align="right"><b>${mem_report}</b> ��</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">�Ϲ� ȸ��</td><td align="right"><b>${nomal_mem}</b> ��</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">���̹� ȸ��</td><td align="right"><b>${naver_mem}</b> ��</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">30�� ȸ��</td><td align="right"><b>0</b> ��</td>
	</tr>
	<tr>
	<td bgcolor="#EAEAEA" width="130">40�� �̻�</td><td align="right"><b>0</b> ��</td>
	</tr>
</table>
</div>





<div id="trade"> <!-- �ŷ� ��Ȳ -->
	
	<div id="trade_1"> <center><br/> <b>�ŷ���û</b> <br/> <br/><b><font color="red">${trade_all} ��</font></b></center></div> 
	
	<div id="trade_2"> 
	<center><br/><b>�Աݻ���</b><br/><font size="2">�ԱݿϷ�</font> <b><font color="red">${trade_deposit} ��</font></b><br/>
	<font size="2">�۱ݿϷ�</font> <b><font color="red">${trade_finish} ��</font></b></center>
	</div>
	
	<div id="trade_3"> <center> <b>�����</b> <br/><b><font color="red">${trade_send} ��</font></b></center></div>
	<div id="trade_4"> <center> <b>��ۿϷ�</b> <br/><b><font color="red">${trade_finish} ��</font></b></center></div>
	<div id="trade_5"> <center><br/> <b>�ŷ��Ϸ�</b> <br/> <br/><b><font color="red">${trade_finish} ��</font></b></center></div>
	
	
	<div id="arrow_1"><center> �� ��</center></div>
	<div id="arrow_2"><center> �� ��</center></div>
	<div id="arrow_3"><center> �� ��</center></div>
	
	
</div>



<div id="state"> <!-- ������� -->
	<b>�ŷ� ����� ����</b>
	<br/><br/><br/><br/> <center> <input type="button" value="   ��ȸ   "/> </center>
</div>

<div id="product"> <!-- ��ǰ��Ȳ -->
	<b>��ǰ ��Ȳ</b><br/>
	<table border="1" width="250" height="160" style="border:2px double #747474; border-collapse:collapse;">
		<tr>
		<td bgcolor="#EAEAEA" width="150">�� ��ǰ�Ǹű�</td><td align="right"><b><font color="red">${total_pro} ��</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">�ŷ����� ��ǰ</td><td align="right"><b><font color="red">${trade_all} ��</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">�ŷ��Ϸ� ��ǰ</td><td align="right"><b><font color="red">${trade_finish} ��</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">�ŷ� ��û�� ��ǰ</td><td align="right"><b><font color="red">${trade_all} ��</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">�ŷ� ��ҵ� ��ǰ</td><td align="right"><b><font color="red">0 ��</font></b></td>
		</tr>
	</table>
</div>

<div id="advertice"> <!-- ������Ȳ -->
	<b>���� ��Ȳ</b> <a href="applyBanner.nhn"><font size="2">������</font></a>
	<table border="1" width="250" height="160" style="border:2px double #747474; border-collapse:collapse;">
		<tr>
		<td bgcolor="#EAEAEA" width="150">�� �����û ��</td><td align="right"><b><font color="red">${total_banner} ��</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">���� �ɻ� ���</td><td align="right"><b><font color="red">${banner_pass} ��</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">���� �ɻ� Ż��</td><td align="right"><b><font color="red">${banner_fail} ��</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">�������� ����</td><td align="right"><b><font color="red">${banner_pass} ��</font></b></td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">��ϵ� ���� ��</td><td align="right"><b><font color="red">1 ��</font></b></td>
		</tr>
	</table>
</div>

<div id="money"> <!-- �α���Ȳ -->
	<b>���� ��Ȳ</b>
	<table border="1" width="250" height="160" style="border:2px double #747474; border-collapse:collapse;">
		<tr>
		<td bgcolor="#EAEAEA" width="100">�̴� �� ����</td><td align="right"><b>3.243.000</b> ��</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="100">���� �� ����</td><td align="right"><b>0</b> ��</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="100">����</td><td align="right"><b>0</b> ��</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="100">����</td><td align="right"><b>0</b> ��</td>
		</tr>
	</table>
</div>

<div id="member"> <!-- ���� -->
	<b>���� ����</b> <a href="AdminMember.nhn"><font size="2">�����Ϸ�����</font></a><br>
	<table border="1" width="250" height="160" style="border:2px double #747474; border-collapse:collapse;">
		<tr>
		<td bgcolor="#EAEAEA" width="150">�� ���� ��</td><td align="right"><b>${total_adminMem}</b> ��</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">����</td><td align="right"><b>${adminMem_Team1}</b> ��</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">����</td><td align="right"><b>${adminMem_Team2}</b> ��</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">�븮</td><td align="right"><b>${adminMem_Team3}</b> ��</td>
		</tr>
		<tr>
		<td bgcolor="#EAEAEA" width="150">���</td><td align="right"><b>${adminMem_Team4}</b> ��</td>
		</tr>
	</table>
</div>






</body>
</html>