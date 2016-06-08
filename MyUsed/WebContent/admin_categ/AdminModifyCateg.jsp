<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/member/jquery-1.11.3.js"></script>

<script type="text/javascript">
function mouseOver(){
	document.getElementById("categ0plus").style.background="#EAEAEA";
}
function mouseOut(){
	document.getElementById("categ0plus").style.background="#FFFFFF";
}

function categPlusOpen(){
	$('#categ0plus').attr('style', 'display:none;'); 	 	
	$('#categ0plus_input').attr('style', 'display:block;'); 	 
};

function Categ0event(){
	if(event.keyCode == 13){
		insertCateg0();
	}
}
function insertCateg0(){
    $.ajax({
        type: "post",
        url : "/MyUsed/ModifyCateg0insert.nhn",
        data: {	// url �������� ������ �Ķ����
        	categ : $("#catg0input").val()
        },
        success: insertcateg,	// ��������û ������ ���� �Լ�
        error: insertcategError	//��������û ���н� �����Լ�
 	});
}
function insertcateg(list){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
	alert('ī�װ��� �߰��Ǿ����ϴ�.');
	$("#categ0plus_input").attr('style', 'display:none;'); 
	window.location.reload();
    console.log(resdata);
}
function insertcategError(){
    alert("insertcategError");
}
</script>
	 	

<title> ������ ������ </title>
</head>
<body>
	
<!---------------------- �۾��Ҷ� 2���� include �ؼ� ��� ------------------------------->
<div id="AdminTop"><jsp:include page="/admin/AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="/admin/AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->
<center>
<h2>* ��ǰ ī�װ� ���� *</h2>

<table border="1" width="600">
	<tr>
		<td align="center" bgcolor="#D9E5FF"><b>1�� ī�װ�</b></td>
		<td align="center" bgcolor="#D9E5FF"><b>2�� ī�װ�</b></td>
	</tr>
	<tr height="300">
		<td width="300">
			<c:forEach var="categ0" items="${categ0List}" varStatus="i">
			<script type="text/javascript">
				function mouseOver${i.index}(){
					document.getElementById("c${i.index}").style.background="#EAEAEA";
				}
				function mouseOut${i.index}(){
					document.getElementById("c${i.index}").style.background="#FFFFFF";
				}
				
				function nextCateg1${i.index}(){
				       $.ajax({
				            type: "post",
				            url : "/MyUsed/ModifyCateg_index.nhn",
				            data: {	// url �������� ������ �Ķ����
				            	ca_group : '${categ0.ca_group}'
				            },
				            success: modicateg,	// ��������û ������ ���� �Լ�
				            error: modicategError	//��������û ���н� �����Լ�
				     	});
				    }
				function modicateg(list){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
				        $("#categ1").html(list);
				       // console.log(resdata);
				    }
				function modicategError(){
				        alert("modicategError");
				    }

				function categModiOpen${i.index}(){
					$('#c${i.index}').attr('style', 'display:none;'); 	 	
					$('#c${i.index}_mofidy').attr('style', 'display:block;'); 	 
				};

				function Categ0modievent(){
					if(event.keyCode == 13){
						modifyCateg0();
					}
				}
				function modifyCateg0(){
				    $.ajax({
				        type: "post",
				        url : "/MyUsed/ModifyCateg0modify.nhn",
				        data: {	// url �������� ������ �Ķ����
				        	categ_modi : $("#catg0modi${i.index}").val(),
				        	categ : $("#catg0modi_hidden${i.index}").val()
				        },
				        success: caModicateg,	// ��������û ������ ���� �Լ�
				        error: modicategError	//��������û ���н� �����Լ�
				 	});
				}
				function caModicateg(list){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
					alert('ī�װ��� �����Ǿ����ϴ�.');
					window.location.reload();
				    console.log(resdata);
				}
				function modicategError(){
				    alert("modicategError");
				}
				
			</script>
			<div id="c${i.index}" onclick="nextCateg1${i.index}()" ondblclick="categModiOpen${i.index}()" onmouseover="mouseOver${i.index}()" onmouseout="mouseOut${i.index}()" style="cursor:pointer; padding-left:20px;">
				${categ0.categ}
			</div>
			<div id="c${i.index}_mofidy" style="display:none;">
				<input type="text" id="catg0modi${i.index}" name="catg0modi" style="width:80%;" onkeypress="Categ0modievent()" value="${categ0.categ}">
				<input type="button" style="width:45px;" value="����" onclick="document.location.href='/MyUsed/ModifyCategdelete.nhn?categ=${categ0.categ}&ca_level=${categ0.ca_level}&ca_group=${categ0.ca_group}'">
				<input type="hidden" id="catg0modi_hidden${i.index}" name="catg0modi" value="${categ0.categ}">
			</div>
			</c:forEach>
			
			
			<div id="categ0plus" onclick="categPlusOpen()" onmouseover="mouseOver()" onmouseout="mouseOut()" style="cursor:pointer; padding-left:20px;">
				�߰�+
			</div>
			<div id="categ0plus_input" style="display:none;">
				<input type="text" id="catg0input" name="catg0input" style="width:98%;" onkeypress="Categ0event()">
			</div>
		</td>
		
		<td width="300" valign="top">
			<div id="categ1"></div>
		</td>
	</tr>
</table>





</center>
</body>
</html>