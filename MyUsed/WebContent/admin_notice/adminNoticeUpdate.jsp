<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${sessionScope.adminId == null}">
	<script type="text/javascript">
		alert("������ �����ϴ�.");
		history.go(-1);
	</script>
</c:if>


<c:if test="${sessionScope.adminId != null}">
	<script type="text/javascript">
		alert("�Խù� ������ �Ϸ�Ǿ����ϴ�.");
		window.location="admin_notice.nhn";
	</script>
</c:if>