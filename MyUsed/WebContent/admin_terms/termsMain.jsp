<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>

<c:if test="${sessionScope.adminId == null}">
	<script type="text/javascript">
		alert("권한이 없습니다");
		history.go(-1);
	</script>
</c:if>

<script type="text/javascript">
	function termsConfirm(seq_num){
		if(confirm("삭제하시겠습니까?") == true){
			window.location="admin_termsDelete.nhn?seq_num="+seq_num;
		}
		else{
			return;
		}
	}
</script>

<c:if test="${sessionScope.adminId != null}">
<center>	
	<c:if test="${count > 0}">
	<br/><br/>
	<h3>약관</h3>
	<hr width="500">
		<form method="post" action="admin_termsUpdateForm.nhn">
				<table>			
					<tr align="center">
						<td>MyUsed 이용약관 동의</td>
						<td>개인정보 수집 및 이용에 대한 안내</td>
						<td>위치정보 이용약관 동의</td>
					</tr>
						
					<tr>
						<td><textarea rows="20" cols="40" name="content1" readonly="readonly">${Tdto.content1}</textarea></td>
						<td><textarea rows="20" cols="40" name="content2" readonly="readonly">${Tdto.content2}</textarea></td>
						<td><textarea rows="20" cols="40" name="content3" readonly="readonly">${Tdto.content3}</textarea></td>
						<td><input type="hidden" name="seq_num" value="${Tdto.seq_num}"/></td>
					</tr>
					
					<tr><td></td></tr>
					
					<tr align="center">
						<td colspan="3">
							<input type="button" value="약관작성" onclick="javascript:window.location='admin_termsWrite.nhn'"/>&nbsp&nbsp
							<input type="submit" value="수정하기"/>&nbsp&nbsp
							<input type="button" value="삭제" onclick="termsConfirm('${Tdto.seq_num}')"/>
						</td>
					</tr>
				</table>
		</form>
	</c:if>
		<c:if test="${count < 1}">
				<table>
				<br/><br/><br/><br/><br/><br/><br/>
					<tr>
						<td>
							<font color="red"><b>작성된 약관이 없습니다.</b></font>
						</td>
					</tr>
					
					<tr align="center">
							<td colspan="3">
								<input type="button" value="약관작성" onclick="javascript:window.location='admin_termsWrite.nhn'"/>
							</td>
					</tr>
				</table>
		</c:if>
	</center>
	
	
</c:if>