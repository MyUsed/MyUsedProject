

	// 관리자 계정 생성 Ajax
	function createAjax(){
		$('#AdminSearchReturn').attr('style', 'display:none');
		$('#adminlist').attr('style', 'display:block');
		
		
        $.ajax({
	        type: "post",
	        url : "/MyUsed/admin/AdminCreate.jsp",
	        success: test,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
     	});
    }
    function test(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
        $("#createReturn").html(aaa);
        console.log(resdata);
    }
    function whenError(){
        alert("Error");
    }
    
    
    
    
	// 관리자 계정 삭제 Ajax
	function deleteAjax(){
    	
		$('#adminlist').attr('style', 'display:block');
		
        $.ajax({
	        type: "post",
	        url : "/MyUsed/admin/AdminDelete.jsp",
	        success: test,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
     	});
    }
    function test(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
        $("#deleteReturn").html(aaa);
        console.log(resdata);
    }
    function whenError(){
        alert("Error");
    }
    
    
    
    
    
 // 관리자 계정 수정 Ajax
	function updateAjax(){
    	
		
		$('#adminlist').attr('style', 'display:none');
		
        $.ajax({
	        type: "post",
	        url : "AdminUpdate.nhn",
	        success: test,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
     	});
    }
    function test(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
        $("#updateReturn").html(aaa);
        console.log(resdata);
    }
    function whenError(){
        alert("Error");
    }
    
    
    
    // 관리자 계정 수정 Ajax
	function AdiminupdateAjax(seq_num){
        $.ajax({
	        type: "post",
	        url : "AdminUpdateMem.nhn",
	        data: {
	        	seq_num : seq_num
	        },
	        success: testtest,	// 페이지요청 성공시 실행 함수
	        error: whenError	//페이지요청 실패시 실행함수
     	});
    }
    function testtest(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
        $("#AdminupdateReturn").html(aaa);
        console.log(resdata);
    }
    function whenError(){
        alert("Error");
    }
    
   

 
   
   
    
    
    
    

       
      
    
 
    
    
    
    
    
    
    
    
    