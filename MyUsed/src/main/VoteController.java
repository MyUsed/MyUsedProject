package main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import main.MainboardDTO;

@Controller
public class VoteController {
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 

	
	@RequestMapping("test1.nhn")
	//좋아요를 클릭한  게시판의 num을 받는다.
	public ModelAndView test1(HttpServletRequest request, int num){
	ModelAndView mv = new ModelAndView();
	HttpSession session = request.getSession(); 
    String sessionId = (String) session.getAttribute("memId"); //접속중인 sessionId를 받는다.
    System.out.println("세션아이디="+sessionId);
    
    int mem_num =(int)sqlMap.queryForObject("main.num",sessionId); //세션 아이디에 따른 고유 mem_num을 구한다.
    System.out.println("게시글  num="+num);
    System.out.println("회원 mem_num="+mem_num);
    
    Map map = new HashMap();
	map.put("num", num);	//map 형식으로 num과 mem_num을 담아서
	map.put("mem_num", mem_num);
	System.out.println("main.likescount");
    int count =(int)sqlMap.queryForObject("main.likescount",map);
    System.out.println("개인테이블 count="+count);

    if(count==0){ //개인터이블 카운드가 0이면 
    	System.out.println("처음");
    	System.out.println("main.likesInsert");
    	sqlMap.insert("main.likesInsert", map);
    	System.out.println("main.likesBdUpdate");
    	sqlMap.update("main.likesBdUpdate", num); // board likes+1
      }else if(count==1){
    	  //System.out.println("likes value="+likes);
    	  System.out.println("main.likes");
    	  String likes = (String)sqlMap.queryForObject("main.likes", map);
    	  System.out.println("likes value="+likes);
    	  
    	  if(likes!=null){
    	  if(likes.equals("1")){
    		  System.out.println("테이블에 데이터 있고 이미 클릭한적 있음");
    		  System.out.println("main.likescancle");
    		  sqlMap.update("main.likescancle", map); 
    		  System.out.println("main.likesBdcancle");    		  
    		  sqlMap.update("main.likesBdcancle", num);
    	  }else if(likes.equals("0")){
    		  System.out.println("테이블에 데이터 있고 클릭한 적은 없음");
    		  System.out.println("main.likesUpdate");
    		  sqlMap.update("main.likesUpdate",map);
    		  System.out.println("main.likesBdUpdate");
    		  sqlMap.update("main.likesBdUpdate", num); 
    	  }
    	}else{ //null인 경우
    		  System.out.println("null 일 경우");
    		  System.out.println("main.likesInsert");
    	      sqlMap.insert("main.likesInsert", map); 
    		  System.out.println("main.likesBdUpdate");
    	      sqlMap.update("main.likesBdUpdate", num); // board likes+1
        }
      }
    System.out.println("main.likeresult");
    MainboardDTO memDTO = new MainboardDTO();
    List memList = new ArrayList();
    memList  =sqlMap.queryForList("main.likeresult", null);// num에 따른 좋아요를 확인
    
    mv.addObject("memList", memList);
    
    String likes = (String)sqlMap.queryForObject("main.likes", map);
	 System.out.println("likes="+likes);
	request.setAttribute("likes",likes);
	
	mv.setViewName("/MyUsed.nhn");
	return mv;
	}
	
	
	@RequestMapping("likeup.nhn")
	public ModelAndView like(int num){
		ModelAndView mv = new ModelAndView();
		
		
		sqlMap.update("main.likeUpdatePush",num); // 전체 likes 증가

		mv.setViewName("/MyUsed.nhn");
		return mv;
		
	}
	
	@RequestMapping("likedown.nhn")
	public ModelAndView likedown(int num){
		ModelAndView mv = new ModelAndView();
		
		
		sqlMap.update("main.likeUpdateDown",num); // 전체 likes 증가
	
		mv.setViewName("/MyUsed.nhn");
		return mv;
		
	}
	
	
	
	
	
	
	}
