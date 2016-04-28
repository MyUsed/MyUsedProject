<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />

<html lang="ko">
<head>
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
			background-color:#4c6396;
		}
	</style>
</head>

<body>
	<div id="layer_fixed">
		<table cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
		<tr>
			<td style="vertical-align:left; padding-left: 110px; padding-right: 0px;">
			<font size="6">My Used</font>
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

          <form class="navbar-form navbar-left">
          

            <div class="form-group">

              <input type="text" placeholder="Email" class="form-control">

            </div>

            <div class="form-group">

              <input type="password" placeholder="Password" class="form-control">

            

            <button type="submit" class="btn btn-success">Sign in</button>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" class="btn btn-success">네이버로 로그인</button>
            <button type="button" class="btn btn-success">페이스북으로 로그인</button>
			</div>
          </form>

        </div>        
     </div>
			</td>		
		</tr>
	
		</table>
	
<style type="text/css">
#sidebannerR { position:fixed; top:50px; left:40%; margin-left:30px; width:800px; height:700px; background:#EAEAEA; }
#sidebannerL { position:fixed; top:50px; right:45%; margin-right:30px; width:800px; height:700px; background:#EAEAEA; }

</style> 
</head>


<div id="sidebannerR">
	<center>
	<br/> <br /> <br />
 	<font size="7">가입하기</font>
 	  <div class="img_area">
           
          <p style="font-size: 18px; line-height: 200%;">항상 지금처럼 무료로 즐기실 수 있습니다.</p>
          <form class="signup" action="" method="post">
            <input class="signup_name" type="text" name="signup_lname" placeholder="성(姓)">
            <input class="signup_name" type="text" name="signup_fname" placeholder="이름(성은 제외)"> <br /> <br />
            <input class="signup_input" size="45" type="text" name="signup_id" placeholder="이메일 또는 휴대폰 번호"> <br /> <br />
            <input class="signup_input" size="45" type="text" name="signup_idchk" placeholder="이메일 또는 휴대폰 번호 재입력"> <br /> <br />
            <input class="signup_input" size="46" type="password" name="signup_pw" placeholder="새 비밀번호">
            <p style="font-size: 18px; color: #000; padding-top: 8px;">생일</p>
            <!-- small width -->
            <table>
              <tbody>
                <tr>
                  <!-- birth -->
                  <td>
                  <select class="signup_birth" name="">
                    <option value="">연도</option>
                    <option value="">2016</option>
                  </select>
                  <select class="signup_birth" name="">
                    <option value="">월</option>
                    <option value="">12월</option>
                  </select>
                  <select class="signup_birth" name="">
                    <option value="">일</option>
                    <option value="">31</option>
                  </select></td>
                  <!-- /birth -->
                  
                </tr>
                <tr>
                  <td>&nbsp;&nbsp;<input type="radio" name="gender" value="F">&nbsp;<span style="color: #000; font-size: 12px;">여성</span>
                    &nbsp;&nbsp;&nbsp;<input type="radio" name="gender" value="M"><span style="color: #000; font-size: 12px;">&nbsp;남성</span></td>
                  <td></td>
                </tr>
                
              </tbody>
            </table> <br /><br /><br />
            <input type="submit" value="가입하기">
            
   	</center>
   	
   	
   	
</div>
<div id="sidebannerL">
    <center>
 	<font size="5">사이드고정L</font>
   	</center>
</div>
</body>

	
