<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2> test 페이지 </h2>

<html>
<head>
<title></title>
<script type="text/javascript">
function test_sample(){
 var sample = document.getElementsByName('flower');
 for(var i=0;i<sample.length;i++){
  if(sample[i].checked == true){
   alert(sample[i].value);
  }
 }
}
</script>
</head>
<body>
<input type="radio" name="flower" value="1"/>장미<br>
<input type="radio" name="flower" value="2"/>코스모스<br>
<input type="radio" name="flower" value="3"/>해바라기<br>
<input type="radio" name="flower" value="4"/>들국화<br>
<input type="radio" name="flower" value="5"/>할미꽃<br><br>

<input type="button" value="확인" onclick="test_sample();"/>
</body>
</html>

