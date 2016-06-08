<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/member/jquery-1.11.3.js"></script>
<script type="text/javascript">
function mouse_Over_1(){
	document.getElementById("categ1plus").style.background="#EAEAEA";
}
function mouse_Out_1(){
	document.getElementById("categ1plus").style.background="#FFFFFF";
}

function categPlusOpen1(){
	$('#categ1plus').attr('style', 'display:none;'); 	 	
	$('#categ1plus_input').attr('style', 'display:block;'); 	 
};


function Categ1event(){
	if(event.keyCode == 13){
		insertCateg1();
	}
}
function insertCateg1(){
    $.ajax({
        type: "post",
        url : "/MyUsed/ModifyCateg1insert.nhn",
        data: {	// url 페이지도 전달할 파라미터
        	categ : $("#catg1input").val(),
        	ca_group : '${ca_group}'
        },
        success: insertcateg1,	// 페이지요청 성공시 실행 함수
        error: insertcategError1	//페이지요청 실패시 실행함수
 	});
}
function insertcateg1(list){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
	alert('카테고리가 추가되었습니다.');
	$("#categ1plus_input").attr('style', 'display:none;'); 
	//$("#categ1").html(list);
	window.location.reload();
    console.log(resdata);
}
function insertcategError1(){
    alert("insertcategError");
}

</script>

</head>
<body>
	
<c:forEach var="categ1" items="${categ1List}" varStatus="j">
	<script type="text/javascript">
		function mouseOver_${j.index}(){
			document.getElementById("c1_${j.index}").style.background="#EAEAEA";
		}
		function mouseOut_${j.index}(){
			document.getElementById("c1_${j.index}").style.background="#FFFFFF";
		}
			

		function categModiOpen1_${j.index}(){
			$('#c1_${j.index}').attr('style', 'display:none;'); 	 	
			$('#c1_${j.index}_mofidy').attr('style', 'display:block;'); 	 
		};

		function Categ0modievent(){
			if(event.keyCode == 13){
				modifyCateg0();
			}
		}
		function modifyCateg0(){
		    $.ajax({
		        type: "post",
		        url : "/MyUsed/ModifyCateg1modify.nhn",
		        data: {	// url 페이지도 전달할 파라미터
		        	categ_modi : $("#catg1modi${j.index}").val(),
		        	categ : $("#catg1modi_categ${j.index}").val(),
		        	ca_group :  $("#catg1modi_ca_group${j.index}").val()
		        },
		        success: caModicateg1,	// 페이지요청 성공시 실행 함수
		        error: modicategError1	//페이지요청 실패시 실행함수
		 	});
		}
		function caModicateg1(list){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
			alert('카테고리가 수정되었습니다.');
			window.location.reload();
		    console.log(resdata);
		}
		function modicategError1(){
		    alert("modicategError");
		}
	</script>
	<div id="c1_${j.index}" ondblclick="categModiOpen1_${j.index}()"  onmouseover="mouseOver_${j.index}()" onmouseout="mouseOut_${j.index}()" style="cursor:pointer; padding-left:20px;">
		${categ1.categ}
	</div>
	<div id="c1_${j.index}_mofidy" style="display:none;">
		<input type="text" id="catg1modi${j.index}" name="catg1modi" style="width:80%;" onkeypress="Categ0modievent()" value="${categ1.categ}">
		<input type="button" style="width:45px;" value="삭제" onclick="document.location.href='/MyUsed/ModifyCategdelete.nhn?categ=${categ1.categ}&ca_level=${categ1.ca_level}&ca_group=${categ1.ca_group}'">
		<input type="hidden" id="catg1modi_categ${j.index}" name="catg0modi" value="${categ1.categ}">
		<input type="hidden" id="catg1modi_ca_group${j.index}" name="catg0modi" value="${categ1.ca_group}">
	</div>
</c:forEach>
<div id="categ1plus" onclick="categPlusOpen1()" onmouseover="mouse_Over_1()" onmouseout="mouse_Out_1()" style="cursor:pointer; padding-left:20px;">
	추가+
</div>
<div id="categ1plus_input" style="display:none;">
	<input type="text" id="catg1input" name="catg1input" style="width:98%;" onkeypress="Categ1event()">
</div>
</body>
</html>