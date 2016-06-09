<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="/MyUsed/main/script.js"></script>
<script src="/MyUsed/main/jquery-1.11.3.js"></script>
<script src="/MyUsed/main/modal.js"></script>

<meta charset="utf-8">
<script type="text/javascript">
	function deleteCheck() {
		if (confirm("정말로 삭제하시겠습니까?") == true) {

		} else {
			event.preventDefault();
		}
	}
</script>
<!-- //@쓰고 이름쓰면 자동으로 검색하는 기능
<script type="text/javascript">
	function findteg(){
		if(event.keyCode != null){
			var reple = document.getElementById('reple').value;
			console.log("reple : ", reple);
			var start = reple.indexOf('@')+1;
			var end = start+reple.indexOf(' ')+1;
			var name = reple.substring(start, end);
			console.log("start num : ", start);
			console.log("end num : ", end);
			console.log("name : ", name);
			
			$.ajax({
		        type: "post",
		        url : "/MyUsed/findname.nhn?name="+name,
		        success: findname,	// 페이지요청 성공시 실행 함수
		        error: whentegError	//페이지요청 실패시 실행함수
	  		});
			
		}
	}
	function findname(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
		//alert(name);
		console.log(name);
	    $("#findname").html(aaa);
	}
	function whentegError(){
	    alert("name teg error");
	}
</script>
 -->
<body>

<br /> 


<form action="replesubmit.nhn" method="post" >

	<input type="hidden" name="boardnum" value="${num}"/>
	<input type="hidden" name="content" value="${content}"/>

	<table align="center"  width="90%" height="60"  bgcolor="#FFFFFF" >
	<c:if test="${replelist != null}">
	<c:forEach var="replelist" items="${replelist}">
	<tr> 
		<td width="15%">
			<a  href="/MyUsed/MyUsedMyPage.nhn?mem_num=${replelist.mem_num}"> 
				<font face="Comic Sans MS" size="3" color="#4565A1">${replelist.name}&nbsp;</font>
			</a>
			
	<script type="text/javascript">
	$(document).ready(function(){
		var content = document.getElementById('reple_${replelist.seq_num}').innerHTML;
		var splitedArray = content.split(' ');	// 공백을 기준으로 자름
		var resultArray = [];	//최종 결과를 담을 배열을 미리 선언함
		
		// 공백을 기준으로 잘린 배열의 요소들을 검색함
		for(var i = 0; i < splitedArray.length ; i++){
			// 그 중 <br>이 포함되어있는 배열의 요소가 있다면
			if(splitedArray[i].indexOf('<br>') > -1){
				
				// <br> 기준으로 잘라 임시 배열인 array에 넣는다 -> 이때 array의 길이는 2개 일 수 밖에 없음
				var array = splitedArray[i].split('<br>');
				// 이때 <br>이 #이 붙은 단어의 앞에 있을 수 도있고 뒤에 있을 수도 있기 때문에 indexOf를 이용해 위치를 판단한다.
				if(splitedArray[i].indexOf('<br>') < splitedArray[i].indexOf('@')){	//br이 앞에 있을경우
					resultArray[i] = array[0]+'<br>';	// array의 첫번째 요소에 <br>을 붙여준다
					resultArray[i+1] = array[1];
					i++;	//resultArray의 크기가 1 늘어났음으로 i를 ++해줌
				}else{	//br이 뒤에 있을경우
					resultArray[i] = array[0];
					resultArray[i+1] = '<br>'+array[1];	// array의 두번째 요소에 <br>을 붙여준다
					i++;	//resultArray의 크기가 1 늘어났음으로 i를 ++해줌
				}
			// <br>이 포함되지않은 요소들은 그냥 resultArray에 넣어준다.
			}else{
				resultArray[i] = splitedArray[i];
			}
		}
		var linkedContent = '';
		for(var word in resultArray)
		{
		  word = resultArray[word];
		   if(word.indexOf('@') == 0)
		   {
				var url = '"'+'/MyUsed/tegfriend.nhn?name='+word.split('@')+'&writer='+'${replelist.mem_num}'+'"';
			    word = '<a href='+url+'>'+word+'</a>';
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('reple_${replelist.seq_num}').innerHTML = linkedContent; 
	});
	</script>
	
		</td>
		<td width="80%">
			<div id="reple_${replelist.seq_num}">${replelist.content}</div> 
 		</td>
 			
		<td width="5%">
 			<c:if test="${session_num == replelist.mem_num}">
 				<a href="repleDelete.nhn?seq_num=${replelist.seq_num}&boardnum=${num}" onclick="javasciprt:deleteCheck()">
					<img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 0.5em;" align="right" width="15"  height="15" title="삭제하기"/>
 				</a>
 			</c:if>
 			<br/>
		</td>
	<tr>
		<td colspan="3">
			<font size="2" color="#9A9DA4">
  				<fmt:formatDate value="${replelist.reg}" type="both" /> 
 			</font>
			<br />
		</td>
	</tr>
	</c:forEach>
	</c:if>
	<tr>
 		<td colspan="3">
			<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${session_num}">
				<img src="/MyUsed/images/profile/${proDTO.profile_pic}" align="left" width="40"  height="35"/>
			</a>
			<input style="padding:7px;" type="text" id="reple" name="reple" size="50" placeholder="댓글을 입력하세요..."/> <!--  onkeydown="findteg()"  -->
			<input type="image" src="/MyUsed/images/submitReple.png" width="30" height="20" title="댓글달기"/>
			
		</td>
	</tr>
	</table>
	<br />
</form>


</body>