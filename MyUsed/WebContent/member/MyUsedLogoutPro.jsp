<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- ���̹� �α����� ���:���̹� �α׾ƿ� �� �α��� �������� -->
<c:if test="${naverId != 0}">
	<script type="text/javascript">
		window.onload = function() {
		/*    console.log("üũ:",checklogout);
		   if(checklogout=="Y"){ */
		      deleteNaverInfo();
		/*    }
		   // callback�� ���� checkLoginState()�Լ��� ȣ���Ѵ�.
		   else{/* checkLoginState(); }*/ 

		}
		function deleteNaverInfo() {
		   console.log("=====�α׾ƿ�����========================================"); 
		   log("<�α׾ƿ���>",access_token,refresh_token,state_token);

		   
		/*    naver.logout(tokenInfo.access_token); */
		   naver.logout($.cookie("access_token"),function(data){
		      var response = data._response.responseJSON;
		      console.log("=====�α׾ƿ� �� �ݹ����========================================"); 
		       access_token= response.access_token;
		       refresh_token= response.refresh_token;
		       state_token=  $.cookie("state_token");
		      
		      log("<���̹� �α׾ƿ���>",access_token,refresh_token,state_token);
		      
		      $.removeCookie("state_token");
		      /* $.removeCookie("refresh_token");
		      $.removeCookie("access_token"); */
		      
		/*       access_token= $.cookie("access_token");
		      refresh_token= $.cookie("refresh_token"); */
		      state_token= $.cookie("state_token");
		      log("<��Ű ������>",access_token,refresh_token,state_token);
		      
		      
		      /*���� �ְ� index�������� �ٽ� �����ֱ� */
		      /* var url ='/usMemo/index';
		         window.open(url, "_self",  '');  */
		         window.location="/MyUsed/MyUsedLogin.nhn";

		   });
		}
   	</script>
</c:if>

<!-- ���̹� �α����� �ƴ� ���:�α����������� �ٷ� �����̷�Ʈ -->
<c:if test="${naverId == 0}">
	<meta http-equiv="Refresh" content="0;url=/MyUsed/MyUsedLogin.nhn">
</c:if>