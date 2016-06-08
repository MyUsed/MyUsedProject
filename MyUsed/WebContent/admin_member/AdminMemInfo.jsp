<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/member/jquery-1.11.3.js"></script>

<script type="text/javascript">
$(document).ready(function(){		//onload�̺�Ʈ������(�������ڸ��� �ٷ� ����)
    $("#categ0").change(function(){
    	if($("#categ0").val() == 0){
    		$("#categ1").attr('style', 'display:none');
    		$("#categ1_1").attr('style', 'display:block');
    		$("#categ1_2").attr('style', 'display:none');
    	}else if($("#categ0").val() == 1){
    		$("#categ1").attr('style', 'display:none');
    		$("#categ1_2").attr('style', 'display:block');
    		$("#categ1_1").attr('style', 'display:none');
    	}else {
    		$("#categ1").attr('style', 'display:block');
    		$("#categ1_2").attr('style', 'display:none');
    		$("#categ1_1").attr('style', 'display:none');
    	}
    });
    
    $("#categ1").change(function(){//��ü 
		location.reload();
    });

    $("#categ1_1").change(function(){
    	sortType();
    });
    function sortType(){
        $.ajax({
            type: "post",
            url : "/MyUsed/MyUsedMemInfo_index.nhn",
            data: {	// url �������� ������ �Ķ����
            	sort : 'type',
            	categ : $("#categ1_1").val()
            },
            success: sort,	// ��������û ������ ���� �Լ�
            error: sortError	//��������û ���н� �����Լ�
     	});
    }
    
    $("#categ1_2").change(function(){
    	sortState();
    });
    function sortState(){
        $.ajax({
            type: "post",
            url : "/MyUsed/MyUsedMemInfo_index.nhn",
            data: {	// url �������� ������ �Ķ����
            	sort : 'state',
            	categ : $("#categ1_2").val()
            },
            success: sort,	// ��������û ������ ���� �Լ�
            error: sortError	//��������û ���н� �����Լ�
     	});
    }
    function sort(list){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
		$("#sort").attr('style', 'display:block;');
    	$('#sortAll').attr('style', 'display:none;');
        $("#sort").html(list);
        console.log(resdata);
    }
    function sortError(){
        alert("sortError");
    }
    
    $("#sBtn").click(function(){
    	searchMem();
    });
    function searchMem(){
        $.ajax({
            type: "post",
            url : "/MyUsed/MyUsedMemInfo_searchmem.nhn",
            data: {	// url �������� ������ �Ķ����
            	mem_num : $("#search").val()
            },
            success: search,	// ��������û ������ ���� �Լ�
            error: searchError	//��������û ���н� �����Լ�
     	});
    }
    function search(list){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
		$("#sort").attr('style', 'display:block;');
    	$('#sortAll').attr('style', 'display:none;');
		$("#allBtn").attr('style', 'display:block;');
        $("#sort").html(list);
        console.log(resdata);
    }
    function searchError(){
        alert("searchError");
    }

    $("#allBtn").click(function(){ 
		location.reload();
    });
    
    
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
<h2>* �������� ���� ��û ��� *</h2>

<table border="0" width="800">
	<tr>
		<td width="15%" a align="left">
			<input type="text" id="search" style="width:110px;" placeholder="ȸ����ȣ">
		</td>
		<td width="5%" align="left">
			<input type="button" id="sBtn" value="�˻�">
		</td>
		<td width="70%" align="left">
			<input type="button" id="allBtn" value="��ü" style="display:none">
		</td>
		<td width="5%" align="right">
			<select id="categ0" name="categ0">
				<option value="null">---�з�1---</option>
				<option value="0">Ÿ��</option>
				<option value="1">ó��</option>
				<option value="2">��ü</option>
			</select>
		</td>
		<td width="5%" align="right">
			<select id="categ1">
				<option value="null">---�з�2---</option>
				<option value="all">��ü</option>
			</select>
			
			<select id="categ1_1" name="categ1_1" style="display:none">
				<option value="null">---�з�2---</option>
				<option>name</option>
				<option>id</option>
				<option>birthdate</option>
				<option>gender</option>
			</select>

			<select id="categ1_2" name="categ1_2" style="display:none">
				<option value="null">---�з�2---</option>
				<option value="0">��ó��</option>
				<option value="1">����</option>
				<option value="-1">����</option>
			</select>

			<select id="categ1_2" name="categ1_2" style="display:none">
				<option value="null">---�з�2---</option>
				<option value="0">��ó��</option>
				<option value="1">����</option>
				<option value="-1">����</option>
			</select>
		</td>
	</tr>
</table>

<div id="sortAll" style="display:block;">
<form action="ModifyInfo.nhn" method="post">
<table border="1" align="center" width="800">
	<tr>
		<td align="center" bgcolor="#D9E5FF"><b>ȸ����ȣ</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>Ÿ��</b></td>
		<td align="center" width="50%" bgcolor="#D9E5FF"><b>���氪</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>��û��</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>ó��</b></td>
	</tr>
	<c:forEach var="modify" items="${modifyList}">
	
	<script type="text/javascript">
		function viewReason${modify.num}(){
			if(tr${modify.num}.style.display == 'block'){
				$('#tr${modify.num}').attr('style','display:none;');
			}else{
				$('#tr${modify.num}').attr('style','display:block;');
			}
		}
	</script>
	
	<tr>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">${modify.mem_num}</div></td>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">${modify.type}</div></td>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">${modify.changeval}</div></td>
		<td align="center"><div onclick="viewReason${modify.num}()" style="cursor:pointer;">
		<fmt:formatDate value="${modify.reg}" type="date" /></div></td>
		<td align="center">
		<c:if test="${modify.state == 0}">
			<input type="hidden" value="${modify.num}" name="num">
			<input type="hidden" value="${modify.mem_num}" name="mem_num">
			<input type="hidden" value="${modify.type}" name="type">
			<input type="hidden" value="${modify.changeval}" name="changeval">
			<input type="submit" value="����">
			<input type="button" value="����" onclick="document.location.href='/MyUsed/ModifyReject.nhn?num=${modify.num}&type=${modify.type}&mem_num=${modify.mem_num}'">
		</c:if>
		<c:if test="${modify.state == 1}">
			<font color="blue"><b>����</b></font>			
		</c:if>
		<c:if test="${modify.state == -1}">
			<font color="red"><b>����</b></font>
		</c:if>
		</td>
	</tr>
	
	<tr id="tr${modify.num}" style="display:none;">
		<td colspan="4">${modify.reason}</td>
	</tr>
	
	</c:forEach>

</table>
</form>
</div>


<div id="sort" style="display:block;"></div>








</center>
</body>
</html>