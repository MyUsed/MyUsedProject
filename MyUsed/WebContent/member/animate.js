var img_num = 0; 
var btn_num = 0;
var ag = setInterval("auto_gallery()",3000);
function auto_gallery(){
    img_num += 1; 
    if( img_num>4 ){ 
         img_num = 1;
         $(".visual_inner li:not(:last)").appendTo(".visual_inner");
         $(".visual_inner").css({marginLeft:0}); 
         $(".visual_inner").animate({marginLeft:-1100 * img_num}, function(){ 
              $(".visual_inner li:first").appendTo(".visual_inner");
              $(".visual_inner").css({marginLeft:0});
              img_num=0;
         });
    }else{   $(".visual_inner").animate({marginLeft:-1100 * img_num});}  

    btn_num+=1;
    if(btn_num<5){
      $(".visual_btn li").css({background:"#000",color:"#fff"});
      $(".visual_btn li:eq("+btn_num+")").css({background:"#fff",color:"#000"});
    }else{
      $(".visual_btn li").css({background:"#000",color:"#fff"});
      $(".visual_btn li:first").css({background:"#fff",color:"#000"});
      btn_num=0;
    }

}






$(function(){
  /* (2)수평메뉴*/
  $(".sub").hide();
  $(".gnb>li>a").mouseover( function(){
     if($(this).next().css("display") == "none" ){     
     $(".sub").slideUp("fast");
     $(this).next().slideDown("fast");
     }
  });
  $(".sub").mouseleave(function(){
     $(".sub").slideUp("fast");
  });

  /*(3)오토갤러리 조작*/
  $(".visual_btn li:first").css({background:"#fff", color:"#000"});   

  $(".visual_btn li").click( function(){
	  clearInterval(ag);
     $(".slider_contorl").fadeIn("fast");

     btn_num = img_num = $(this).text()-1;
     $(".visual_btn li").css({background:"#000",color:"#fff"});
     $(".visual_btn li:eq("+btn_num+")").css({background:"#fff",color:"#000"});

     $(".visual_inner").animate({marginLeft: -1100 * img_num })
  });

  $(".slider_contorl").hide();
  $(".slider_contorl").click(function(){  
      $(this).fadeOut("fast");
      ag = setInterval("auto_gallery()",3000);
  });

});









