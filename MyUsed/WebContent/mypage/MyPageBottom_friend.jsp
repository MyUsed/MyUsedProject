<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/mypage/MyPage.css" />

<script src="/MyUsed/member/jquery-1.11.3.js"></script>
<script src="/MyUsed/member/animate.js"></script>
<body>

<!-- ģ�� -->


<c:if test="${mem_num == mynum}">
	<div id="knewpeople">
		<div id="knewpeopletitle">
			�� �� �� �ִ� ģ��
			<div id="line">
				<hr>
			</div>
		</div>
		
		<div id="knewpeopleindex">
		<table>
			<tr height="115" align="center">
				<c:forEach var="knewFriendList_image" items="${knewFriendList_image}" begin="0" end="5" >
				<td width="130">
					<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${knewFriendList_image.mem_num}">
					<img src="/MyUsed/images/profile/${knewFriendList_image.profile_pic}" width="110" height="110">
					</a>
				</td>
				</c:forEach>
			</tr>
			<tr height="22" align="center">
			<c:forEach var="knewFriend" items="${knewFriendList}" begin="0" end="5" >
				<td width="130">
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${knewFriend.mem_num}">
					${knewFriend.name}
				</a>
				</td>
			</c:forEach>
			</tr>
		</table>
		</div>
	</div>
</c:if>

<div id="friendlist_all">
	<div id="friendlist_title">
		��ϵ� ģ��
		<div id="friendlist_line">
			<hr>
		</div>
	</div>
	
	<c:if test="${friendpicList == null}">	
	<div id="friendlist_index">
		��ϵ� ģ���� �����ϴ�. <br />
		<c:if test="${mem_num == mynum}">
			�� �� ���ִ� ģ���� ã�ƺ�����! <br />
			ģ��ã��
		</c:if>
		<c:if test="${mem_num != mynum}">
			${name}���� �Ƽ���? <br />
			ģ���� ����Ͻðڽ��ϱ�?
			<!-- ���� ģ���� �ƴ� ��츸 -->
		</c:if>
	</div>
	</c:if>
	
	<c:if test="${friendpicList != null}">
	<div id="friendlist_index">
		<br />
		<table border="0" width="100%" align="center">
			<tr height="100">
			<c:forEach var="friendpic" items="${friendpicList}" begin="0" end="1">
				<td width="45%">
					<div style="width:100%; height:100px; border:1px solid #A6A6A6;">
						<div style="width:100px; height:100px; margin-left:0px;">
							<img src="/MyUsed/images/profile/${friendpic.profile_pic}" style="width:98%; height:98%; cursor:pointer;" onclick="location.href='/MyUsed/MyUsedMyPage.nhn?mem_num=${friendpic.mem_num}'">
						</div>
						<div style="width:100px; height:100px; margin-top:-100px; margin-left:120px; padding-top:30px;">
							<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${friendpic.mem_num}"><font style="font-size:120%; font-weight:bold;">
							${friendpic.name}
							</font></a>
							<br />
							<font style="font-size:90%;">${friendpic.categ}</font>
						</div>
						
						<div style="width:100px; height:100px; margin-top:-100px; margin-left:240px; padding-top:35px; text-align:center">
							<nav class="nav">
								<ul class="gnb">
									<li ><a href="#"><font color="#223C6F" >ģ�� ��</font></a>
										<ul class="sub" style="width:120px; box-shadow:1px 1px 1px #BDBDBD;">
	      									<li><a onclick="deleteFriend('${friendpic.mem_num}')">ģ�� ����</a></li>
            								<li><a onclick="modifyFriendCateg('${friendpic.mem_num}')">ī�װ� ����</a></li>
            								<li><a href="/MyUsed/MyUsed.nhn">���� ������</a></li>
        								</ul>
    								</li>
    							</ul>
    						</nav>
						</div>
					</div>
				</td>
				<td width="10%">&nbsp;</td>
			</c:forEach>	
			</tr>
			<tr height="30"><td colspan="3">&nbsp;</td></tr>
			
			<tr height="100">
			<c:forEach var="friendpic" items="${friendpicList}" begin="2" end="3">
				<td width="45%">
					<div style="width:100%; height:100px; border:1px solid #A6A6A6;">
						<div style="width:100px; height:100px; margin-left:0px;">
							<img src="/MyUsed/images/profile/${friendpic.profile_pic}" style="width:98%; height:98%; cursor:pointer;" onclick="location.href='/MyUsed/MyUsedMyPage.nhn?mem_num=${friendpic.mem_num}'">
						</div>
						<div style="width:100px; height:100px; margin-top:-100px; margin-left:120px; padding-top:30px;">
							<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${friendpic.mem_num}"><font style="font-size:120%; font-weight:bold;">
							${friendpic.name}
							</font></a>
							<br />
							<font style="font-size:90%;">${friendpic.categ}</font>
						</div>
						
						<div style="width:100px; height:100px; margin-top:-100px; margin-left:240px; padding-top:35px; text-align:center">
							<nav class="nav">
								<ul class="gnb">
									<li ><a href="#"><font color="#223C6F" >ģ�� ��</font></a>
										<ul class="sub" style="width:120px; box-shadow:1px 1px 1px #BDBDBD;">
	      									<li><a onclick="deleteFriend('${friendpic.mem_num}')">ģ�� ����</a></li>
            								<li><a href="/MyUsed/MyUsed.nhn">ī�װ� ����</a></li>
            								<li><a href="/MyUsed/MyUsed.nhn">���� ������</a></li>
        								</ul>
    								</li>
    							</ul>
    						</nav>
						</div>
					</div>
				</td>
				<td width="10%">&nbsp;</td>
			</c:forEach>	
			</tr>
			<tr height="30"><td colspan="3">&nbsp;</td></tr>
			
			<tr height="100">
			<c:forEach var="friendpic" items="${friendpicList}" begin="4" end="5">
				<td width="45%">
					<div style="width:100%; height:100px; border:1px solid #A6A6A6;">
						<div style="width:100px; height:100px; margin-left:0px;">
							<img src="/MyUsed/images/profile/${friendpic.profile_pic}" style="width:98%; height:98%; cursor:pointer;" onclick="location.href='/MyUsed/MyUsedMyPage.nhn?mem_num=${friendpic.mem_num}'">
						</div>
						<div style="width:100px; height:100px; margin-top:-100px; margin-left:120px; padding-top:30px;">
							<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${friendpic.mem_num}"><font style="font-size:120%; font-weight:bold;">
							${friendpic.name}
							</font></a>
							<br />
							<font style="font-size:90%;">${friendpic.categ}</font>
						</div>
						
						<div style="width:100px; height:100px; margin-top:-100px; margin-left:240px; padding-top:35px; text-align:center">
							<nav class="nav">
								<ul class="gnb">
									<li ><a href="#"><font color="#223C6F" >ģ�� ��</font></a>
										<ul class="sub" style="width:120px; box-shadow:1px 1px 1px #BDBDBD;">
	      									<li><a onclick="deleteFriend('${friendpic.mem_num}')">ģ�� ����</a></li>
            								<li><a href="/MyUsed/MyUsed.nhn">ī�װ� ����</a></li>
            								<li><a href="/MyUsed/MyUsed.nhn">���� ������</a></li>
        								</ul>
    								</li>
    							</ul>
    						</nav>
						</div>
					</div>
				</td>
				<td width="10%">&nbsp;</td>
			</c:forEach>	
			</tr>
			<tr height="30"><td colspan="3">&nbsp;</td></tr>
			
			<tr height="100">
			<c:forEach var="friendpic" items="${friendpicList}" begin="6" end="7">
				<td width="45%">
					<div style="width:100%; height:100px; border:1px solid #A6A6A6;">
						<div style="width:100px; height:100px; margin-left:0px;">
							<img src="/MyUsed/images/profile/${friendpic.profile_pic}" style="width:98%; height:98%; cursor:pointer;" onclick="location.href='/MyUsed/MyUsedMyPage.nhn?mem_num=${friendpic.mem_num}'">
						</div>
						<div style="width:100px; height:100px; margin-top:-100px; margin-left:120px; padding-top:30px;">
							<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${friendpic.mem_num}"><font style="font-size:120%; font-weight:bold;">
							${friendpic.name}
							</font></a>
							<br />
							<font style="font-size:90%;">${friendpic.categ}</font>
						</div>
						
						<div style="width:100px; height:100px; margin-top:-100px; margin-left:240px; padding-top:35px; text-align:center">
							<nav class="nav">
								<ul class="gnb">
									<li ><a href="#"><font color="#223C6F" >ģ�� ��</font></a>
										<ul class="sub" style="width:120px; box-shadow:1px 1px 1px #BDBDBD;">
	      									<li><a onclick="deleteFriend('${friendpic.mem_num}')">ģ�� ����</a></li>
            								<li><a href="/MyUsed/MyUsed.nhn">ī�װ� ����</a></li>
            								<li><a href="/MyUsed/MyUsed.nhn">���� ������</a></li>
        								</ul>
    								</li>
    							</ul>
    						</nav>
						</div>
					</div>
				</td>
				<td width="10%">&nbsp;</td>
			</c:forEach>	
			</tr>
			<tr height="30"><td colspan="3">&nbsp;</td></tr>
	
		</table>
	
	
	</div>
	</c:if>
	


</div>



</body>
</html>