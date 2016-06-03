<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>

<c:if test="${sessionScope.adminId == null }">
	<script type="text/javascript">
		alert("권한이 없습니다.");
		history.go(-1);
	</script>
</c:if>

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript">
	    $(document).ready(function(){
	    	window.setInterval('boardRepleAjax()', 5000); //5초마다한번씩 함수를 실행한다..!! 
	    });
	    function boardRepleAjax(){
	    	 $.ajax({
	 	        type: "post",
	 	        url : "admin_boardRepleCount.nhn?num=${bdto.num}&like=${like}",
	 	        success: boardReple,	// 페이지요청 성공시 실행 함수
	 	        error: boardError	//페이지요청 실패시 실행함수
	      	});
	    }
	    function boardReple(board){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
	        $("#ajaxboardReple").html(board);
	    }
	    function boardError(){
	        alert("boardError");
	    }
	</script>

<script type="text/javascript">
	function boardRepleOpen(){
		var url = "admin_boardReple.nhn?num=${bdto.num}";
		window.open(url, "chat", "width=600, height=400, left=500, top=100 ,resizable=yes, location=no, status=no, toolbar=no, menubar=no");
	}
</script>

<br/><br/>
<c:if test="${sessionScope.adminId != null }">
	<table align="center"  width="550" height="180" bgcolor="#FFFFFF">
		<tr>
			<td>
				<hr width="100%" > 
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${bdto.mem_num}" target="_blank"><font face="Comic Sans MS">( ${bdto.name} )</font></a>
				<font face="Comic Sans MS" size="2" color="#A6A6A6" > 님의 게시글 입니다. </font>  
				<a href="admin_boardDelete.nhn?num=${bdto.num}"><img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 1em;" width="20" height="20" align="right" title="게시글 삭제"/></a>
				<hr width="100%" > 
			</td>
		</tr>
		
		<tr>
			<td align="center">
				<a href="reple.nhn?num=${bdto.num}">
					<img src="/MyUsed/images/${bdto.mem_pic}" width="470" height="300"/>
				</a>
			</td>
		</tr>
		
		<tr>
			<td></td>
		</tr>
		
		<tr>
			<td align="center">
				${bdto.content}
				<hr width="100%"> 
			</td>
		</tr>

		<tr>
			<td>
				<div id="ajaxboardReple">좋아요 ${like}개 / 댓글 <a href="javasciprt:;" onclick="boardRepleOpen(${bdto.num})">${repleCount}</a>개</div>
				<hr width="100%"> 
			</td>
		</tr>
		
		<tr>
			<td align="center">
				<input type="button" value="뒤로가기" onclick="history.go(-1)">
			</td>
		</tr>
	</table>
</c:if>