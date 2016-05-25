<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
</html>