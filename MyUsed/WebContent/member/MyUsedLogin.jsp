<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />

<c:if test="${sessionScope.memId != null}">
	<meta http-equiv="Refresh" content="0;url=/MyUsed/MyUsed.nhn">
</c:if>

<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<title>MyUsed</title>
	
	<!-- ���̹� �α��� ���� import -->
	<script type="text/javascript" src="/MyUsed/member/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/MyUsed/member/jquery.cookie.js"></script>
    <script type="text/javascript" src="/MyUsed/member/naverLogin.js"></script>
 
<script type="text/javascript">



    function generateState() {
        // CSRF ������ ���� state token ���� �ڵ�
        // state token�� ���� ������ ���� ���ǿ� ���� �Ǿ�� �մϴ�.
        var oDate = new Date();
        return oDate.getTime();
    }
    function saveState(state) {
        $.removeCookie("state_token");
        $.cookie("state_token", state);
    }
    var naver = NaverAuthorize({
        client_id : "qMD7f0qkqenQGghOLdVc",
        //redirect_uri : "http://192.168.35.247:8000/test/login.nhn",	//��ž
        redirect_uri : "http://127.0.0.1:8000/MyUsed/MyUsedLogin.nhn",	//�п�
        client_secret : "QF4E_FPwax"
    });


     function loginNaver() {
        var state = generateState();
        saveState(state);
        naver.login(state);
    }

    $("#NaverIdLoginBTN").click( function () {
        var state = generateState();
        saveState(state);
        naver.login(state);
    });
</script>
<script type="text/javascript">

	var accesstoken;
	var response;
	var state;

    window.onload=function(){
 // callback�� ���� checkLoginState()�Լ��� ȣ���Ѵ�.
        checkLoginState();
    }

    var tokenInfo = { access_token:"" , refresh_token:"" };
    function checkLoginState() {
    state = $.cookie("state_token");
    if(naver.checkAuthorizeState(state) === "connected") {
        //���������� Callback������ ���޵Ǿ��� ��� Access Token�߱� ��û ����
        naver.getAccessToken(function(data) {

            /* var  */response = data._response.responseJSON;
            if(response.error === "fail") {
                //access token ���� ��û�� �����Ͽ��� ��쿡 ���� ó��
                return ;
            }
            tokenInfo.access_token = response.access_token;
            tokenInfo.refresh_token = response.refresh_token;

            //sonsole.log�� ���´�.
            console.log("success to get access token", response);
            
            accesstoken = tokenInfo.access_token ;

            /**����� ���� ���� */
           	var URL = "https://apis.naver.com/nidlogin/nid/getUserProfile.json?response_type=json";
            naver.api(URL, tokenInfo.access_token, function(data) {
            var response = data._response.responseJSON;
            console.log("success to get user info|||", response);
           // alert(tokenInfo.access_token);
            console.log(response.response.email);
            console.log(response.response.id);
            console.log(response.response.name);
            console.log(response.response.gender);
            console.log(response.response.birthday);
            
            var email = response.response.email;
            var id = response.response.id;
            var name = response.response.name; 
            var gender = response.response.gender; 
            var birthday = response.response.birthday; 
            
            
            /** �Ķ���� ���� */
          	str1 = "&id="+id.toString();
            str2 = "&name="+name.toString();
            str3 = "&gender="+gender.toString();
            str4 = "&birthday="+birthday.toString();
            str5 = "&accesstoken="+accesstoken.toString();
            //urladd = "http://192.168.35.247:8000/test/main.nhn?email="+email.toString(); //��ž
            urladd = "http://127.0.0.1:8000/MyUsed/MyUsedNaverLoginPro.nhn?email="+email.toString();	//�п�
            window.location=urladd + str1 + str2 + str3 + str4 + str5; 
             
            });

        });
    } else {
        //Callback���� ���޵� �����Ͱ� ���������� ���� ��쿡 ���� ó��
        return ;
    }

}
    

 </script>	
 
 <script type="text/javascript">
 function checkIt() {
     var userinput = eval("document.userinput");
     if(!userinput.signup_lname.value) {
         alert("��(��)�� �Է��ϼ���");
         return 0;
     }

     if(!userinput.signup_fname.value) {
         alert("�̸��� �Է��ϼ���");
         return 0;
     }
     if(!userinput.signup_pw.value ) {
         alert("��й�ȣ�� �Է��ϼ���");
         return 0;
     }
     if(!userinput.signup_id.value ) {
         alert("���̵� �Է��ϼ���");
         return 0;
     }
     
     if(userinput.signup_id.value != userinput.signup_idchk.value)
     {
         alert("���̵� �����ϰ� �Է��ϼ���");
         return false;
     }
     if(!userinput.year.value )
     {
         alert("�⵵�� �Է��ϼ���");
         return false;
     }
     if(!userinput.month.value )
     {
         alert("������ �Է��ϼ���");
         return false;
     }
     if(!userinput.date.value )
     {
         alert("������ �Է��ϼ���");
         return false;
     }
     if(!userinput.gender.value )
     {
         alert("������ �Է��ϼ���");
         return false;
     }
 }
 </script>
 
  <script type="text/javascript">
    $(document).ready(function(){		//onload�̺�Ʈ������(�������ڸ��� �ٷ� ����)
      $("#button").click(function(){
    	  if(checkIt() != false){
              callAjax();    		  
    	  }
      });
    });
    function callAjax(){
        $.ajax({
	        type: "post",
	        url : "/MyUsed/MyUsedAgreement.nhn",
 	        data: {	// url �������� ������ �Ķ����
 	        	signup_lname : $('#signup_lname').val(),
        		signup_fname : $('#signup_fname').val(),
        		signup_id : $('#signup_id').val(),
        		signup_pw : $('#signup_pw').val(),
        		year : $('#year').val(),
        		month : $('#month').val(),
        		date : $('#date').val(),
        		gender : $('#gender').val() 
	        }, 
	        success: test,	// ��������û ������ ���� �Լ�
	        error: whenError	//��������û ���н� �����Լ�
     	});
    }
    function test(aaa){	// ��û������ ������������ aaa ������ �ݹ�ȴ�. 
        $("#sidebannerR").html(aaa);
        console.log(resdata);
    }
    function whenError(){
        alert("Error");
    }
  </script>
 
 
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
			background-color:#4c6396;
		}
	</style>
</head>

<body>
	<div id="layer_fixed">
		<table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
		<tr>
			<td style="vertical-align:left; padding-left: 110px; padding-right: 0px;">
			
			<a href="/MyUsed/MyUsedLogin.nhn"><img src="/MyUsed/images/Mlogo2.png" width=170 height="50"></a>
			</td>
			<td style="vertical-align:left; padding-left: 50px; padding-right: 0px;">
				
	

      <div class="container">

        <div class="navbar-header">

          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">

            

            <span class="icon-bar"></span>

            <span class="icon-bar"></span>

            <span class="icon-bar"></span>

          </button>

          

        </div>

        <div id="navbar" class="navbar-collapse collapse">

          <form class="navbar-form navbar-left" action="/MyUsed/MyUsedLoginPro.nhn">
          

            <div class="form-group">

              <input type="text" placeholder="Id" name="id" class="form-control">

            </div>

            <div class="form-group">

              <input type="password" placeholder="Password" name="pw" class="form-control">

            

            <button type="submit" class="btn btn-success">Sign in</button>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" onClick="loginNaver()" class="btn btn-success">���̹��� �α���</button>
            <button type="button" class="btn btn-success">���̽������� �α���</button>
			</div>
          </form>

        </div>        
     </div>
			</td>		
		</tr>
	
		</table>
	
<style type="text/css">
#sidebannerR { position:fixed; top:50px; left:50%; margin-left:35px; width:650px; height:700px; background:#EAEAEA; overflow:auto; }
#sidebannerL { position:fixed; top:50px; right:45%; margin-right:20px; width:750px; height:700px; background:#EAEAEA; }

</style> 
</head>


<div id="sidebannerR">
	<center>
	<br/> <br /> <br />
 	<font size="7"><b>�����ϱ�</b></font>
 	  <div class="img_area">
           
          <p style="font-size: 18px; line-height: 200%;">�׻� ����ó�� ����� ���� �� �ֽ��ϴ�.</p>
          <form class="signup" action="/MyUsed/MyUsedJoinPro.nhn" method="post" name="userinput" onSubmit="return checkIt()">
            <input class="signup_name" type="text" name="signup_lname" id="signup_lname" placeholder="��(��)">
            <input class="signup_name" type="text" name="signup_fname" id="signup_fname" placeholder="�̸�(���� ����)"> <br /> <br />
            <input class="signup_input" size="45" type="text" name="signup_id" id="signup_id" placeholder="�̸��� �Ǵ� �޴��� ��ȣ"> <br /> <br />
            <input class="signup_input" size="45" type="text" name="signup_idchk" placeholder="�̸��� �Ǵ� �޴��� ��ȣ ���Է�"> <br /> <br />
            <input class="signup_input" size="46" type="password" name="signup_pw" id="signup_pw" placeholder="�� ��й�ȣ">
            <p style="font-size: 18px; color: #000; padding-top: 8px;">����</p>
            <!-- small width -->
            <table>
              <tbody>
                <tr>
                  <!-- birth -->
                  <td>
                  
                  <select name="year" id="year">
                    <option>�⵵</option>
                    <c:forEach var="i" begin="1905" end="2016" step="1">
                    	<option>${i}</option>
                    </c:forEach>
                  </select>
                  
                  <select name="month" id="month">
                    <option>��</option>                    
                    <c:forEach var="i" begin="1" end="12" step="1">
                    	<option>${i}</option>
                    </c:forEach>
                  </select>
                  
                  <select name="date" id="date">
                    <option>��</option>
                    <c:forEach var="i" begin="1" end="31" step="1">
                    	<option>${i}</option>
                    </c:forEach>
                  </select>
                  
                  </td>
                  <!-- /birth -->
                  
                </tr>
                <tr>
                  <td>&nbsp;&nbsp;<input type="radio" name="gender" id="gender" value="F">&nbsp;<span style="color: #000; font-size: 12px;">����</span>
                    &nbsp;&nbsp;&nbsp;<input type="radio" name="gender" id="gender" value="M"><span style="color: #000; font-size: 12px;">&nbsp;����</span></td>
                  <td></td>
                </tr>
                
              </tbody>
            </table> <br /><br />
            <!-- <input type="submit" value="�����ϱ�"> -->
            <font size="2">
            	�����ϱ� ��ư�� Ŭ���ϸ� ����� �����ϸ� ��Ű ����� ������ <br />
            	������ ��å�� �а� �����Ͻ� ������ ���ֵ˴ϴ�.<br /><br /><br />
            </font><!-- onClick="return checkIt()"  -->
	     	<input id="button" type="button" value="�����ϱ�" class="btn btn-success" style="width:180px; height:50px" >
            </form>
   	</center>
   	
 
   	</div>
</div>
<div id="sidebannerL">

    <br /> <br />
   
    <center>
 	<img src="/MyUsed/images/LoginMap.png" width="330" height="100"/> <br /><br />
 	
 	
    <font size="5" color="#0E385F" face="Comic Sans MS">MyUsed ���� �����迡 �ִ� ���ε��<br/> 
  		�Բ� �����Ӱ� �ŷ��ϼ���.</font>
 	
 	    
 	<img src="/MyUsed/images/LoginBox.png" width="550" height="300"/>
 		</center>
   	
</div>
</body>

	
