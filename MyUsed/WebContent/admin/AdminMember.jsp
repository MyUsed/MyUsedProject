<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>������ ���� ������ </title>
<script src="/MyUsed/admin/adminAjax.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>

// �˻� ajax

function SearchAjax(){
	
	$('#AdminSearchReturn').attr('style', 'display:block');
	
    $.ajax({
        type: "post",
        url : "AdminSearch.nhn",
        data: {
        	grade : $('#grade').val(),
        	part : $('#part').val(),
        	search : $('#search').val(),
        	ser : $('#ser').val()
        	
        },
        success: search,	// ��������û ������ ���� �Լ�
        error: whenError	//��������û ���н� �����Լ�
 	});
}
function search(bbb){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
    $("#AdminSearchReturn").html(bbb);
    console.log(resdata);
}
function whenError(){
    alert("Error");
}

</script>
</head>
<body>

<!---------------------- �۾��Ҷ� 2���� include �ؼ� ��� ------------------------------->
<div id="AdminTop"><jsp:include page="AdminTop.jsp"/></div> <!-- Admin Top -->	
<div id="AdminLeft"><jsp:include page="AdminLeft.jsp"/></div> <!-- Admin Left -->	
<!-- ------------------------------------------------------------------------- -->


		<br /> <br />
	<center>
	
	<input type="button" value="������ ��������" onclick="createAjax();" /> 
	<input type="button" value="������ �������" onclick="updateAjax();"/> 
	<input type="button" value="������ ��������" onclick="deleteAjax();"/> <br />
	
	
		<br /> <br />
		
	 <!-- create �������� Ajax -->
	 <div id="createReturn"></div>
	 
	  <!-- create �������� Ajax -->
	 <div id="deleteReturn"></div>
	 	 
	  <!-- create �������� Ajax -->
	 <div id="updateReturn"></div>
	 
	 <!-- search ��� -->
	 <div id="AdminSearchReturn" style="display:block;"></div>
		
	 <br/>
	 
	 
	 <div id="adminlist" style="display:block;">
	 				 
	 				<h2><strong>* ������ ��� * </strong></h2>
	 <table border="1" >
	
	 <tr align="center">
   		<td><strong>ID</strong></td><td><strong>PW</strong></td><td><strong>NAME</strong></td>
   		<td><strong>GRADE</strong></td><td><strong>PART</strong></td><td><strong>DATE</strong></td>
   	</tr>
  		
	 	<c:forEach var="list" items="${list}">
	 <tr>
	 		<td>${list.id}</td> 
	 		<td>${list.pw}</td>
	 		<td>${list.name}</td> 
	 		<td>${list.grade}</td>
	 		<td>${list.part}</td>
	 		<td><fmt:formatDate value="${list.reg}" type="date" /></td>
	  </tr>
	 	</c:forEach>
	
	 
	 
	 </table>
	 <br />
	 
	 
	 
	 <select id="grade" name="grade" >
		<option value="null">-�����ڵ��-</option>
		<option>Master</option>
		<option>����</option>
		<option>����</option>
		<option>�븮</option>
	</select>
	<select id="part" name="part" >
		<option value="null">-�μ�-</option>
		<option>ȸ������</option>
		<option>����������</option>
		<option>�Խñ۰���</option>
		<option>��۰���</option>
		<option>�������</option>
		<option>�����Ͱ���</option>
	</select>
	
	 
	 </div>
	 <script>

		 </script>
	 
	 <select id="ser">
	 <option value="null">����</option>
	 <option value="id">ID</option>
	 <option value="name">NAME</option>
	 </select>   
	 <input type="text"  id="search" name="search" size="14"/>
	 <input type="button" value="�˻�" onclick="SearchAjax();" /> 
	 
	 
	</center>

	


</body>
</html>