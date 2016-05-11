<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){		//onload�̺�Ʈ������(�������ڸ��� �ٷ� ����)
      $("#button").click(function(){
          callAjax();
      });
    });
    function callAjax(){
        $.ajax({
	        type: "post",
	        url : "/MyUsed/categindex.nhn",
	        data: {	// url �������� ������ �Ķ����
	        	categ0 : $('#categ0').val()
	        },
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
  
<form id="frm"> 
	<select name="categ0name" id="categ0">
		<option>--------1��--------</option>
		<c:forEach var="categ" items="${categList}">
			<option>${categ.categ}</option>
		</c:forEach>
	</select>
</form>

<br /><br /><br />
<p>
<span id="ajaxReturn">
<input id="button" type="button" value="��ư">
ajaxReturnOutput
</span>	
</p>



