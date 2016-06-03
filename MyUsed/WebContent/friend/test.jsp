<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- <html>
<head>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

	<script type="text/javascript">
	$(document).ready(function(){
		var content = document.getElementById('content').innerHTML;
		//var content = "&nbsp;"+content;
		//var content = '#fff ddd #ddd';
		console.log(content);
		var splitedArray = content.split(' ');
		var linkedContent = '';
		console.log("aaa",splitedArray);
		/* if(splitedArray[0].indexOf('#') == 0)
		{
			var url = '"'+'/MyUsed/MyUsed.nhn?word='+splitedArray[0]+'"';
			splitedArray[0] = '<a href='+url+'>'+splitedArray[0]+'</a>';	
			console.log("dsfa",splitedArray[0]);
		}
		console.log("bbb",splitedArray);
		console.log("ccc",splitedArray.length); */
		//alert(splitedArray[0].indexOf('#'));
		for(var word in splitedArray)
		{
		  word = splitedArray[word];	  
		  if(word.indexOf('#') == 0)
		  {
			  var url = '"'+'/MyUsed/MyUsed.nhn?word='+word+'"';
			  word = '<a href='+url+'>'+word+'</a>';
		      console.log(word);
		  }
		  linkedContent += word+' ';
		}
		document.getElementById('content').innerHTML = linkedContent;
		console.log(linkedContent);
		//document.getElementById('content').innerHTML = "<xmp>"+splitedArray+"</xmp>";
	});
	</script>
</head>
<body>

<div id="content">
#aa dsfad #df dsafd #gg sdaf #dd
</div>


<div id="test">
</div>

</body>
</html> -->

	
<script language='JavaScript'>

document.write('<st'+'yle>');
document.write('td {font-size:12px; font-family:굴림; text-decoration:none; }');
document.write('A:link,A:active,A:visited{text-decoration:none;font-size:12PX;color:#333333;}');
document.write('A:hover {text-decoration:none; color:ff9900}');
document.write('font { font-size: 9pt; }');
document.write('.cnj_input { border-style:solid;border-left-width:8;border-right-width:1;border-top-width:1;border-bottom-width:1;border-color:#ffcc00;text-align:center;}');
document.write('.cnj_input2 {border-width:1; border-color:rgb(204,204,204); border-style:solid;cursor:hand;}');
document.write('.cnj_input3 { border-width:1; border-style:solid; border-color:#000000; color:#0084D4; background-color:white;cursor:hand;}');
document.write('.cnj_input4 { scrollbar-face-color: #FFCC33;scrollbar-shadow-color:  #ffffff;scrollbar-highlight-color: #F3f3f3;scrollbar-3dlight-color: #ffffff;scrollbar-darkshadow-color: #F3f3f3;scrollbar-track-color: #ffffff;scrollbar-arrow-color: #f9f9f9;cursor:hand; }');
document.write('</st'+'yle>');
function cnj_key_chk(){
      var f =  document.cnjform; 
      f.cnj_key.value=""+ String.fromCharCode(event.keyCode) + "";
      f.cnj_text.value=String.fromCharCode(event.keyCode) + " ==> " + event.keyCode;
      event.returnValue=false;
}
</script>
<center>
<form name="cnjform">
키입력 : <input type="text" name="cnj_key"  size="2" onkeydown="cnj_key_chk()" class="cnj_input">
키코드 : <input type="text" name="cnj_text" size="20"  class="cnj_input" readonly>
</form>
</center>