<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>������ ���� ������ </title>

 <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
  <script type="text/javascript">
    function adminAjax(){
    	
        $.ajax({
	        type: "post",
	        url : "/MyUsed/admin/AdminCreate.jsp",
	        success: test,	// ��������û ������ ���� �Լ�
	        error: whenError	//��������û ���н� �����Լ�
     	});
    }
    function test(aaa){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
        $("#ajaxReturn").html(aaa);
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
	
	<input type="button" value="������ ��������" onclick="adminAjax();" /> 
	<input type="button" value="������ �������" /> 
	<input type="button" value="������ ��������" />
		<br /> <br />
	 
	 <div id="ajaxReturn"></div>
	 
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
	 		<td>${list.reg}</td>
	  </tr>
	 	</c:forEach>
	
	 
	 </table>
	</center>

	


</body>
</html>