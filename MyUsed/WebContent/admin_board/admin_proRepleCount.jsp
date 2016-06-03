<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<script type="text/javascript">
	function proRepleOpen(){
		var url = "admin_proboardReple.nhn?num=${pdto.num}";
		window.open(url, "chat", "width=600, height=400, left=500, top=100 ,resizable=yes, location=no, status=no, toolbar=no, menubar=no");
	}
</script>
좋아요 ${like}개 / 댓글 <a href="javasciprt:;" onclick="proRepleOpen(${pdto.num})">${repleCount}</a>개