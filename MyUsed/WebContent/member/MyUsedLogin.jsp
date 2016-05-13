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
	
	<!-- 네이버 로그인 관련 import -->
	<script type="text/javascript" src="/MyUsed/member/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="/MyUsed/member/jquery.cookie.js"></script>
    <script type="text/javascript" src="/MyUsed/member/naverLogin.js"></script>
 
<script type="text/javascript">



    function generateState() {
        // CSRF 방지를 위한 state token 생성 코드
        // state token은 추후 검증을 위해 세션에 저장 되어야 합니다.
        var oDate = new Date();
        return oDate.getTime();
    }
    function saveState(state) {
        $.removeCookie("state_token");
        $.cookie("state_token", state);
    }
    var naver = NaverAuthorize({
        client_id : "qMD7f0qkqenQGghOLdVc",
        //redirect_uri : "http://192.168.35.247:8000/test/login.nhn",	//데탑
        redirect_uri : "http://127.0.0.1:8000/MyUsed/MyUsedLogin.nhn",	//학원
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
 // callback이 오면 checkLoginState()함수를 호출한다.
        checkLoginState();
    }

    var tokenInfo = { access_token:"" , refresh_token:"" };
    function checkLoginState() {
    state = $.cookie("state_token");
    if(naver.checkAuthorizeState(state) === "connected") {
        //정상적으로 Callback정보가 전달되었을 경우 Access Token발급 요청 수행
        naver.getAccessToken(function(data) {

            /* var  */response = data._response.responseJSON;
            if(response.error === "fail") {
                //access token 생성 요청이 실패하였을 경우에 대한 처리
                return ;
            }
            tokenInfo.access_token = response.access_token;
            tokenInfo.refresh_token = response.refresh_token;

            //sonsole.log에 나온다.
            console.log("success to get access token", response);
            
            accesstoken = tokenInfo.access_token ;

            /**사용자 정보 추출 */
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
            
            
            /** 파라미터 전달 */
          	str1 = "&id="+id.toString();
            str2 = "&name="+name.toString();
            str3 = "&gender="+gender.toString();
            str4 = "&birthday="+birthday.toString();
            str5 = "&accesstoken="+accesstoken.toString();
            //urladd = "http://192.168.35.247:8000/test/main.nhn?email="+email.toString(); //데탑
            urladd = "http://127.0.0.1:8000/MyUsed/MyUsedNaverLoginPro.nhn?email="+email.toString();	//학원
            window.location=urladd + str1 + str2 + str3 + str4 + str5; 
             
            });

        });
    } else {
        //Callback으로 전달된 데이터가 정상적이지 않을 경우에 대한 처리
        return ;
    }

}
    

 </script>	
 
 <script type="text/javascript">
 function checkIt() {
     var userinput = eval("document.userinput");
     if(!userinput.signup_lname.value) {
         alert("성(姓)를 입력하세요");
         return 0;
     }

     if(!userinput.signup_fname.value) {
         alert("이름을 입력하세요");
         return 0;
     }
     if(!userinput.signup_pw.value ) {
         alert("비밀번호를 입력하세요");
         return 0;
     }
     if(!userinput.signup_id.value ) {
         alert("아이디를 입력하세요");
         return 0;
     }
     
     if(userinput.signup_id.value != userinput.signup_idchk.value)
     {
         alert("아이디를 동일하게 입력하세요");
         return false;
     }
     if(!userinput.year.value )
     {
         alert("년도를 입력하세요");
         return false;
     }
     if(!userinput.month.value )
     {
         alert("생일을 입력하세요");
         return false;
     }
     if(!userinput.date.value )
     {
         alert("생일을 입력하세요");
         return false;
     }
     if(!userinput.gender.value )
     {
         alert("성별을 입력하세요");
         return false;
     }
 }
 </script>
 
  <script type="text/javascript">
    $(document).ready(function(){		//onload이벤트같은것(시작하자마자 바로 동작)
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
 	        data: {	// url 페이지도 전달할 파라미터
 	        	signup_lname : $('#signup_lname').val(),
        		signup_fname : $('#signup_fname').val(),
        		signup_id : $('#signup_id').val(),
        		signup_pw : $('#signup_pw').val(),
        		year : $('#year').val(),
        		month : $('#month').val(),
        		date : $('#date').val(),
        		gender : $('#gender').val() 
	        }, 
	        success: test,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
     	});
    }
    function test(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
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
            <button type="button" onClick="loginNaver()" class="btn btn-success">네이버로 로그인</button>
            <button type="button" class="btn btn-success">페이스북으로 로그인</button>
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
 	<font size="7"><b>가입하기</b></font>
 	  <div class="img_area">
           
          <p style="font-size: 18px; line-height: 200%;">항상 지금처럼 무료로 즐기실 수 있습니다.</p>
          <form class="signup" action="/MyUsed/MyUsedJoinPro.nhn" method="post" name="userinput" onSubmit="return checkIt()">
            <input class="signup_name" type="text" name="signup_lname" id="signup_lname" placeholder="성(姓)">
            <input class="signup_name" type="text" name="signup_fname" id="signup_fname" placeholder="이름(성은 제외)"> <br /> <br />
            <input class="signup_input" size="45" type="text" name="signup_id" id="signup_id" placeholder="이메일 또는 휴대폰 번호"> <br /> <br />
            <input class="signup_input" size="45" type="text" name="signup_idchk" placeholder="이메일 또는 휴대폰 번호 재입력"> <br /> <br />
            <input class="signup_input" size="46" type="password" name="signup_pw" id="signup_pw" placeholder="새 비밀번호">
            <p style="font-size: 18px; color: #000; padding-top: 8px;">생일</p>
            <!-- small width -->
            <table>
              <tbody>
                <tr>
                  <!-- birth -->
                  <td>
                  
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
                  
                  </td>
                  <!-- /birth -->
                  
                </tr>
                <tr>
                  <td>&nbsp;&nbsp;<input type="radio" name="gender" id="gender" value="F">&nbsp;<span style="color: #000; font-size: 12px;">여성</span>
                    &nbsp;&nbsp;&nbsp;<input type="radio" name="gender" id="gender" value="M"><span style="color: #000; font-size: 12px;">&nbsp;남성</span></td>
                  <td></td>
                </tr>
                
              </tbody>
            </table> <br /><br />
            <!-- <input type="submit" value="가입하기"> -->
            <font size="2">
            	가입하기 버튼을 클릭하면 약관에 동의하며 쿠키 사용을 포함한 <br />
            	데이터 정책을 읽고 이해하신 것으로 간주됩니다.<br /><br /><br />
            </font><!-- onClick="return checkIt()"  -->
	     	<input id="button" type="button" value="가입하기" class="btn btn-success" style="width:180px; height:50px" >
            </form>
   	</center>
   	
 
   	</div>
</div>
<div id="sidebannerL">

    <br /> <br />
   
    <center>
 	<img src="/MyUsed/images/LoginMap.png" width="330" height="100"/> <br /><br />
 	
 	
    <font size="5" color="#0E385F" face="Comic Sans MS">MyUsed 에서 전세계에 있는 지인들과<br/> 
  		함께 자유롭게 거래하세요.</font>
 	
 	    
 	<img src="/MyUsed/images/LoginBox.png" width="550" height="300"/>
 		</center>
   	
</div>
</body>

	
