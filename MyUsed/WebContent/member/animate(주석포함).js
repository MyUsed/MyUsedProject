/*(1)비주얼 이미지 슬라이드
  ▶clearInterval( 진행중인setInterval호출( setInterval을 대입한 변수명기입)  )
     var 변수명 = setIntervarl( , )  
  ▶정지된 setInterval을 다시 재생할때는
     setInterval을 대입한 변수에 다시 한번 setInterval()을 대입  
     변수명 = setIntervarl( , )  
*/



var img_num = 0; 
/* 이미지의 준비된 장수를 기록할수 있도록 변수선언*/
var btn_num = 0;
/* 버튼 번호를 기록해둘수 있는 변수 선언*/


var ag = setInterval("auto_gallery()",3000);
/* 3초의 인터벌을 가지고 auto_gallery()함수를 반복 수행하는 명령어를 
   서술했으며, 차후 clearInterval(ag)함수를 통해 진행중인 setInterval을 제거할수있게
   호명할수 있는 변수 ag를 선언한후 대입
*/

function auto_gallery(){
/* 3초의 인터벌 시간마다 수행할 명령어를 담아둔 auto_gallery()함수 명령어*/

    img_num += 1; 
    /* (1) 다음 이미지를 보여주기 위한 이미지 번호 증가 */


   /* (2) 오토갤러리 진행 과정에 있어 발생될수 있는 경우의 수에따라
          스크립트 흐름을 제어하는 if문 서술

          경우의수1 - 준비된 장수를 모두 다 출력한 다음 진행과정.
          경우의수2 - 준비된 장수를 모두 출력 하기 이전 일반적인 진행과정.
   */
 
    if( img_num>4 ){  
    /* 경우의수1번*/

         img_num = 1; /* 마지막 이미지는 1번이미지를 출력하기위해
                               0번의 위치를 가지게 됩니다.*/

         $(".visual_inner li:not(:last)").appendTo(".visual_inner");
         /* 마지막 이미지를 제외한 앞선 이미지 모두를 마지막 이미지 뒤로 이동
            이때  마지막 이미지가 순간 0번 이미지가 되버립니다.
         */
         $(".visual_inner").css({marginLeft:0}); 
          /* 마지막 이미지를 제외한 모든이미지가 마지막 이미지 뒤로 이동함과
             동시에 전체의 위치가 앞쪽으로 밀려나게 됩니다.
             밀려난 마지막 이미지의 위치를 원위치( 0 )로 돌려 놓습니다.         
         */

         $(".visual_inner").animate({marginLeft:-1100 * img_num}}, function(){ 
         /* 태그이동, CSS를 통한 위치 조작의 완료는 순식간에 진행 됩니다.
            모든 조작이 완료된 이후 마지막 이미지 다음이미지를 부드럽게 슬라이드
             -1100 * img_num( 마지막장-0 , 최초0번 이미지-1) 
         */
              /*콜백함수( 사용자의 이벤트 조작에 따른 추가 필요 코드)*/
              $(".visual_inner li:first").appendTo(".visual_inner");
              /* 현재 마지막장의 위치가 0번으로 지정되어 있습니다.
                  즉 0번 이미지를 선택하여 준비된 이미지들의 위치중 마지막으로 이동*/

              $(".visual_inner").css({marginLeft:0});
              /* 0번이미지의 마지막 위치이동으로 모든 이미지의 위치가 앞쪽으로 밀려납니다.원위치(0)*/
              img_num=0;
              /* 이미지 번호또한 다시 원위치(0) */
         });
    }else{   $(".visual_inner").animate({marginLeft:-1100 * img_num});}  
    /*경우의수2번*/


   btn_num+=1;
   $(".visual_btn li").css({background:"#fff",color:"#000"});


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
  $(".visual_btn li").click( function(){
     clearInterval(ag);
     $(".slider_contorl").fadeIn("fast");
     img_num = $(this).text()-1;
     $(".visual_inner").animate({marginLeft: -1100 * img_num })
  });

  $(".slider_contorl").hide();
  $(".slider_contorl").click(function(){  
      $(this).fadeOut("fast");
      ag = setInterval("auto_gallery()",3000);
  });

});









