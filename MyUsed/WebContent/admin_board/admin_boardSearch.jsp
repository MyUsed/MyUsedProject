<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.adminId == null }">
	<script type="text/javascript">
		alert("권한이 없습니다.");
		history.go(-1);
	</script>
</c:if>

<!------------------------------------- boardlist ------------------------------------->
<br/>
<c:if test="${sessionScope.adminId != null }">
		<table align="center">
			<c:if test="${radio == 'board'}">
				<c:if test="${boardcount > 0}">
					
					<tr>
						<td colspan="6" align="center"><b>총 게시글 수:${boardcount}</b></td>
					</tr>
					
					<tr align="center" bgcolor="#7EB1FF">
						<td>글번호</td>
						<td>회원아이디</td>
						<td>회원이름</td>
						<td>좋아요수</td>
						<td>댓글수</td>
						<td>게시한시간</td>
					</tr>
					
				<c:forEach var="boardlist" items="${boardlist}">
					<tr align="center" bgcolor="#D5D5D5">
						<td><a href="admin_boardView.nhn?b_num=${boardlist.num}&like=${boardlist.likes}">${boardlist.num}</a></td>
						<td>${memid}</td>
						<td>${boardlist.name}</td>
						<td>${boardlist.likes}</td>
						<td>${boardlist.reples}</td>
						<td>${boardlist.reg}</td>
					</tr>
				</c:forEach>
				
				<tr>
					<td colspan="6" align="center">${pagingHtml}</td>
				</tr>
			</c:if>
<!--------------------- 게시물이 존재하지 않을 때 --------------------->	
				<c:if test="${boardcount < 1}">		
					<table align="center">
						<tr>
							<td align="center"><font color="red">게시글이 존재하지 않습니다.</font></td>
						</tr>
					</table>
				</c:if>
<!--------------------- 게시물이 존재하지 않을 때 --------------------->	
			</c:if>
<!------------------------------------- boardlist ------------------------------------->
	
	
			
<!------------------------------------- proboardlist ------------------------------------->	
			<c:if test="${radio == 'proboard'}">
				<c:if test="${procount > 0}">
					<tr>
						<td colspan="8" align="center"><b>총 게시글 수:${procount}</b></td>
					</tr>
				
					<tr align="center" bgcolor="#7EB1FF">
						<td>글번호</td>
						<td>회원아이디</td>
						<td>회원이름</td>
						<td>카테고리</td>
						<td>좋아요수</td>
						<td>댓글수</td>
						<td>가격</td>
						<td>게시한시간</td>
					</tr>
					
				<c:forEach var="prolist" items="${prolist}">
					<tr align="center" bgcolor="#D5D5D5">
						<td><a href="admin_proboardView.nhn?pro_num=${prolist.num}&like=${prolist.likes}">${prolist.num}</a></td>
						<td>${memid}</td>
						<td>${prolist.name}</td>
						<td>${prolist.categ}</td>
						<td>${prolist.likes}</td>
						<td>${prolist.reples}</td>
						<td>${prolist.price}</td>
						<td>${prolist.reg}</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="8" align="center">${pagingHtml}</td>
				</tr>
			</c:if>
			
<!--------------------- 게시물이 존재하지 않을 때 --------------------->	
			<c:if test="${procount < 1}">		
				<table align="center">
					<tr>
						<td align="center"><font color="red">게시글이 존재하지 않습니다.</font></td>
					</tr>
				</table>
			</c:if>
<!--------------------- 게시물이 존재하지 않을 때 --------------------->					
			</c:if>
		</table>
</c:if> 
<!------------------------------------- proboardlist ------------------------------------->	