<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>

<c:if test="${sessionScope.adminId == null }">
	<script type="text/javascript">
		alert("������ �����ϴ�.");
		history.go(-1);
	</script>
</c:if>

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript">
	    $(document).ready(function(){
	    	window.setInterval('boardRepleAjax()', 5000); //5�ʸ����ѹ��� �Լ��� �����Ѵ�..!! 
	    });
	    function boardRepleAjax(){
	    	 $.ajax({
	 	        type: "post",
	 	        url : "admin_boardRepleCount.nhn?num=${bdto.num}&like=${like}",
	 	        success: boardReple,	// ��������û ������ ���� �Լ�
	 	        error: boardError	//��������û ���н� �����Լ�
	      	});
	    }
	    function boardReple(board){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
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
				<font face="Comic Sans MS" size="2" color="#A6A6A6" > ���� �Խñ� �Դϴ�. </font>  
				<a href="admin_boardDelete.nhn?num=${bdto.num}"><img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 1em;" width="20" height="20" align="right" title="�Խñ� ����"/></a>
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
				<div id="ajaxboardReple">���ƿ� ${like}�� / ��� <a href="javasciprt:;" onclick="boardRepleOpen(${bdto.num})">${repleCount}</a>��</div>
				<hr width="100%"> 
			</td>
		</tr>
		
		<tr>
			<td align="center">
				<input type="button" value="�ڷΰ���" onclick="history.go(-1)">
			</td>
		</tr>
	</table>
</c:if>