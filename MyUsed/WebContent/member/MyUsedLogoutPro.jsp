<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 네이버 로그인인 경우:네이버 로그아웃 후 로그인 페이지로 -->
<c:if test="${naverId != 0}">
	<script type="text/javascript">
		window.onload = function() {
		/*    console.log("체크:",checklogout);
		   if(checklogout=="Y"){ */
		      deleteNaverInfo();
		/*    }
		   // callback이 오면 checkLoginState()함수를 호출한다.
		   else{/* checkLoginState(); }*/ 

		}
		function deleteNaverInfo() {
		   console.log("=====로그아웃들어옴========================================"); 
		   log("<로그아웃전>",access_token,refresh_token,state_token);

		   
		/*    naver.logout(tokenInfo.access_token); */
		   naver.logout($.cookie("access_token"),function(data){
		      var response = data._response.responseJSON;
		      console.log("=====로그아웃 후 콜백들어옴========================================"); 
		       access_token= response.access_token;
		       refresh_token= response.refresh_token;
		       state_token=  $.cookie("state_token");
		      
		      log("<네이버 로그아웃후>",access_token,refresh_token,state_token);
		      
		      $.removeCookie("state_token");
		      /* $.removeCookie("refresh_token");
		      $.removeCookie("access_token"); */
		      
		/*       access_token= $.cookie("access_token");
		      refresh_token= $.cookie("refresh_token"); */
		      state_token= $.cookie("state_token");
		      log("<쿠키 삭제후>",access_token,refresh_token,state_token);
		      
		      
		      /*세션 넣고 index페이지로 다시 보내주기 */
		      /* var url ='/usMemo/index';
		         window.open(url, "_self",  '');  */
		         window.location="/MyUsed/MyUsedLogin.nhn";

		   });
		}
   	</script>
</c:if>

<!-- 네이버 로그인이 아닌 경우:로그인페이지로 바로 리다이렉트 -->
<c:if test="${naverId == 0}">
	<meta http-equiv="Refresh" content="0;url=/MyUsed/MyUsedLogin.nhn">
</c:if>