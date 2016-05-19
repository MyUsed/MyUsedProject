<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!-- 전체체크박스 -->
<script>
	function CheckAll(){
		var chk = document.getElementsByName("check");	// checkbox의 name을 담을 변수
		var length = chk.length;	// checkbox의 길이
		var check = "";		// true면 체크, false면 해제
		if(paper.checkall.checked == true){	// 모두체크가 true면 
			check = false;	//checkbox 전부 체크
		}
		else{	// 모두체크가 false면
			check = true;	// checkbox 전부 체크 해제
		}
			if(check == false){
				for(var i=0; i<chk.length;i++){		// checkbox의 길이만큼 동작
					chk[i].checked = true;    		//모두 체크
				}	
			}
			else{
				for(var i=0; i<chk.length;i++){ 	// checkbox의 길이만큼 동작
						chk[i].checked = false;     //모두 해제
					}
				}
	}
	// checkbox가 전부 체크 됐을 때  모두체크에 체크
	function CheckOne(){
		var length = paper.check.length;	// checkbox의 길이
		var cnt = 0;	
			for(var i=0; i<length; i++){
				if(paper.check[i].checked == true){	// checkbox가 체크 될 때마다 cnt 증가
					cnt++;
					if(cnt == length){	// cnt와 checkbox의 길이가 같으면 모두체크를 체크
						paper.checkall.checked = true;
					}
				}
			}
	}
</script>

<script>
	function confirmB(){
		if(confirm("삭제 하시겠습니까?") == true){
			
		}
		else{
			return false;
		}
	}
</script>

<form name="paper" method="post" action="paperDelete.nhn?mynum=${mynum}" onsubmit="return confirmB()">
	<center>
	    <table width="600">
	    
	    	<tr>
	    		<td colspan="4"><hr color="#BDBDBD"></td>
	    	</tr>
	    
	    	<tr align="center">
	    		<td><input type="submit" value="삭제"/></td>
	    		
	    		<td>
	    			<input type="button" value="쪽지쓰기" onclick="javascript:window.location='paperForm.nhn?mynum=${mynum}'"/>
	    		</td>
	    		
				<td align="right">안 읽은 쪽지 ${paperCount}개</td>
				
			</tr>
			
			<tr>
				<td colspan="4"><hr color="#BDBDBD"></td>
			</tr>
			
		    	<tr>
		    		<td align="center" width="5%"><input type="checkbox" name="checkall" onclick="CheckAll()"/></td>
		    		<td width="25%">보낸사람</td>
		    		<td width="60%">내용</td>
		    		<td width="10%">날짜</td>
		    	</tr>
	    				
	    	<c:forEach var="list" items="${list}">
	    		<tr>
	    			<td align="center"><input type="checkbox" name="check" value="${list.m_no}" onclick="CheckOne()"/></td>
	    			<td><a href="paperForm.nhn?mynum=${mynum}&name=${list.s_name}">${list.s_name}</a></td>
	    			<td><a href="paperView.nhn?m_no=${list.m_no}">
	    			<!-- list.s_content의 길이가 15보다 크면 14번째 자리 + ... 로 출력 -->
	    			<c:if test="${fn:length(list.s_content) > 15}">
	    				${fn:substring(list.s_content,0,14)}...
	    			</c:if>
					<!-- list.s_content의 길이가 15보다 작으면 정상적으로 출력 -->
					<c:if test="${fn:length(list.s_content) < 15}">
	    				${list.s_content}
	    			</c:if>
					</a>
	    				<c:if test="${list.state == 1}">
	    					(1)
	    				</c:if>
	    			</td>
	    			<td>${list.reg}</td>
	    		</tr>
	    	</c:forEach>
	    	
	    		<tr>
	    			<td colspan="4" align="center">${pagingHtml}</td>
	    		</tr>
	    	
	    		<tr>
	    			<td colspan="4"><hr color="#BDBDBD"></td>
	    		</tr>
	    		
	    </table>
    </center>
</form>