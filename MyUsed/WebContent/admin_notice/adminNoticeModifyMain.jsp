<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>

<c:if test="${sessionScope.adminId == null}">
	<script type="text/javascript">
		alert("권한이 없습니다.");
		history.go(-1);
	</script>
</c:if>

<script type="text/javascript">
	function Nconfirm(seq_num){
		if(confirm("삭제하시겠습니까?") == true){
			window.location="admin_noticeDelete.nhn?seq_num="+seq_num;
		}
		else{
			return;
		}
	}
</script>

<c:if test="${sessionScope.adminId != null}">
<center><br/>
<h2>공지사항 수정</h2>
	<table>
		<tr align="center" bgcolor="#7EB1FF">
			<td>글 번호</td>
			<td>글 제목</td>
			<td>글 삭제</td>
		</tr>
		
		<c:forEach var="list" items="${list}">
			<tr align="center" bgcolor="#D5D5D5">
				<td>
					${list.seq_num}
				</td>
				
				<td>
					<a href="admin_noticeModify.nhn?seq_num=${list.seq_num}">
						<!-- list.content의 길이가 15보다 크면 14번째 자리 + ... 로 출력 -->
				   		<c:if test="${fn:length(list.title) > 14}">
				    		${fn:substring(list.title,0,13)}... 
				    	</c:if>
				    	
						<!-- list.content의 길이가 15보다 작으면 정상적으로 출력 -->
						<c:if test="${fn:length(list.title) < 14}">
					 		${list.title}
						</c:if>	    		
					</a>
				</td>
				
				<td>
					<input type="button" value="삭제" onclick="Nconfirm(${list.seq_num})"/>
				</td>
			</tr>
		</c:forEach>
	</table>
</center>
</c:if>