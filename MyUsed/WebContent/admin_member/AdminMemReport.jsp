<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/member/jquery-1.11.3.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	 $("#sBtn").click(function(){
		 sortSearch();
	 });
	 function sortSearch(){
	        $.ajax({
	            type: "post",
	            url : "/MyUsed/MyUsedMemReport_index.nhn",
	            data: {	// url �������� ������ �Ķ����
	            	sort : $("#categ").val(),
	            	word : $("#search").val()
	            },
	            success: sort,	// ��������û ������ ���� �Լ�
	            error: sortError	//��������û ���н� �����Լ�
	     	});
	    }
	    function sort(list){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
			$("#report").attr('style', 'display:block;');
	    	$('#reportAll').attr('style', 'display:none;');
	        $("#report").html(list);
	        console.log(resdata);
	    }
	    function sortError(){
	        alert("sortError");
	    }
	$("#allBtn").click(function() {//��ü 
			location.reload();
		});

	
	
	$("#reason").change(function() {
		sortReason();
	});
		function sortReason() {
			$.ajax({
				type : "post",
				url : "/MyUsed/MyUsedMemReport_reason.nhn",
				data : { // url �������� ������ �Ķ����
					re_num : $("#reason").val()
				},
				success : sortreason, // ��������û ������ ���� �Լ�
				error : sortreasonError
			//��������û ���н� �����Լ�
			});
		}
		function sortreason(list) { // ��û������ ������������ aaa ������ �ݹ�ȴ�. 
			$("#report").attr('style', 'display:block;');
			$('#reportAll').attr('style', 'display:none;');
			$("#report").html(list);
			console.log(resdata);
		}
		function sortreasonError() {
			alert("sortreasonError");
		}

	});
</script>
	 	

<title> ������ ������ </title>
</head>
<body>
	
<!---------------------- �۾��Ҷ� 2���� include �ؼ� ��� ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->
<center>
<h2>* �Ű� ���� ���� *</h2>



<table border="0" width="800">
	<tr>
		<td width="5%" align="right">
			<select id="categ" name="categ">
				<option value="null">---�з�---</option>
				<option value="mem_num">ȸ����ȣ</option>
				<option value="name">�̸�</option>
			</select>
		</td>
		<td width="15%" a align="left">
			<input type="text" id="search" style="width:110px;" placeholder="�˻���">
		</td>
		<td width="5%" align="left">
			<input type="button" id="sBtn" value="�˻�">
		</td>
		<td width="70%" align="left">
			<input type="button" id="allBtn" value="��ü">
		</td>
		<td width="5%" align="right">
			<select id="reason" name="reason">
				<option value="null">-------------------------����-------------------------</option>
				<c:forEach var="reason" items="${reasonList}">
					<option value="${reason.re_num}">${reason.re_reason}</option>
				</c:forEach>
					<option value="0">��Ÿ</option>
			</select>
		</td>
	</tr>
</table>

<div id="reportAll" style="display:block;">
<table border="1" align="center" width="800">
	<tr>
		<td align="center" width="10%"  bgcolor="#D9E5FF"><b>ȸ����ȣ</b></td>
		<td align="center" width="15%" bgcolor="#D9E5FF"><b>�̸�</b></td>
		<td align="center" width="60%" bgcolor="#D9E5FF"><b>����</b></td>
		<td align="center" width="15%" bgcolor="#D9E5FF"><b>��¥</b></td>
	</tr>
	
	<c:forEach var="report" items="${reportList}">
	<tr>
		<td align="center">${report.mem_num}</td>
		<td align="center">${report.name}</td>
		<td align="center">${report.reason}</td>
		<td align="center"><fmt:formatDate value="${report.reg}" type="date" /></td>
	</tr>
	</c:forEach>
</table>
</div>


<div id="report" style="display:none;"></div>



</center>
</body>
</html>