<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="/MyUsed/main/animate.js"></script>
<script src="/MyUsed/main/script.js"></script>



	<script type="text/javascript">
		function confirm(){
			if(confirm("�����Ͻðڽ��ϱ�?") == true){
				
			}
			else{
				return false;
			}
		}
	</script>

<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- ��� �˻� Top -->
<div id="sidebannerR"><jsp:include page="/mypage/friendList.jsp"/></div><!-- ���̵��� Right  -->
<div id="advertise" ><jsp:include page="/main/advertise.jsp"/></div>  <!-- ���� ������  -->
<div id="sidebannerL"><jsp:include page="/main/sidebannerL.jsp" /></div> <!-- ���̵��� Left -->


<div id="contents">
<br/><br/><br/>
<c:if test="${count > 0}">
	<c:forEach var="list" items="${list}">	
		<form name="reple" action="reple.nhn" method="post" >
		 	<table align="center"  width="550" height="180">
		 	
				<tr	bgcolor="#FFFFFF">
					<td>
						<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${list.mem_num}">( ${list.mem_name} )</a> 
						<font face="Comic Sans MS" size="2" color="#A6A6A6" > ���� �Խñ��� ���Ͽ����ϴ�. </font>
						<a href="choiceDelete.nhn?c_no=${list.c_no}&mynum=${mynum}" onclick="confirm()">
							<img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 1em;" width="20" height="20" align="right" title="�Խñ� ����"/>
						</a>
						<hr width="100%" > 
					</td>
				</tr>
				
				<tr  bgcolor="#FFFFFF">
					<td align="center">
						<c:if test="${list.pro_pic != null}">
							<a href="choiceDetail.nhn?c_no=${list.c_no}&mynum=${mynum}">
								<img src="/MyUsed/images/${list.pro_pic}" width="470" height="300"/>
							</a>
					 		<br/> <br />
						</c:if>
						
						<font size="3" color="#1F51B7" ><b><fmt:formatNumber value="${list.price}" type="number" />��</b></font> <br /><br />
						<font size="3" color="#D7D2FF" >
		����������������������������<font size="3" color="#A6A6A6" face="Comic Sans MS"> Detail </font>����������������������������
						</font>
			 			<br/>
						${list.content}
					</td>
				</tr>
				
				<tr bgcolor="#FFFFFF">
					<td>
						<hr width="100%"  > 
						
					</td>
				</tr>
					
				<tr bgcolor="#FFFFFF">
					<td>
					</td>
				</tr>
			
			</table>
		</form>
	</c:forEach>
</c:if>
	
<c:if test="${count < 1}">
	<br/><br/><br/><br/><br/><br/><br/><center>���� �Խù��� �����ϴ�.</center>
</c:if>

</div>