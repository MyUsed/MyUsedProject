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

	/*���ΰ�ħ*/
	$("#reload").click(function(){ 
		location.reload();
	});
	
	/* �з��� �˻� */
	 $("#sBtn").click(function(){
		 searchMember();
	    });
	    function searchMember(){
	        $.ajax({
	            type: "post",
	            url : "/MyUsed/MyUsedSearchMem.nhn",
	            data: {	// url �������� ������ �Ķ����
	            	categ : $("#categ").val(),
	            	word : $("#word").val()
	            },
	            success: search,	// ��������û ������ ���� �Լ�
	            error: searchError	//��������û ���н� �����Լ�
	     	});
	    }
	    function search(list){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
	        $("#query").html(list);
	        console.log(resdata);
	    }
	    function searchError(){
	        alert("searchError");
	    }
	    
	/* ��޺� */
	$("#grade").change(function() {
			searchgrade();
		});
		function searchgrade() {
			$.ajax({
				type : "post",
				url : "/MyUsed/MyUsedGrade.nhn",
				data : { // url �������� ������ �Ķ����
					grade : $("#grade").val()
				},
				success : grade, // ��������û ������ ���� �Լ�
				error : gradeError
			//��������û ���н� �����Լ�
			});
		}
		function grade(list) { // ��û������ ������������ aaa ������ �ݹ�ȴ�. 
			$("#query").html(list);
			console.log(resdata);
		}
		function gradeError() {
			alert("gradeError");
		}

		/* ����Ʈ */
		$("#point").change(function() {
			pointSort();
		});
		function pointSort() {
			$.ajax({
				type : "post",
				url : "/MyUsed/MyUsedPoint.nhn",
				data : { // url �������� ������ �Ķ����
					point : $("#point").val()
				},
				success : point, // ��������û ������ ���� �Լ�
				error : pointError
			//��������û ���н� �����Լ�
			});
		}
		function point(list) { // ��û������ ������������ aaa ������ �ݹ�ȴ�. 
			$("#query").html(list);
			console.log(resdata);
		}
		function pointError() {
			alert("pointError");
		}
		
	/* ���̹� */
	$("#naver").change(function() {
		naverMem();
	});
	function naverMem() {
		$.ajax({
			type : "post",
			url : "/MyUsed/MyUsedNaver.nhn",
			data : { // url �������� ������ �Ķ����
				naverid : $("#naver").val()
			},
			success : naver, // ��������û ������ ���� �Լ�
			error : naverError
		//��������û ���н� �����Լ�
		});
	}
	function naver(list) { // ��û������ ������������ aaa ������ �ݹ�ȴ�. 
		$("#query").html(list);
		console.log(resdata);
	}
	function naverError() {
		alert("naverError");
	}

/* ���ӱ��� */
$("#onoff").change(function() {
	onoffMem();
});
function onoffMem() {
	$.ajax({
		type : "post",
		url : "/MyUsed/MyUsedOnoff.nhn",
		data : { // url �������� ������ �Ķ����
			onoff : $("#onoff").val()
		},
		success : onoff, // ��������û ������ ���� �Լ�
		error : onoffError
	//��������û ���н� �����Լ�
	});
}
function onoff(list) { // ��û������ ������������ aaa ������ �ݹ�ȴ�. 
	$("#query").html(list);
	console.log(resdata);
}
function onoffError() {
	alert("onoffError");
}


/* �������� */
$("#gender").change(function() {
	genderSort();
});
function genderSort() {
	$.ajax({
		type : "post",
		url : "/MyUsed/MyUsedGender.nhn",
		data : { // url �������� ������ �Ķ����
			gender : $("#gender").val()
		},
		success : gender, // ��������û ������ ���� �Լ�
		error : genderError
	//��������û ���н� �����Լ�
	});
}
function gender(list) { // ��û������ ������������ aaa ������ �ݹ�ȴ�. 
	$("#query").html(list);
	console.log(resdata);
}
function genderError() {
	alert("genderError");
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
<h2>* ȸ�� ���� ��Ż *</h2>

<table border="0" width="800" bgcolor="#EAEAEA" style="border:2px double #747474;">
	<tr>
		<td colspan="6">
			<select id="categ" name="categ">
				<option value="null">---�з�---</option>
				<option value="num">ȸ����ȣ</option>
				<option value="id">�ƾƵ�</option>
				<option value="name">�̸�</option>
			</select>
			<input type="text" id="word" style="width:200px;" placeholder="�˻���">
			<input type="button" value="�˻�" id="sBtn">
		</td>
	</tr>
	<tr>
		<td align="center">
			<select id="grade" name="grade" style="width:126px;">
				<option value="null">---��޺�---</option>
				<c:forEach var="i" begin="1" end="5">
					<option value="${i}">${i}���</option>
				</c:forEach>
			</select>
			
			<select id="point" name="point" style="width:126px;">
				<option value="null">---����Ʈ---</option>
				<option value="desc">��������</option>
				<option value="asc">��������</option>
			</select>

			<select id="naver" name="naver" style="width:126px;">
				<option value="null">---ȸ������---</option>
				<option value="0">�Ϲ�ȸ��</option>
				<option value="1">���̹�ȸ��</option>
			</select>

			<select id="onoff" name="onoff" style="width:126px;">
				<option value="null">---���ӱ���---</option>
				<option value="1">����ȸ��</option>
				<option value="0">������ȸ��</option>
			</select>

			<select id="gender" name="gender" style="width:126px;">
				<option value="null">---��������---</option>
				<option value="M">����</option>
				<option value="F">����</option>
				<option value="U">��Ÿ</option>
			</select>

			<input type="button" id="reload" value="���ΰ�ħ" style="width:115px;">
		</td>
	</tr>
</table>


<div id="memDetail" style="display:none"></div>
<div id="query"></div>







</center>
</body>
</html>