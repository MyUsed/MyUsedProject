<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${sessionScope.adminId == null}">
	<script type="text/javascript">
		alert("권한이 없습니다.");
		history.go(-1);
	</script>
</c:if>


<c:if test="${sessionScope.adminId != null}">
	<script type="text/javascript">
		alert("게시물 수정이 완료되었습니다.");
		window.location="admin_notice.nhn";
	</script>
</c:if>