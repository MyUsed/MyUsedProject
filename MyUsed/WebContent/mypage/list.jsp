<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<c:forEach var="list" items="${list}">	
<form name="reple" action="reple.nhn" method="post" >

	<div style="border:1px solid #BDBDBD;">
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${list.mem_num}"><font face="Comic Sans MS">( ${list.name} )</font></a>
		<font face="Comic Sans MS" size="2" color="#A6A6A6" > 님이 글을 게시하였습니다</font>  
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:if test="${list.mem_num == memDTO.num}">
		<a href="delete.nhn?num=${list.num}"><img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 1em;" width="20" height="20" align="right" title="게시글 삭제"/></a>
		</c:if>
		<hr width="100%" > 
		</td>
		</tr>
		
		<tr  bgcolor="#FFFFFF">
		<td align="center">
		<c:if test="${list.mem_pic != null}">
		<a href="reple.nhn?num=${list.num}">
		<img src="/MyUsed/images/${list.mem_pic}" width="470" height="300"/>
		</a>
		 <br/> <br />
		</c:if>
		<!-- 일반 게시글 해시태그 -->	
	<script type="text/javascript">
	$(document).ready(function(){
		var content = document.getElementById('listcontent_${list.num}').innerHTML;
		var splitedArray = content.split(' ');	// 공백을 기준으로 자름
		var resultArray = [];	//최종 결과를 담을 배열을 미리 선언함
		
		// 공백을 기준으로 잘린 배열의 요소들을 검색함
		for(var i = 0; i < splitedArray.length ; i++){
			// 그 중 <br>이 포함되어있는 배열의 요소가 있다면
			if(splitedArray[i].indexOf('<br>') > -1){
				
				// <br> 기준으로 잘라 임시 배열인 array에 넣는다 -> 이때 array의 길이는 2개 일 수 밖에 없음
				var array = splitedArray[i].split('<br>');
				// 이때 <br>이 #이 붙은 단어의 앞에 있을 수 도있고 뒤에 있을 수도 있기 때문에 indexOf를 이용해 위치를 판단한다.
				if(splitedArray[i].indexOf('<br>') < splitedArray[i].indexOf('#')){	//br이 앞에 있을경우
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
		   if(word.indexOf('#') == 0)
		   {
				var url = '"'+'/MyUsed/tegSearch.nhn?word='+word.split('#')+'"';
			    word = '<a href='+url+'>'+word+'</a>';
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('listcontent_${list.num}').innerHTML = linkedContent; 
	});
	</script>
		
		
		<div id="listcontent_${list.num}">${list.content}</div>
		
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"  > 
		
		<script type="text/javascript">
			/****** 리플열기 ******/
			function openreple${list.num}() {
				if(reple_${list.num}.style.display == 'block'){
				    $('#reple_${list.num}').slideUp();
				    $('#reple_${list.num}').attr('style', 'display:none;');
				    $('close_${list.num}').attr('style', 'display:none;');	//닫기버튼					
				}else{
				    $.ajax({
				        type: "post",
				        url : "/MyUsed/reple.nhn",
				        data: {	// url 페이지도 전달할 파라미터
				        	num : '${list.num}'
				        },
				        success: reple${list.num},	// 페이지요청 성공시 실행 함수
				        error: whenError_reple	//페이지요청 실패시 실행함수
				 	});
					
				}
			}
			function reple${list.num}(relist){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다.
			    $('#reple_${list.num}').attr('style', 'background:#FFFFFF; border:1px solid #D5D5D5; display:block;');
			    $('#close_${list.num}').attr('style', 'display:block;');	//닫기버튼
			    $('#reple_${list.num}').slideDown();	// 댓글 폼열기
			    $('#reple_${list.num}').html(relist);
			    console.log(resdata);
			}
			function whenError_reple(){
			    alert("리플 에러");
			}
/* 			function closereple${list.num}() {
			    $('#reple_${list.num}').slideUp();
			    $('#reple_${list.num}').attr('style', 'display:none;');
			    $('close_${list.num}').attr('style', 'display:none;');	//닫기버튼
			} */
		</script>
		
		좋아요  / 공유하기 / <%-- <a href="reple.nhn?num=${list.num}"> --%>
		<a onclick="javascript:openreple${list.num}()" style="cursor:pointer;">
			<img src="/MyUsed/images/reple.PNG" width="25" height="20"/>
			<font size="2" color="#9A9DA4">댓글 ${list.reples}개</font>
		</a><%-- 
		<a onclick="javascript:closereple${list.num}()" id="close_${list.num}"style="cursor:pointer; display:none;">
			<font size="2" color="#9A9DA4" >▼</font>
		</a> --%>
		</td>
		</tr>
				
		<tr bgcolor="#FFFFFF">
		<td>
		
		</td>
		</tr>
		

	</table>
		<!-- 일반 게시글 해시태그 -->	
	
	<div id="reple_${list.num}" style=" border:2px solid #000000; display:none;"></div>
	
	</div>


 	<br />	

		

</form>	 
</c:forEach>
