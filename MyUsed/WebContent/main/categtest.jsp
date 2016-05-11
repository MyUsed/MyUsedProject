<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){		//onload이벤트같은것(시작하자마자 바로 동작)
      $("#button").click(function(){
          callAjax();
      });
    });
    function callAjax(){
        $.ajax({
	        type: "post",
	        url : "/MyUsed/categindex.nhn",
	        data: {	// url 페이지도 전달할 파라미터
	        	categ0 : $('#categ0').val()
	        },
	        success: test,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
     	});
    }
    function test(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
        $("#ajaxReturn").html(aaa);
        console.log(resdata);
    }
    function whenError(){
        alert("Error");
    }
  </script>
  
<form id="frm"> 
	<select name="categ0name" id="categ0">
		<option>--------1차--------</option>
		<c:forEach var="categ" items="${categList}">
			<option>${categ.categ}</option>
		</c:forEach>
	</select>
</form>

<br /><br /><br />
<p>
<span id="ajaxReturn">
<input id="button" type="button" value="버튼">
ajaxReturnOutput
</span>	
</p>



