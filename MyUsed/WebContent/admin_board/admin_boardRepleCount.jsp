<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<script type="text/javascript">
	function boardRepleOpen(){
		var url = "admin_boardReple.nhn?num=${bdto.num}";
		window.open(url, "chat", "width=600, height=400, left=500, top=100 ,resizable=yes, location=no, status=no, toolbar=no, menubar=no");
	}
</script>
���ƿ� ${like}�� / ��� <a href="javasciprt:;" onclick="boardRepleOpen(${bdto.num})">${repleCount}</a>��