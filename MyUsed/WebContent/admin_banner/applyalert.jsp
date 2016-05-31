<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<c:if test="${i == 1}">
<script>
	alert("접수 완료되었습니다.");
	location.href = "MyUsed.nhn";
</script>
</c:if>

<c:if test="${i == 2}">
<script>
	alert("메인에 등록 완료되었습니다.");
	location.href = "applyBanner.nhn";
</script>
</c:if>


<c:if test="${i == 3}">
<script>
	alert("삭제 완료되었습니다.");
	location.href = "deleteBanner.nhn";
</script>
</c:if>


<c:if test="${i == 4}">
<script>
	alert("메인 배너 수정 완료되었습니다.");
	location.href = "updateBanner.nhn";
</script>
</c:if>




</body>
</html>