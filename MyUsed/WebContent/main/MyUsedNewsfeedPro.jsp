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

<a onclick="javascript:callAjax_newsfeed('${num}')" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
<font style="font-weight:bold; font-size:120%">
	State </font>
</a> &nbsp;&nbsp;

<a onclick="javascript:callAjax_pronewsfeed('${num}')" onmouseover="this.style.textDecoration='none'" style="cursor:pointer;"> 
<font style="font-weight:bold; font-size:120%">
	Product</font>
</a>

</center>

<br />

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