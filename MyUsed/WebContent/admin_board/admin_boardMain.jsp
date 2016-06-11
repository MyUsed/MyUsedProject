<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ include file="/admin/AdminTop.jsp"%>
<%@ include file="/admin/AdminLeft.jsp"%>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<c:if test="${sessionScope.adminId == null }">
	<script type="text/javascript">
		alert("������ �����ϴ�.");
		history.go(-1);
	</script>
</c:if>

<script type="text/javascript">
var p;
var count = 1;
var cnt = 1;
$(document).ready(function(){	// �������ڸ��� �ٷε���(onload)
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
	        data: {	// url �������� ������ �Ķ����
	        	id_search : $('#id_search').val(),
	        	radio : radio
	        },
	        success: search,	// ��������û ������ ���� �Լ�
	        error: whenError	//��������û ���н� �����Լ�
   	});
  }
  function search(b){	// ��û������ ������������ b ������ �ݹ�ȴ�. 
		$("#ajaxSearch").html(b);
  		cnt = cnt+1;
		console.log(resdata);
  }
  function whenError(){
      alert("Error");
  }
  
  function boardFocus(){	// search�� ��Ŀ��
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
	        data: {	// url �������� ������ �Ķ����
	        	id_search : id,
	        	radio : radio,
	        	currentPage : currentPage
	        },
	        success: Psearch,	// ��������û ������ ���� �Լ�
	        error: whenPError	//��������û ���н� �����Լ�
   	});
  }
  function Psearch(p){	// ��û������ ������������ b ������ �ݹ�ȴ�. 
		$("#ajaxPaging").html(p);
		console.log(resdata);
  }
  function whenPError(){
      alert("Error");
  }
</script>

<script>
	function research(){
		boardForm.search.value = "��˻�";
		
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
						<font size="1" color="red"><b>* ���̵�� ��Ȯ�ϰ� ����.</b></font>
					</td>
				</tr>
				
				<tr>
					<td>
						ȸ�����̵�:<input type="text" name="id_search" id="id_search"/> <input type="button" name="search" id="search" value="�˻�" onclick="research()"/>
					</td>
				</tr>
			</table>
		</form>
			<div id="ajaxSearch"></div>
			<div id="ajaxPaging"></div>
		
	</c:if>
</body>