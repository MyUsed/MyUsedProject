<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/main/script.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

<script type="text/javascript">
function openName(){
    $('#M_Name').attr('style', "display:block;");
}
function closeName(){
    $('#M_Name').attr('style', "display:none;");
}

function openID(){
    $('#M_ID').attr('style', "display:block;");
}
function closeID(){
    $('#M_ID').attr('style', "display:none;");
}

function openBirth(){
    $('#M_Birth').attr('style', "display:block;");
}
function closeBirth(){
    $('#M_Birth').attr('style', "display:none;");
}

function openGender(){
    $('#M_Gender').attr('style', "display:block;");
}
function closeGender(){
    $('#M_Gender').attr('style', "display:none;");
}


</script>


<style type="text/css">
#M_Name { position:fixed; 
			width:400px; 
			height:305px;
			margin-top:160px;
			margin-left:10%;
			text-align:center;
			background:#FFFFFF;
			border-radius:5px;
			border:1px solid #D5D5D5;
			box-shadow: 2px 2px 1px #A6A6A6;
			z-index:300; }
			
#M_ID { position:fixed; 
			width:400px; 
			height:305px;
			margin-top:160px;
			margin-left:10%;
			text-align:center;
			background:#FFFFFF;
			border-radius:5px;
			border:1px solid #D5D5D5;
			box-shadow: 2px 2px 1px #A6A6A6;
			z-index:300; }
			
#M_Birth { position:fixed; 
			width:400px; 
			height:305px;
			margin-top:160px;
			margin-left:10%;
			text-align:center;
			background:#FFFFFF;
			border-radius:5px;
			border:1px solid #D5D5D5;
			box-shadow: 2px 2px 1px #A6A6A6;
			z-index:300; }

#M_Gender { position:fixed; 
			width:400px; 
			height:305px;
			margin-top:160px;
			margin-left:10%;
			text-align:center;
			background:#FFFFFF;
			border-radius:5px;
			border:1px solid #D5D5D5;
			box-shadow: 2px 2px 1px #A6A6A6;
			z-index:300; }
</style>



<title>ModifyProfile</title>
</head>
<body>


<div id="M_Name" style="display:none;">
	<br /><br />
	<font style="font-size:110%; font-weight:bold;">
	이름을 변경하시겠습니까?
	</font>
	<br /><br />
	<input name="fname" placeholder="이름">
	<input name="lname" placeholder="성(性)">
	<br /><br />
	<textarea rows="3" cols="30" name="reason" placeholder="사유"></textarea>
	<br /><br />
	<input type="submit" value="변경신청" class="btn btn-success" style="width:130px; height:30px" >
	<input type="button" value="취  소" class="btn btn-success" onclick="closeName()" style="width:130px; height:30px" >
</div>


<div id="M_ID" style="display:none;">
	<br /><br />
	<font style="font-size:110%; font-weight:bold;">
	아이디를 변경하시겠습니까?
	</font>
	<br /><br />
	<input name="id" placeholder="아이디">
	<br /><br />
	<textarea rows="3" cols="30" name="reason" placeholder="사유"></textarea>
	<br /><br />
	<input type="submit" value="변경신청" class="btn btn-success" style="width:130px; height:30px" >
	<input type="button" value="취  소" class="btn btn-success" onclick="closeID()" style="width:130px; height:30px" >
</div>


<div id="M_Birth" style="display:none;">
	<br /><br />
	<font style="font-size:110%; font-weight:bold;">
	생일을 변경하시겠습니까?
	</font>
	<br /><br /> 
		<select name="year" id="year">
			<option>년도</option>
			<c:forEach var="i" begin="1905" end="2016" step="1">
				<option>${i}</option>
			</c:forEach>
		</select> 
		
		<select name="month" id="month">
			<option>월</option>
			<c:forEach var="i" begin="1" end="12" step="1">
				<option>${i}</option>
			</c:forEach>
		</select> 
		
		<select name="date" id="date">
			<option>일</option>
			<c:forEach var="i" begin="1" end="31" step="1">
				<option>${i}</option>
			</c:forEach>
		</select> 
		<br /><br />
	<textarea rows="3" cols="30" name="reason" placeholder="사유"></textarea>
	<br /><br />
	<input type="submit" value="변경신청" class="btn btn-success" style="width:130px; height:30px" >
	<input type="button" value="취  소" class="btn btn-success" onclick="closeBirth()" style="width:130px; height:30px" >
</div>

<div id="M_Gender" style="display:none;">
	<br /><br />
	<font style="font-size:110%; font-weight:bold;">
	성별을 변경하시겠습니까?
	</font>
	<br /><br />
	<input type="radio" name="gender" value="M"> 남성&nbsp;&nbsp;
	<input type="radio" name="gender" value="F"> 여성&nbsp;&nbsp;
	<input type="radio" name="gender" value="U"> 기타
	<br /><br />
	<textarea rows="3" cols="30" name="reason" placeholder="사유"></textarea>
	<br /><br />
	<input type="submit" value="변경신청" class="btn btn-success" style="width:130px; height:30px" >
	<input type="button" value="취  소" class="btn btn-success" onclick="closeGender()" style="width:130px; height:30px" >
</div>



<div style="margin-top:0px; width:90%; height:5px; margin-left:5%; background-color:#EAEAEA;"></div>
<div style="margin-top:50px; width:90%; height:auto; margin-left:5%; background-color:#FFFFFF;">
<br />
<font style="font-size:140%; font-weight:bold;">
&nbsp;&nbsp;프로필 수정
</font>
<hr width="100%"><br />
<center>
	<form class="signup" action="/MyUsed/MyUsedJoinPro.nhn" method="post" name="userinput" onSubmit="return checkIt()">

		<input class="signup_name" size="45" type="text" name="signup_lname" id="signup_lname" value="${memDTO.name}" onfocus="openName()"> <br /> <br />
		<input class="signup_input" size="45" type="text" name="signup_id" id="signup_id" value="${memDTO.id}" onfocus="openID()"> <br /> <br />
		<input class="signup_input" size="46" type="password" name="signup_pw" id="signup_pw" placeholder="새 비밀번호" onfocus="alert('pw을 변경하시겠습니까?')">
            
        <br />
        <p style="font-size: 18px; color: #000; padding-top: 8px;">생일</p>
            <!-- small width -->
            <table>
              <tbody>
                <tr>
                  <!-- birth -->
                  <td>
                  
                  <select name="year" id="year" onfocus="openBirth()">
                    <option>년도</option>
                    <c:forEach var="i" begin="1905" end="2016" step="1">
                    	<option>${i}</option>
                    </c:forEach>
                  </select>
                  
                  <select name="month" id="month" onfocus="openBirth()">
                    <option>월</option>                    
                    <c:forEach var="i" begin="1" end="12" step="1">
                    	<option>${i}</option>
                    </c:forEach>
                  </select>
                  
                  <select name="date" id="date" onfocus="openBirth()">
                    <option>일</option>
                    <c:forEach var="i" begin="1" end="31" step="1">
                    	<option>${i}</option>
                    </c:forEach>
                  </select>
                  
                  </td>
                  <!-- /birth -->
                  
                </tr>
                <tr>
                  <td align="center">
                  
                  <br />
       			 <p style="font-size: 18px; color: #000; padding-top: 8px;">성별</p>
                  
                  &nbsp;&nbsp;<input type="radio" name="gender" id="gender" value="F" onfocus="openGender()">&nbsp;<span style="color: #000; font-size: 12px;">여성</span>
                    &nbsp;&nbsp;&nbsp;<input type="radio" name="gender" id="gender" value="M" onfocus="openGender()"><span style="color: #000; font-size: 12px;">&nbsp;남성</span></td>
                  <td></td>
                </tr>
                
              </tbody>
            </table> <br /><br />
		<input id="button" type="button" value="비밀번호 변경" class="btn btn-success" style="width:180px; height:50px" >
	</form>

<br /><br />
</center>
</div>










</body>
</html>