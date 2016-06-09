<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/MyUsed/product/ProductView.css" />
<link rel="stylesheet" type="text/css" href="/MyUsed/main/main.css" />
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<head>

<script type="text/javascript">
function bigImage(pic){
	$.ajax({
			type : "post",
			url : "/MyUsed/ProBigImage.nhn",
			data : { // url 페이지도 전달할 파라미터
				pic : pic
			},
			success : Pic, // 페이지요청 성공시 실행 함수
			error : whenError
		//페이지요청 실패시 실행함수
		});
	}
	function Pic(view) { // 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
		$("#detailimg").html(view);
		console.log(resdata);
	}
	function whenError() {
		alert("Error");
	}
</script>


<title>상품</title>

<div id="layer_fixed"><jsp:include page="/main/layer_fixed.jsp"/></div> <!-- 상단 검색 Top -->

	<script>
	function deleteCheck(){
               if(confirm("정말로 삭제하시겠습니까?") == true){

               } 	else{
               	event.preventDefault();
             		  }
               }
      
	</script>

<script type="text/javascript">
$(document).ready(function(){	
    $("#close").click(function(){
        $('#body').detach();
        window.location.reload();
    });
  });
</script>

</head>
<body bgcolor="#06090F">


<div id="detailViewback">

</div>


<div id="detailView">
	<div id="closebotton">
		<label for="close">
			<img src="/MyUsed/images/close.png" width="30" height="30">
		</label>
    </div>
<%--     <a href="/MyUsed/MyUsedProductView.nhn?categ=${viewCateg.categ}"> --%>
   	<input type="button" id="close" style='display: none;'>
   	<br />
   	
   	<!-- 대표이미지 (추후 경로 수정)-->
   	<div id="detailimg">
   		<img src="/MyUsed/images/${productDTO.pro_pic}" width="478" height="328">
   	</div>
   	
   	
   	<!-- 다른 이미지 -->
   	<div id="detailimgs">
   	
   	<table border="1" width="480" height="160">
   	
   		<tr>
   		<c:forEach begin="0" step="1" end="3" var="propic" items="${propicList}">
   			<td>
   				<img src="/MyUsed/images/${propic.pro_pic}" onclick="javascript:bigImage('${propic.pro_pic}')" style="cursor:pointer;"  width="118" height="78">
   			</td>
   		</c:forEach>
   		</tr>
   	
   		<tr>
   		<c:forEach begin="4" step="1" end="7" var="propic" items="${propicList}">
   			<td>
   				<img src="/MyUsed/images/${propic.pro_pic}" onclick="javascript:bigImage('${propic.pro_pic}')" style="cursor:pointer;"  width="118" height="78">
   			</td>
   		</c:forEach>
   		</tr>
   	</table>
    </div>
    
    <div id="detailcontent">
    <form action="proreplesubmit.nhn" method="post" >
    
    <input type="hidden" name="proboardnum" value="${num}"/>
    
	<table align="right" width="360" height="497" border="1">
		<tr height="50" align="left">
			<td style="padding:0 0 0 10px;">
			<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${productDTO.mem_num}"> 
				<img src="/MyUsed/images/profile/${profilepic}" width="40"  height="40"></a>
			<a href="/MyUsed/MyUsedMyPage.nhn?mem_num=${productDTO.mem_num}"> 
				<font size="3" color="#4565A1"><strong>${productDTO.name}</strong></font>
			</a>
				<!-- <font size="1">쪽지보내기</font> -->
			</td >
			<td align="right" style="padding:0 10px 0 0;">			
			 <font size="2" color="#9A9DA4">
  			<fmt:formatDate value="${productDTO.reg}" type="both" /> 
 			</font>
			
			</td>
		</tr>
		
		
		<!-- 해시태크 링크 -->
 		<script type="text/javascript">
 		$(document).ready(function(){
		var content = document.getElementById('procontent_${productDTO.num}').innerHTML;
		console.log(content);
		var splitedArray = content.split(' ');	// 공백을 기준으로 자름
		console.log(">>>1>>>",splitedArray);
		var resultArray = [];	//최종 결과를 담을 배열을 미리 선언함
		
		// 공백을 기준으로 잘린 배열의 요소들을 검색함
		for(var i = 0; i < splitedArray.length ; i++){
			console.log(i+' : ',splitedArray[i].indexOf('<br>'));
			
			// 그 중 <br>이 포함되어있는 배열의 요소가 있다면
			if(splitedArray[i].indexOf('<br>') > -1){
				
				// <br> 기준으로 잘라 임시 배열인 array에 넣는다 -> 이때 array의 길이는 2개 일 수 밖에 없음
				var array = splitedArray[i].split('<br>');
				console.log(i+'번째에서 <br> 출연 : ',array);
				// 이때 <br>이 #이 붙은 단어의 앞에 있을 수 도있고 뒤에 있을 수도 있기 때문에 indexOf를 이용해 위치를 판단한다.
				if(splitedArray[i].indexOf('<br>') < splitedArray[i].indexOf('#')){	//br이 앞에 있을경우
					resultArray[i] = array[0]+'<br>';	// array의 첫번째 요소에 <br>을 붙여준다
					resultArray[i+1] = array[1];
					i++;	//resultArray의 크기가 1 늘어났음으로 i를 ++해줌
					console.log('///resultArray 찍어봄(br앞) : ',resultArray);
				}else{	//br이 뒤에 있을경우
					resultArray[i] = array[0];
					resultArray[i+1] = '<br>'+array[1];	// array의 두번째 요소에 <br>을 붙여준다
					i++;	//resultArray의 크기가 1 늘어났음으로 i를 ++해줌
					console.log('///resultArray 찍어봄(br뒤) : ',resultArray);
				}
			// <br>이 포함되지않은 요소들은 그냥 resultArray에 넣어준다.
			}else{
				resultArray[i] = splitedArray[i];
				console.log('<br>없는 착한 요소///resultArray 찍어봄 : ',resultArray);
			}
		}
		console.log(">>>2>>>",resultArray);
		var linkedContent = '';
		for(var word in resultArray)
		{
		  word = resultArray[word];
		   if(word.indexOf('#') == 0)
		   {
				var url = '"'+'/MyUsed/ProductTegSearch.nhn?currentPage=1&word='+word.split('#')+'"';
			    word = '<a href='+url+'>'+word+'</a>';
		   }
		   linkedContent += word+' ';
		}
		document.getElementById('procontent_${productDTO.num}').innerHTML = linkedContent; 
	});
	</script>
		
 		
		<tr>
			<td style="padding:0 0 0 20px;" colspan="2">
				<div id="procontent_${productDTO.num}">${productDTO.content}</div>
			</td>
 		</tr>
 		
 		<tr height="30">
 		<td style="padding:0 0 0 0px;"  bgcolor=#EBE8FF ><font size="2" color="#9A9DA4" ><strong>댓글 ${procount}개</strong></font></td>
			<td align="right" style="padding:0 0 0 20px;" bgcolor=#EBE8FF colspan="2">
			
			<c:if test="${productDTO.sendpay != null}">
				<font face="Comic Sans MS" size="5" color="#4565A1"><strong>${productDTO.price} 원 </strong> </font>
				<a href="/MyUsed/productOrder.nhn?mem_num=${productDTO.mem_num}&price=${productDTO.price}&pronum=${num}">
				<img src="/MyUsed/images/buyIcon.PNG" width="50" height="50" />
				</a>
			</c:if>
			<c:if test="${productDTO.sendpay == null}">
				<font face="Comic Sans MS" size="3" color="#4565A1"><strong>거래중 </strong> </font>&nbsp;&nbsp;&nbsp;&nbsp;
			</c:if>
			
				
			</td>
		</tr>
		
		<tr>
			<td align="left" style="padding:0 0 0 20px;" bgcolor="#F6F7F9" colspan="2">	
				<p style='overflow:auto; width:330px; height:250px'>
				<c:forEach var="proreplelist" items="${proreplelist}"> 
					<a  href="/MyUsed/MyUsedMyPage.nhn?mem_num=${proreplelist.mem_num}"> 
						<!-- <img src="/MyUsed/images/profile/${proreplelist.profile_pic}" style="width:20px; height:20px;"> -->
						<font face="Comic Sans MS" size="3" color="#4565A1"> ${proreplelist.name}</font>
					</a>
 					${proreplelist.content}
 					
 					<c:if test="${session_num == proreplelist.mem_num}">
 					<a href="prorepleDelete.nhn?seq_num=${proreplelist.seq_num}&boardnum=${num}" onclick="javasciprt:deleteCheck()">
 	<img src="/MyUsed/images/deleteIcon.PNG" style="margin-top:6px; margin-right: 0.5em;" align="right" width="15"  height="15" title="삭제하기" />
 					</a>
 					</c:if>
 					
 					<br/>
 					 <font size="2" color="#9A9DA4">
  				<fmt:formatDate value="${proreplelist.reg}" type="both" /> 
 					</font>
					<br />
				</c:forEach>
				</p>
			</td>
		</tr>
		<tr height="50">
			<td bgcolor="#F6F7F9" colspan="2">
				<img src="/MyUsed/images/profile/${proDTO.profile_pic}" align="left" width="40"  height="35" style="margin-left:10px;"/>
					<input style="padding:7px;" type="text" name="reple" size="30" placeholder="댓글을 입력하세요..." />
				<input type="image" src="/MyUsed/images/submitReple.png" width="30" height="20" title="댓글달기"/>
			</td>
		</tr>
	</table>
	</form>
    </div>	
    
</div>



</body>
</html>