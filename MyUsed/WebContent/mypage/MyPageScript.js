function send() {

	document.formId.method = "post" // method 선택, get, post
	document.formId.action = "/MyUsed/main/test.jsp"; // submit 하기 위한 페이지 

	document.formId.submit();

}

/* 프로필 이미지 */
function openImageUpload() {
	imageUploadback.style.display = '';
	imageUpload.style.display = '';
}

function closeImageUpload() {
	imageUploadback.style.display = 'none';
	imageUpload.style.display = 'none';
}

function openImageHistory() {
	imagehistoryback.style.display = '';
	imagehistory.style.display = '';
	viewImage.style.display = '';
}

function closeImageHistory() {
	imagehistoryback.style.display = 'none';
	imagehistory.style.display = 'none';
	$('#viewImage').detach();
    window.location.reload();

}

/* 커버 이미지 */

function openCoverImageUpload() {
	CoverUploadback.style.display = '';
	CoverUpload.style.display = '';
}

function closeCoverImageUpload() {
	CoverUploadback.style.display = 'none';
	CoverUpload.style.display = 'none';
}

function openCoverImageHistory() {
	Coverhistoryback.style.display = '';
	Coverhistory.style.display = '';
	viewImage.style.display = '';
}

function closeCoverImageHistory() {
	Coverhistoryback.style.display = 'none';
	Coverhistory.style.display = 'none';
	$('#viewImage').detach();
    window.location.reload();
}


/* 프로필 이미지 업로드 미리보기 */
$(document).ready(function(){
	$("#profilepic").change(function(){
		callImage();
	});
});
function callImage() {
    
    ext = $("#profilepic").val().split('.').pop().toLowerCase(); //확장자
    
    //배열에 추출한 확장자가 존재하는지 체크
    if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
        resetFormElement($(this)); //폼 초기화
        window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
    } else {
        file = $('#profilepic').prop("files")[0];
        blobURL = window.URL.createObjectURL(file);
        $('#view img').attr('src', blobURL);
        $('#view').slideDown(); //업로드한 이미지 미리보기 
        $(this).slideUp(); //파일 양식 감춤
    }
};

/* 프로필 미리보기 이미지 삭제 */
$(document).ready(function(){
	$("#view a").click(function(){
		removeImage();
	});
});
function removeImage() {
    resetFormElement($('#profilepic')); //전달한 양식 초기화
    $('#profilepic').slideDown(); //파일 양식 보여줌
    $('#view img').slideUp(); //미리 보기 영역 감춤
    return false; //기본 이벤트 막음
};	

function resetFormElement(e) {
    e.wrap('<form>').closest('form').get(0).reset(); 
    //리셋하려는 폼양식 요소를 폼(<form>) 으로 감싸고 (wrap()) , 
    //요소를 감싸고 있는 가장 가까운 폼( closest('form')) 에서 Dom요소를 반환받고 ( get(0) ),
    //DOM에서 제공하는 초기화 메서드 reset()을 호출
    e.unwrap(); //감싼 <form> 태그를 제거
}


/* 커버 이미지 업로드 미리보기 */
$(document).ready(function(){
	$("#coverpic").change(function(){
		callCoverImage();
	});
});
function callCoverImage() {
    
    ext = $("#coverpic").val().split('.').pop().toLowerCase(); //확장자
    
    //배열에 추출한 확장자가 존재하는지 체크
    if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
        resetFormElement($(this)); //폼 초기화
        window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
    } else {
        file = $('#coverpic').prop("files")[0];
        blobURL = window.URL.createObjectURL(file);
        $('#cview img').attr('src', blobURL);
        $('#cview').slideDown(); //업로드한 이미지 미리보기 
        $(this).slideUp(); //파일 양식 감춤
    }
};

/* 커버 미리보기 이미지 삭제 */
$(document).ready(function(){
	$("#cview a").click(function(){
		removeCoverImage();
	});
});
function removeCoverImage() {
    resetFormElement($('#coverpic')); //전달한 양식 초기화
    $('#coverpic').slideDown(); //파일 양식 보여줌
    $('#cview img').slideUp(); //미리 보기 영역 감춤
    return false; //기본 이벤트 막음
};	

function resetFormElement(e) {
    e.wrap('<form>').closest('form').get(0).reset(); 
    //리셋하려는 폼양식 요소를 폼(<form>) 으로 감싸고 (wrap()) , 
    //요소를 감싸고 있는 가장 가까운 폼( closest('form')) 에서 Dom요소를 반환받고 ( get(0) ),
    //DOM에서 제공하는 초기화 메서드 reset()을 호출
    e.unwrap(); //감싼 <form> 태그를 제거
}


/* 프로필, 커버 이미지 상세보기(히스토리) */
function openviewProfile(pic){
    $.ajax({
        type: "post",
        url : "/MyUsed/BigViewImage.nhn",
        data: {	// url 페이지도 전달할 파라미터
        	pic : pic
        },
        success: viewPic,	// 페이지요청 성공시 실행 함수
        error: whenError	//페이지요청 실패시 실행함수
 	});
}
function viewPic(view){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
    $("#viewImage").html(view);
    console.log(resdata);
}
function whenError(){
    alert("Error");
}


/* 메시지 보기 */
function openMsg() {
	msgPop.style.display = '';
	arrow.style.display = '';
}

function closeMsg() {
	msgPop.style.display = 'none';
	arrow.style.display = 'none';
}


/*메뉴 이동*/
function menuMove(url){
	location.href = url;
}


/* 메뉴 마우스 오버시 색상 변경 */
function mouseOver1(){
	document.getElementById("menu1").style.background="#f1f4f4";
}
function mouseOut1(){
	document.getElementById("menu1").style.background="#FFFFFF";
}

function mouseOver2(){
	document.getElementById("menu2").style.background="#f1f4f4";
}
function mouseOut2(){
	document.getElementById("menu2").style.background="#FFFFFF";
}

function mouseOver3(){
	document.getElementById("menu3").style.background="#f1f4f4";
}
function mouseOut3(){
	document.getElementById("menu3").style.background="#FFFFFF";
}

function mouseOver4(){
	document.getElementById("menu4").style.background="#f1f4f4";
}
function mouseOut4(){
	document.getElementById("menu4").style.background="#FFFFFF";
}


function mouseOver5(){
	document.getElementById("menu5").style.background="#f1f4f4";
}
function mouseOut5(){
	document.getElementById("menu5").style.background="#FFFFFF";
}

/* 친구 매뉴로 이동 */
function moveFriendMenu(mem_num){
    $.ajax({
        type: "post",
        url : "/MyUsed/MyPageBottom_friend.nhn",
        data: {	// url 페이지도 전달할 파라미터
        	mem_num : mem_num
        },
        success: move,	// 페이지요청 성공시 실행 함수
        error: whenError	//페이지요청 실패시 실행함수
 	});
}
function move(menu){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
    $("#mypageBottom").html(menu);
    console.log(resdata);
}
function whenError(){
    alert("Error");
}


/* 사진 메뉴로 이동 */
function movePictureMenu(mem_num){
    $.ajax({
        type: "post",
        url : "/MyUsed/MyPageBottom_picture.nhn",
        data: {	// url 페이지도 전달할 파라미터
        	mem_num : mem_num
        },
        success: move,	// 페이지요청 성공시 실행 함수
        error: whenError	//페이지요청 실패시 실행함수
 	});
}
function move(menu){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
    $("#mypageBottom").html(menu);
    console.log(resdata);
}
function whenError(){
    alert("Error");
}



/* 친구 삭제 새창열기 */
function deleteFriend(mem_num){
    url = "/MyUsed/DeleteFriend.nhn?mem_num="+mem_num;
    
    // 새로운 윈도우를 엽니다.
    open(url, "confirm", 
	"toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
}

/* 친구 카테고리 변경 새창열기 */
function modifyFriendCateg(mem_num){
    url = "/MyUsed/ModifyFriendCateg.nhn?mem_num="+mem_num;
    
    // 새로운 윈도우를 엽니다.
    open(url, "confirm", 
	"toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=400, height=200");

}


/* 친구추가 새창 열기 */
function addFriend(mem_num){
    url = "/MyUsed/AddFriend.nhn?mem_num="+mem_num;
    
    open(url, "confirm", 
	"toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=400, height=200");
}


/* 사진 메뉴의 사진 전체보기에서 누르면 사진 크게 나옴 */
function openPic(pic) {
    URL = "/MyUsed/images/profile/"+pic;
    $('#picView img').attr('style', 'display:block;');
    $('#picView img').attr('src', URL);
    $('#picView').slideDown(); //업로드한 이미지 미리보기 
    $(this).slideUp(); //파일 양식 감춤
}

function closePic() {
    $('#picView img').slideUp(); //미리 보기 영역 감춤
    

}

/*마이페이지에서 홈의 친구찾기 페이지로*/
function callHomefriend(mem_num){
    $.ajax({
        type: "post",
        url : "/MyUsed/MyUsedFriend.nhn",
        data: {	// url 페이지도 전달할 파라미터
        	mem_num : mem_num
        },
        success: friend,	// 페이지요청 성공시 실행 함수
        error: whenError	//페이지요청 실패시 실행함수
 	});
}
function friend(aaa){	// 요청성공한 페이지정보가 aaa 변수로 콜백된다. 
    $("#contents").html(aaa);
    console.log(resdata);
}
function whenError(){
    alert("Error");
}









