<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>BoardSelect</title>
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<style>
input[type=text] {
 		padding: 2px;
 		text-align: center;
 		margin: 0px;
		}
		
#csearch {    position:absolute; 
 			  background-image:url(abc.PNG);
			  width:1020px; 
			  height:80px;  
			  margin-top:60px; 
			  margin-left:210px;
			  margin-right:10px; 
			  background:#FFFFFF;
			  border:1px solid #BDBDBD;
			  padding-top:6px; }
			  		
#notice {     position:absolute; 
			  width:500px; 
			  height:230px;  
			  margin-top:150px; 
			  margin-left:210px;
			  margin-right:10px; 
			  background:#FFFFFF;
			  border:1px solid #BDBDBD;
			  padding-top:6px; }
			  
#FAQ {        position:absolute; 
		 	  width:500px; 
			  height:230px;  
			  margin-top:420px; 
			  margin-left:210px;
			  margin-right:10px; 
			  background:#FFFFFF;
			  border:1px solid #BDBDBD;
			  padding-top:6px; }
			  
			  
#Report {     position:absolute; 
			  width:500px; 
			  height:230px;  
			  margin-top:150px; 
			  margin-left:730px;
			  margin-right:10px; 
			  background:#FFFFFF;
			  border:1px solid #BDBDBD;
			  padding-top:6px; }
			  
#QNA {        position:absolute; 
			  width:500px; 
			  height:230px;  
			  margin-top:420px; 
			  margin-left:730px;
			  margin-right:10px; 
			  background:#FFFFFF;
			  border:1px solid #BDBDBD;
			  padding-top:6px; }		  			  			  
</style>
<script>
function click11(){
	alert("test");
	//var frm = document.boardSelect.search;
	//frm.action ="/MyUsed/bdseach.nhn";
	////frm.method="post";
	//frm.submit();
	
}

</script>
<body>
<div id="layer_fixed"><jsp:include page="/board/layer_fixed.jsp"/></div>
<div id="sidebannerL"><jsp:include page="/board/bdsidebannerL.jsp" /></div> <!-- 사이드배너 Left -->
<div id="csearch"></div>
<div id="notice"><jsp:include page="/board/NoticeBoard2.jsp"/></div>
<div id="FAQ"><jsp:include page="/board/FaqBoard2.jsp"/></div>
<div id="Report"><jsp:include page="/board/ReportBoard2.jsp"/></div>
<div id="QNA"><jsp:include page="/board/QnaBoard2.jsp"/></div>
 <!-- 상단 검색 Top -->
  <!-------------------------------- 메인 내용 ------------------------------------------>
	<br /><br /><br /><br /><br />

	<form id="boardSelect">
	 <table align="center"  width="550" height="30">
	
	 <tr>
	 	<td><input type="text" name="search" placeholder="안녕하세요 .무엇을 도와드릴까요?"><button type="submit"  onclick="javascript:click11()"><img src="/MyUsed/images/Search.png" width="20"  height="20"></button></td>
	 </tr>
	 <tr bgcolor="#FFFFFF">
	 <td align="center" colspan="8"></td>
	</tr>
	</table>
	 </form>

</body>
</html>