<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>

/* function gubunAjax(argum){
	alert("gubun="+argum);
	 if(argum=="Notice"){
		 alert("1");
	 $.ajax({
	        type: "post",
	        url : "Notice.nhn",
	      	
	        success: gubun,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
  			});
	 }else if(argum=="Faq"){
		 alert("2");
		 $.ajax({
		        type: "post",
		        url : "Faq.nhn",
		      	
		        success: gubun,	// 페이지요청 성공시 실행 함수
		        error: whenError	//페이지요청 실패시 실행함수
	  			});
		 }else if(argum=="Report"){
			 alert("3");
			 $.ajax({
			        type: "post",
			        url : "Report1.nhn",
			      	
			        success: gubun,	// 페이지요청 성공시 실행 함수
			        error: whenError	//페이지요청 실패시 실행함수
		  			});
		 }else if(argum="Qna"){
			 alert("4");
			 $.ajax({
			        type: "post",
			        url : "Qna.nhn",
			      	
			        success: gubun,	// 페이지요청 성공시 실행 함수
			        error: whenError	//페이지요청 실패시 실행함수
		  			});
		 }
}

function gubun(abc){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
	alert("2");
	
	$("#gubun").html(abc);	//id가 ajaxReturn인 부분에 넣어라
    location.href="/MyUsed/SubBoard.nhn?abc="+abc;
	alert("3");
}
function whenError(){
    alert("Error");
} */

</script>
<body>
<br />
<br />
<br />

 &nbsp;&nbsp;&nbsp;&nbsp;
<!-- <a onclick="gubunAjax('Notice')">공지사항</a> -->
<font color="#242424">고객센터</font> <br /><br />
&nbsp;&nbsp;&nbsp;&nbsp;
<a onclick="location.href='/MyUsed/Notice.nhn'">공지사항</a>
<br /><br />&nbsp;&nbsp;&nbsp;&nbsp;
<!-- <a onclick="gubunAjax('Faq')">FAQ</a> -->
<a onclick="location.href='/MyUsed/Faq.nhn'">FAQ</a>
<br /><br />&nbsp;&nbsp;&nbsp;&nbsp;
<!-- <a onclick="gubunAjax('Report')">신고하기</a> -->
<a onclick="location.href='/MyUsed/Report1.nhn'">신고하기</a>
<br /><br />&nbsp;&nbsp;&nbsp;&nbsp;
<!-- <a  onclick="gubunAjax('Qna')">Q&A</a> -->
<a onclick="location.href='/MyUsed/Qna.nhn'">QNA</a>
<br /><br />

</body>
</html>