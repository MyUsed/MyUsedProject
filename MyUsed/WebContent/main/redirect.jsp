<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- ´ñ±Û´Þ±â -->
<script type="text/javascript">
	
	if('${page}' == 0){
		window.location="MyUsed.nhn"; 
	}else{
		window.location="MyUsedMyPage.nhn?mem_num=${mem_num}"; 
	}
</script>
