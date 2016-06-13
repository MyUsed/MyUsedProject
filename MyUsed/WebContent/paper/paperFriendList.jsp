<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>
	// 친구목록에 체크된 radio버튼 값(친구의id)을 1개 가져오는 함수
	function swap(){
		var length = friend.Fradio.length;	// radio버튼의 길이
		var bool = false;	// if문을 돌리기위한 변수
		
		for(var i=0; i<length; i++){	// radio버튼 길이만큼 실행
			if(friend.Fradio[i].checked){	// radio버튼이 1개라도 체크되있을때
				var radioV = friend.Fradio[i].value;	// 체크된 값을 radioV변수에 넣음
				bool = true;
				break;
			}
			else{
				bool = false;
			}
		}
		if(bool == true){
			opener.document.pform.r_name.value = radioV;	// 친구의 id값(radioV)을 text에 출력.
			bool = false;
			self.close();
		}
			
		else{
			alert("친구를 체크해주세요.");
		}
		
	}
</script>

<center>
<form name="friend" method="post" onsubmit="swap()">
<table>

	<tr>
		<td align="right">
			<input type="submit" value="입력"/>
		</td>
	</tr>

	<c:forEach var="list" items="${list}">
		<tr>
			<td>
				<input type="radio" name="Fradio" value="${list.id}">${list.id}(${list.name})
			</td>
		</tr>
	</c:forEach>
	
	
</table>
</form>
</center>