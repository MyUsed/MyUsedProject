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
	      	
	        success: gubun,	// ��������û ������ ���� �Լ�
	        error: whenError	//��������û ���н� �����Լ�
  			});
	 }else if(argum=="Faq"){
		 alert("2");
		 $.ajax({
		        type: "post",
		        url : "Faq.nhn",
		      	
		        success: gubun,	// ��������û ������ ���� �Լ�
		        error: whenError	//��������û ���н� �����Լ�
	  			});
		 }else if(argum=="Report"){
			 alert("3");
			 $.ajax({
			        type: "post",
			        url : "Report1.nhn",
			      	
			        success: gubun,	// ��������û ������ ���� �Լ�
			        error: whenError	//��������û ���н� �����Լ�
		  			});
		 }else if(argum="Qna"){
			 alert("4");
			 $.ajax({
			        type: "post",
			        url : "Qna.nhn",
			      	
			        success: gubun,	// ��������û ������ ���� �Լ�
			        error: whenError	//��������û ���н� �����Լ�
		  			});
		 }
}

function gubun(abc){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
	alert("2");
	
	$("#gubun").html(abc);	//id�� ajaxReturn�� �κп� �־��
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
<!-- <a onclick="gubunAjax('Notice')">��������</a> -->
<font color="#242424">������</font> <br /><br />
&nbsp;&nbsp;&nbsp;&nbsp;
<a onclick="location.href='/MyUsed/Notice.nhn'">��������</a>
<br /><br />&nbsp;&nbsp;&nbsp;&nbsp;
<!-- <a onclick="gubunAjax('Faq')">FAQ</a> -->
<a onclick="location.href='/MyUsed/Faq.nhn'">FAQ</a>
<br /><br />&nbsp;&nbsp;&nbsp;&nbsp;
<!-- <a onclick="gubunAjax('Report')">�Ű��ϱ�</a> -->
<a onclick="location.href='/MyUsed/Report1.nhn'">�Ű��ϱ�</a>
<br /><br />&nbsp;&nbsp;&nbsp;&nbsp;
<!-- <a  onclick="gubunAjax('Qna')">Q&A</a> -->
<a onclick="location.href='/MyUsed/Qna.nhn'">QNA</a>
<br /><br />

</body>
</html>