<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2> test ������ </h2>

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
<input type="radio" name="flower" value="1"/>���<br>
<input type="radio" name="flower" value="2"/>�ڽ���<br>
<input type="radio" name="flower" value="3"/>�عٶ��<br>
<input type="radio" name="flower" value="4"/>�鱹ȭ<br>
<input type="radio" name="flower" value="5"/>�ҹ̲�<br><br>

<input type="button" value="Ȯ��" onclick="test_sample();"/>
</body>
</html>

