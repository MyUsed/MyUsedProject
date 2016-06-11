<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<c:if test="${sessionScope.adminId == null }">
	<script type="text/javascript">
		alert("권한이 없습니다.");
		history.go(-1);
	</script>
</c:if>

<script type="text/javascript">
var p;
var count = 1;
var cnt = 1;
$(document).ready(function(){	// 시작하자마자 바로동작(onload)
    $("#search").click(function(){
    	if(count == 2){
    		if (!p) return;
    		p.appendTo("div");
    		p = $("#ajaxPaging").detach();
    		p = null;
    		count = 1;
    	}
        boardAjax();
        
    });
  });
  
  function boardAjax(){
		var radio = $(":input:radio[name=bradio]:checked").val();
      $.ajax({
	        type: "post",
	        url : "admin_boardSearch.nhn",
	        data: {	// url 페이지로 전달할 파라미터
	        	id_search : $('#id_search').val(),
	        	radio : radio
	        },
	        success: search,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
   	});
  }
  function search(b){	// 요청성공한 페이지정보가 b 변수로 콜백된다. 
		$("#ajaxSearch").html(b);
  		cnt = cnt+1;
		console.log(resdata);
  }
  function whenError(){
      alert("Error");
  }
  
  function boardFocus(){	// search에 포커스
		boardForm.id_search.focus();
	}
</script>


<script type="text/javascript">

  function pagingAjax(id, radio, currentPage){
	  $(function() {
		  $('#paging').click(function() {
			  if(count == 1){
			  	if (p) return;
			  	p = $("#ajaxSearch").detach();
			  	count = 2;
			  }
		  });
	  });
	  
      $.ajax({
	        type: "post",
	        url : "admin_boardSearch.nhn",
	        data: {	// url 페이지로 전달할 파라미터
	        	id_search : id,
	        	radio : radio,
	        	currentPage : currentPage
	        },
	        success: Psearch,	// 페이지요청 성공시 실행 함수
	        error: whenPError	//페이지요청 실패시 실행함수
   	});
  }
  function Psearch(p){	// 요청성공한 페이지정보가 b 변수로 콜백된다. 
		$("#ajaxPaging").html(p);
		console.log(resdata);
  }
  function whenPError(){
      alert("Error");
  }
</script>

<script>
	function research(){
		boardForm.search.value = "재검색";
		
	}
</script>

<br/><br/>
<body onload="boardFocus()">
	<c:if test="${sessionScope.adminId != null }">
		<form method="post" name="boardForm">
			<table align="center">
				<tr>
					<td align="center">
							<input type="radio" name="bradio" id="radio" value="board" checked/> SNS
							<input type="radio" name="bradio" id="radio" value="proboard" /> Trade
					</td>
				</tr>
				
				<tr>
					<td align="right">
						<font size="1" color="red"><b>* 아이디는 정확하게 기재.</b></font>
					</td>
				</tr>
				
				<tr>
					<td>
						회원아이디:<input type="text" name="id_search" id="id_search"/> <input type="button" name="search" id="search" value="검색" onclick="research()"/>
					</td>
				</tr>
			</table>
		</form>
			<div id="ajaxSearch"></div>
			<div id="ajaxPaging"></div>
		
	</c:if>
</body>