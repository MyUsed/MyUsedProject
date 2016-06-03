<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>

<script type="text/javascript">
	function proRepleOpen(){
		var url = "admin_proboardReple.nhn?num=${pdto.num}";
		window.open(url, "chat", "width=600, height=400, left=500, top=100 ,resizable=yes, location=no, status=no, toolbar=no, menubar=no");
	}
</script>

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript">
	    $(document).ready(function(){
	    	window.setInterval('proRepleAjax()', 5000); //5�ʸ����ѹ��� �Լ��� �����Ѵ�..!! 
	    });
	    function proRepleAjax(){
	    	 $.ajax({
	 	        type: "post",
	 	        url : "admin_proRepleCount.nhn?num=${pdto.num}&like=${like}",
	 	        success: proReple,	// ��������û ������ ���� �Լ�
	 	        error: proError	//��������û ���н� �����Լ�
	      	});
	    }
	    function proReple(pro){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
	        $("#ajaxproReple").html(pro);
	    }
	    function proError(){
	        alert("proError");
	    }
	</script>

<html>
<c:if test="${sessionScope.adminId == null }">
	<script type="text/javascript">
		alert("������ �����ϴ�.");
		history.go(-1);
	</script>
</c:if>
<body>
<c:if test="${sessionScope.adminId != null }">
<br/>
	<table align="center"  width="550" height="180">
		<tr>
			<td>
				<hr width="100%" > 
				<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${pdto.mem_num}"><font face="Comic Sans MS" >( ${pdto.name} )</font></a>
				<font face="Comic Sans MS" size="2" color="#A6A6A6" > ���� ��ǰ �Խñ� �Դϴ�.  </font>
				<a href="admin_proboardDelete.nhn?num=${pdto.num}"><img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 1em;" width="20" height="20" align="right" title="�Խñ� ����"/></a>
				<hr width="100%" > 
			</td>
		</tr>
		
		<tr>
			<td align="center">
				<a href="ProductDetailView.nhn?num=${pdto.num}">
					<img src="/MyUsed/images/${pdto.pro_pic}" width="370" height="350" /> 
				</a>
				<br/>
				
				<font size="5" color="#1F51B7" >${pdto.price}\</font> <br/><br/>
				<font size="3" color="#0042ED" >
			-------------------------------- * �󼼼��� * -------------------------------- 
				</font>
				${pdto.content}
				<hr width="100%" > 
			</td>
		</tr>
		
		<tr>
			<td>
				<div id="ajaxproReple">���ƿ� ${like}�� / ��� <a href="javascript:;" onclick="proRepleOpen(${pdto.num})">${repleCount}</a>��</div>
				<hr width="100%" > 
			</td>
		</tr>
		
		<tr>
			<td align="center">
				<input type="button" value="�ڷΰ���" onclick="history.go(-1)">
			</td>
		</tr>
	</table>
</body>
</html>
</c:if>