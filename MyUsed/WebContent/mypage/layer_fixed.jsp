<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<form action="/MyUsed/MyUsedSearchMember.nhn" method="post">
	<table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
		<tr>
			<td style="vertical-align:left; padding-left: 30px; padding-right: 80px; ">
			<a href="/MyUsed/MyUsed.nhn">
			<img src="/MyUsed/images/Mlogo2.png" width="170"  height="50">
			</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
			<!-- ģ��ã�� -->
				<input type="text" size="70" name="member"/>
				<button type="submit"><img src="/MyUsed/images/Search.png" width="20"  height="20"></button>
			
			
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<img src="/MyUsed/images/profile/${sessionproDTO.profile_pic}" width="30"  height="30">
				
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${memDTO.num}" onmouseover="this.style.textDecoration='none'"><font color="#F6F6F6">${memDTO.name} |</font></a> 
				<a href="/MyUsed/MyUsed.nhn" onmouseover="this.style.textDecoration='none'"><font color="#F6F6F6">Ȩ |</font></a>
				<label for="callfriend"><font color="#F6F6F6" style="font-weight:lighter; cursor:pointer;">ģ��ã��</font></label>
				<input type="button" id="callfriend" onclick="javascript:callHomefriend('${num}')" style="display:none;">
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<!-- ģ���˸�  -->
				<label for="friend">
				<img src="/MyUsed/images/mainFriend.png" width="45"  height="40" title="ģ��" style="cursor:pointer;"></a>
				</label>
				<input type="button" id="friend" OnClick="javascript:openMsg()" style='display: none;'>
				
				<a href="paperMain.nhn?mynum=${num}"><img src="/MyUsed/images/mainMessage.png" width="40"  height="35" title="ä��"></a>
				
				<!-- ���� �˸�  -->
				<label for="msg">
					<img src="/MyUsed/images/mainView.png" width="40" height="35" title="�˸�" style="cursor:pointer;">
				</label>
				<input type="button" id="msg" OnClick="javascript:" style='display: none;'>
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!-- ���� �̹����� �ٲٱ�(���̽���ó�� ��Ӵٿ�޴���) -->
				<c:if test="${sessionScope.memId != null }">
					<a href="/MyUsed/MyUsedLogout.nhn" onmouseover="this.style.textDecoration='none'"><font color="#F6F6F6">�α׾ƿ�</font></a>
				</c:if>
			</td>
			
		</tr>
	</table>
	</form>