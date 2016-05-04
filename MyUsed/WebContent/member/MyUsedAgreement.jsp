<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="facebookstyle.css" />

<script type="text/javascript">

function checkIt() {
    var agree = eval("document.agree");
    if(!agree.text1.value) {
        alert("데이터 정책 약관에 동의해주세요");
        return false;
    }

    if(!agree.text3.value) {
        alert("권리 및 책임에 관한 정책 약관에 동의해주세요");
        return false;
    }
    if(!agree.text3.value ) {
        alert("위치 기반 기능 정책 약관에 동의해주세요");
        return false;
    }
}

function back(){
	history.back(-1);
}

</script>



<center>
<form action="/MyUsed/MyUsedJoinPro.nhn" method="post" name="agree" onSubmit="return checkIt()">

	<input type="hidden" value="${signup_lname}" name="signup_lname">
	<input type="hidden" value="${signup_fname}" name="signup_fname">
	<input type="hidden" value="${signup_id}" name="signup_id">
	<input type="hidden" value="${signup_pw}" name="signup_pw">
	<input type="hidden" value="${year}" name="year">
	<input type="hidden" value="${month}" name="month">
	<input type="hidden" value="${date}" name="date">
	<input type="hidden" value="${gender}" name="gender">
	
<br /><br /><br />
	<font size="7"><b>가입하기</b></font>
	<p style="font-size: 18px; line-height: 200%;">항상 지금처럼 무료로 즐기실 수 있습니다.</p>
	
	<table border="1" bordercolor="#FF2424">
	<tr height="30" >
		<td bgcolor="#FFB9B9" width="400" align="center">
			<font color="#003399">이용약관</font> 및 
			<font color="#003399">개인정보취급방침</font>에 동의하셔야 합니다.
		</td>
	</tr>
	</table>
	<br />
	
    <table>
	
	<tr>
		<td align="left">
			<textarea name="text1" rows="3" cols="50">aaa
			</textarea>
			<br />
			<input type=radio name="text1" id="text1">
			MyUsed의 데이터 정책에 동의합니다
			<br /><br />
	
			<textarea name="text1" rows="3" cols="50">bbb
			</textarea>
			<br />
			<input type=radio name="text2" id="text2">
			MyUsed의 권리 및 책임에 관한 정책에 동의합니다
			<br /><br />
	
			<textarea name="text1" rows="3" cols="50">ccc
			</textarea>
			<br />
			<input type=radio name="text3" id="text3">
			MyUsed의 위치 기반 기능 정책에 동의합니다
			<br />
		</td>
	</tr>
	<tr height="40">
		<td>
		<a href="/MyUsed/MyUsedLogin.nhn">
			◀ 돌아가기
		</a>
		</td>
	</tr>
	<tr>
		<td align="center">
		<input type="submit" value="가입하기" class="btn btn-success" style="width:180px; height:50px" >
		</td>
	</tr>
	</table>
	
</form>
</center>