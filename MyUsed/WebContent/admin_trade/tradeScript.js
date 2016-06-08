

	function regSearch(value){
		if(value == "reg"){
	
			$('#textInput').attr('style', 'display:none');
        $.ajax({	
	        type: "post",
	        url : "/MyUsed/admin_trade/SearchYear.jsp",
	        success: regSuc,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
	        
     	});
    
    function regSuc(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
        $("#regReturn").html(aaa);
        console.log(resdata);
    }
    function whenError(){
        alert("Error");
    }
  }
}

	
	 