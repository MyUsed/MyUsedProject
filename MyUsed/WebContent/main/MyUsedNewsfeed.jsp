<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/MyUsed/main/script.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Newsfeed</title>
</head>
<body>

<br /><br />
<center>

<a onclick="javascript:openstate()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
<font style="font-weight:bold; font-size:120%">
	State </font>
</a> &nbsp;&nbsp;

<a onclick="javascript:openproduct()" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
<font style="font-weight:bold; font-size:120%">
	Product</font>
</a>

</center>

<br />




<div id="newsfeed" style="display:block;">

<c:if test="${newsfeed == null}">
<center>
 	<table align="center"  width="500" height="100" border="2" bordercolor="#FFFFA1">
 		<tr>
 			<td align="center" bgcolor="#FAED7D">
 				<font style="font-weight:bold; font-size:130%;">게시된 글이 없습니다.</font><br />
 				<font style="font-size:90%;" color="#5D5D5D">친구를 등록하여 새 글을 받아보세요! </font>
 			</td>
 		</tr>
 	</table>

</center>
</c:if>


<c:forEach var="list" items="${newsfeed}">	
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
			function openNreple${list.num}() {
				if(nreple_${list.num}.style.display == 'block'){
				    $('#nreple_${list.num}').slideUp();
				    $('#nreple_${list.num}').attr('style', 'display:none;');			
				}else{
				    $.ajax({
				        type: "post",
				        url : "/MyUsed/reple.nhn",
				        data: {	// url 페이지도 전달할 파라미터
				        	num : '${list.num}',
				        	page: 0
				        },
				        success: nreple${list.num},	// 페이지요청 성공시 실행 함수
				        error: whenError_reple	//페이지요청 실패시 실행함수
				 	});
					
				}
			}
			function nreple${list.num}(relist){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다.
			    $('#nreple_${list.num}').attr('style', 'background:#FFFFFF; border:1px solid #D5D5D5; display:block;');
			    $('#nreple_${list.num}').slideDown();	// 댓글 폼열기
			    $('#nreple_${list.num}').html(relist);
			    console.log(resdata);
			}
			function whenError_reple(){
			    alert("리플 에러");
			}
		</script>
		
		좋아요  / 공유하기 /
		<a onclick="javascript:openNreple${list.num}()" style="cursor:pointer;">
			<img src="/MyUsed/images/reple.PNG" width="25" height="20"/>
			<font size="2" color="#9A9DA4">댓글 ${list.reples}개</font>
		</a>
		</td>
		</tr>
				
		<tr bgcolor="#FFFFFF">
		<td>
		
		</td>
		</tr>
		

	</table>
		<!-- 일반 게시글 해시태그 -->	
	
	<div id="nreple_${list.num}" style=" border:2px solid #000000; display:none;"></div>
	
	</div>


 	<br />	

</c:forEach >
</div>






<!-- -------상품---------------------------------------------------------------------------------------------- -->


<div id="newsfeed_pro" style="display:none;">

<c:if test="${pronewsfeed == null}">
<center>
 	<table align="center"  width="500" height="100" border="2" bordercolor="#FFFFA1">
 		<tr>
 			<td align="center" bgcolor="#FAED7D">
 				<font style="font-weight:bold; font-size:130%;">게시된 상품이 없습니다.</font><br />
 				<font style="font-size:90%;" color="#5D5D5D">친구를 등록하여 새로 등록된 상품을 받아보세요! </font>
 			</td>
 		</tr>
 	</table>

</center>
</c:if>


<c:forEach var="prolist" items="${pronewsfeed}" varStatus="i">
	
 	<table align="center"  width="550" height="180">
		<tr	bgcolor="#FFFFFF">
		<td>
		<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${prolist.mem_num}"><font face="Comic Sans MS" >( ${prolist.name} )</font></a>
		<font face="Comic Sans MS" size="2" color="#A6A6A6" > 님이 상품을 게시하였습니다  </font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:if test="${prolist.mem_num == memDTO.num}">
		<a href="prodelete.nhn?num=${prolist.num}"><img src="/MyUsed/images/deleteIcon.PNG" style="margin-right: 1em;" width="20" height="20" align="right" title="게시글 삭제"/></a>
		</c:if>
		
		<hr width="100%" > 
		</td>
		</tr>
		
		<tr  bgcolor="#FFFFFF">
		<td align="center">
		
		<c:if test="${prolist.pro_pic != null}"> 
		<a href="ProductDetailView.nhn?num=${prolist.num}">
		<img src="/MyUsed/images/${prolist.pro_pic}" width="370" height="350" /> 
		</a>
		<br/>
		</c:if>
		
		
		 <font size="5" color="#1F51B7" >${prolist.price}</font> <br /><br />
		
		<font size="3" color="#0042ED" >
		-------------------------------- * 상세설명 * -------------------------------- 
		</font>
		<!-- 상품 게시글 해시태그 -->	
		<script type="text/javascript">
	$(document).ready(function(){
		var content = document.getElementById('procontent_${prolist.num}').innerHTML;
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
				var url = '"'+'/MyUsed/protegSearch.nhn?word='+word.split('#')+'"';
			    word = '<a href='+url+'>'+word+'</a>';
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('procontent_${prolist.num}').innerHTML = linkedContent; 
	});
	</script>
	
		 <br/>
		 <div id="procontent_${prolist.num}">${prolist.content}</div>
		
		</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
		<td>
		<hr width="100%"  > 
		
		
		좋아요 
		<input type="image" src="/MyUsed/images/chiceIcon.png" width="20" height="20" id="choiceB${i.count}" onclick="choiceAjax('${i.count}')" title="찜하기"/>
		<input type="hidden" name="num" id="num${i.count}" value="${prolist.num}" />
		<input type="hidden" name="mem_num" id="mem_num${i.count}" value="${prolist.mem_num}" />
		<input type="hidden" name="mem_name" id="mem_name${i.count}" value="${prolist.name}" />
		<input type="hidden" name="price" id="price${i.count}" value="${prolist.price}" />
		<input type="hidden" name="pro_pic" id="pro_pic${i.count}" value="${prolist.pro_pic}" />
		<input type="hidden" name="content" id="content${i.count}" value="${prolist.content}" /> 
		
		 <a href="ProductDetailView.nhn?num=${prolist.num}"><img src="/MyUsed/images/reple.PNG"/><font size="2" color="#9A9DA4">댓글 ${prolist.reples}개</font></a>
		
			<a href="ProductDetailView.nhn?num=${prolist.num}"><img align="right" style="padding:2px" src="/MyUsed/images/buyIcon.PNG" width="35" height="35" /></a>
			<div id="ajaxChoice"></div>
			
		</td>
		</tr>

	</table>
 	<br />	
 	

<!--  상품 보기 페이지  -->	
	 
</c:forEach>


</div>


</body>
</html>