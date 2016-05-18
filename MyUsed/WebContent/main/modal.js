/*jQuery(document).ready(function(){  });*/
$(function(){

  $(".modal_gallery").append("<div class='mbg'></div><figure class='mbig'><img src='' alt=''><figcaption></figcaption></figure><div class='mclose'>X</div>");

  $(".mbg").css({  
     position:"absolute", 
     left:0 , top: 0 , 
     width:"100%", height:"100%",
     background: "rgba(0,0,0,0.7)"   
  });
 
  $(".mbig").css({ 
    position:"absolute", left:"50%", top:"50%",
    width:"500px", height:"500px", marginLeft:"-250px" , marginTop:"-250px",
 });

  $(".mclose").css({ 
     position:"absolute" , 
     left:"50%", 
     top:"50%" , marginLeft: "250px" , marginTop: "-250px" ,
     padding:"10px 15px" ,
     background: "#000" ,
     color: "#fff" , cursor:"pointer" 
 });

$(".mbig figcaption").text("테스트입니다.").css({ 
              fontSize:"17pt" ,
              lineHeight:"100px" ,
              textIndent:"20px" , color:"#fff" 
});
/*
$(".mbg, .mbig").css("display","none");
$(".mbg, .mbig").css({display:"none"});
*/

$(".mbg, .mbig, .mclose").hide();

$(".modal_gallery li img").click(function(){ 
    $(".mbig img").attr("src", $(this).attr("src") );
    $(".mbig figcaption").text( $(this).attr("alt") );
    $(".mbg, .mbig, .mclose").fadeIn("fast");

    var img_w =  parseInt( $(".mbig img").css("width") ) / 2;
    var img_h =  parseInt( $(".mbig img").css("height") ) /2;
    /* 
      var a =  parseInt("350px") :  parseInt는 매개변수로 전달된 데이터중
                                      문자와 숫자가 혼합되어있을시 숫자만 따로 추출합니다.
   */
    $(".mbig").animate({ marginLeft: -img_w , marginTop: -img_h });
    $(".mclose").animate({ marginLeft: img_w , marginTop: -img_h });

});

/* .mclose 클릭시 현재 출력중인 .mbg, .mbig, .mclose 모두 
   애니메이션 효과(애니메이션 처리 속도는 빠르게)를
   이용한 비표시상태로 처리 

   $("선택자").명령어();
   $("선택자").이벤트( function(){  });
*/

   $(".mclose").click( function(){  
       $(".mbg, .mbig, .mclose").fadeOut("fast");
   });
});





