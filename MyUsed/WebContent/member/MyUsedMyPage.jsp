<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<html lang="ko">
<head>

 		<script type="text/javascript">
        
              function send(){     
        

                   document.formId.method = "post"     // method ����, get, post
                   document.formId.action = "/MyUsed/main/test.jsp";  // submit �ϱ� ���� ������ 

                   document.formId.submit();
                  
              }
             
             
         </script>




	<meta charset="utf-8"/>
	<title>MyUsed</title>
	<style type="text/css">
		#layer_fixed
		{
			height:50px;
			width:120%;
			color: #242424;
			font-size:12px;
			position:fixed;
			z-index:999;
			top:0px;
			left:0px;
			-webkit-box-shadow: 0 1px 2px 0 #777;
			box-shadow: 0 1px 2px 0 #777;
			background-color:#3B5998;
		}
		
		input[type=text] {
 		padding: 3px;
 		text-align: center;
 		margin: 0px;
		}
		
		
	</style>
</head>

<body>
	<div id="layer_fixed">
		<table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
		<tr>
			<td style="vertical-align:left; padding-left: 30px; padding-right: 80px;">
			<a href="/MyUsed/main/MyUsed.jsp">
			<img src="/MyUsed/images/Mlogo2.png" width="170"  height="50">
			</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" size="70"/>
				<button type="submit"><img src="/MyUsed/images/Search.png" width="20"  height="20"></button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<img src="/MyUsed/images/profile.png" width="15"  height="15">
				<a href="/MyUsed/MyUsedMyPage.nhn">${name}</a> | 
				<a href="/MyUsed/MyUsed.nhn">Ȩ</a> | 
				<a href="/MyUsed/MyUsed.nhn">ģ��ã��</a>
				
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainFriend.png" width="45"  height="40"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainMessage.png" width="40"  height="35"></a>
				<a href="/MyUsed/main/modify.jsp"><img src="/MyUsed/images/mainView.png" width="40"  height="35"></a>
			</td>
			
		</tr>
		</table>
	</div>



<style type="text/css">
#sidebannerR { position:fixed; top:50px; left:50%; margin-left:470px; width:200px; height:800px; background:#EAEAEA; }
#sidebannerL { position:fixed; top:50px; right:50%; margin-right:470px; width:200px; height:800px; background:#E9EAED; }
#content { width:980px; height:3000px; margin:0 auto; background:#EAEAEA; }
#coverImage { position:absolute; width:800px; height:220px; margin-right:10px; background:#FFFFFF; }
#profileImage { 
	position:absolute; 
	width:160px; 
	height:160px; 
	margin-top:83px; 
	margin-left:25px; 
	background:#8C8C8C;
	border:1px;
	border-color:#353535;
	
	}
	
	
/* #menu{ position:absolute; width:680px; height:40px; margin-top:223px ;margin-right:10px; background:#FFFFFF; } */
#menu0{ position:absolute;
		width:199px; 
		height:40px;
		margin-top:221px;
		margin-right:0px; 
		margin-left:0px; 
		background:#FFFFFF; 
		}
#menu1{ position:absolute;
		width:80px; 
		height:40px;
		margin-top:221px;
		margin-right:10px; 
		margin-left:200px;
		background:#FFFFFF;
		text-align:center;
		padding-top:10px;
		color:#1F50B5;
		}
#menu2{ position:absolute;
		width:80px; 
		height:40px;
		margin-top:221px;
		margin-right:10px; 
		margin-left:281px;
		background:#FFFFFF; 
		text-align:center;
		padding-top:10px;
		color:#1F50B5;
		}		
#menu3{ position:absolute;
		width:80px; 
		height:40px;
		margin-top:221px;
		margin-right:10px; 
		margin-left:362px;
		background:#FFFFFF; 
		text-align:center;
		padding-top:10px;
		color:#1F50B5;
		}		
#menu4{ position:absolute;
		width:80px; 
		height:40px;
		margin-top:221px;
		margin-right:10px; 
		margin-left:443px;
		background:#FFFFFF; 
		text-align:center;
		padding-top:10px;
		color:#1F50B5;
		}	
#menu5{ position:absolute;
		width:80px; 
		height:40px;
		margin-top:221px;
		margin-right:10px; 
		margin-left:524px;
		background:#FFFFFF; 
		text-align:center;
		padding-top:10px;
		color:#1F50B5;
		}	
#menu6{ position:absolute;
		width:195px; 
		height:40px;
		margin-top:221px;
		margin-right:10px; 
		margin-left:605px;
		background:#FFFFFF; 
		}
		
		
#knewpeople { position:absolute; 
			  width:800px; 
			  height:180px; 
			  margin-top:275px; 
			  margin-right:10px; 
			  background:#FFFFFF; }
			  
			  
#knewpeopletitle { position:absolute; 
			  width:800px; 
			  height:30px;  
			  margin-top:0px; 
			  margin-right:10px; 
			  background:#BDBDBD;
			  padding-top:6px; }
		
			  
#simpleinfo { position:absolute; 
			  width:230px; 
			  height:250px;  
			  margin-top:470px; 
			  margin-right:10px; 
			  background:#FFFFFF;
			  padding-top:6px; }
			  
#picture { position:absolute; 
			  width:230px; 
			  height:250px;  
			  margin-top:735px; 
			  margin-right:10px; 
			  background:#FFFFFF;
			  padding-top:6px; }
								
#article {  position:absolute; 
			width:555px; 
			height:250px;     
			margin-top:736px; 
			margin-right:10px;
			margin-left:245px;
			background:#FFFFFF;
			padding-top:6px; }								
								
#writeform {  position:absolute; 
			  width:555px; 
			  height:250px;
			  margin-top:470px; 
			  margin-right:10px;
			  margin-left:245px;
			  background:#FFFFFF; }
								
#writeformtitle {  position:absolute; 
			  width:555px; 
			  height:40px;
			  background:#F6F6F6;
			  padding-top:6px; }
			  
#propic {  position:absolute; 
			  width:100px; 
			  height:150px;
			  margin-top:45px; 
			  background:#F6F6F6;
			  padding-top:6px; }				
			  
#writearea {  position:absolute; 
			  width:440px; 
			  height:150px;
			  margin-top:45px; 
			  margin-left:108px;
			  background:#F6F6F6;
			  padding-top:6px; }
								
#bottom {  position:absolute; 
			  width:555px; 
			  height:50px;
			  margin-top:198px; 
			  background:#F6F6F6;
			  padding-top:6px; }
			  		
</style>
</head>

<body>
<div id="sidebannerR">
	<center>
 	<font size="5">���̵����R</font>
 	${sessionScope.memId}
   	</center>
</div>
<div id="sidebannerL">
</div>
<div id="content">
	<div id="coverImage">
	
	</div>
		
	<div id="menu0"><!-- ���� -->	</div>
	<div id="menu1"><a href="/MyUsed/MyUsedMyPage.nhn">Ÿ�Ӷ���</a></div>
	<div id="menu2"><a href="/MyUsed/MyUsedMyPage.nhn">����</a></div>	
	<div id="menu3"><a href="/MyUsed/MyUsedMyPage.nhn">ģ��</a></div>	
	<div id="menu4"><a href="/MyUsed/MyUsedMyPage.nhn">����</a></div>	
	<div id="menu5"><a href="/MyUsed/MyUsedMyPage.nhn">�� �����</a></div>
	<div id="menu6"><!-- ���� --></div>

	
	<div id="profileImage">
	
	
	</div>
	
	<div id="knewpeople">
		<div id="knewpeopletitle">
			�� �� �� �ִ� ģ��
	
		</div>
	</div>
	
	<div id="simpleinfo">
	�Ұ�
	
	</div>
	<div id="picture">
	����
	
	</div>
	
	<div id="writeform">
		<div id="writeformtitle">
			���
		</div>
		<div id="propic">
			�����ʻ���
		</div>
		<div id="writearea">
			<textarea rows="7" cols="60"></textarea>
		</div>
		<div id="bottom">
			�Ϻι�ư
		</div>
	</div>
	
	
	
	
	<%-- for�� �ɾ �ݺ� --%>
	<div id="article">
	�Խù�
	
	</div>
	
</div>


	
	
	<br /><br /><br />
	
	


</body>
</html>


