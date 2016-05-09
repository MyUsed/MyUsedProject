package main;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import member.FriendCategDTO;
import member.MemberDTO;

@Controller
public class MainController {

	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	private List<MainboardDTO> list = new ArrayList<MainboardDTO>();;	

	   @RequestMapping("/MyUsed.nhn")
	   public ModelAndView main(HttpServletRequest request){
	      ModelAndView mv = new ModelAndView();
	      
	      
	      HttpSession session = request.getSession();
	      String sessionId = (String) session.getAttribute("memId");
	      MemberDTO memDTO = new MemberDTO();
	      memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);
	      
	      request.setAttribute("name", memDTO.getName());
	      request.setAttribute("num", memDTO.getNum());
	      
	  	  list = sqlMap.queryForList("main.boardView", null);
	  	  mv.addObject("list", list);
	      mv.setViewName("/main/MyUsed.jsp");
	      return mv;
	   }   
	   
	   
	   @RequestMapping("/MyUsedSearchMember.nhn")
	   public ModelAndView MyUsedSearchMember(HttpServletRequest request, String member){
	      ModelAndView mv = new ModelAndView();
	      /** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
	      HttpSession session = request.getSession();
	      String sessionId = (String) session.getAttribute("memId");
	      MemberDTO memDTO = new MemberDTO();
	      memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);
	      
	      System.out.println(memDTO.getName()+memDTO.getNum());
	      
	      /** 회원검색 -> 동명이인이 많아질 경우 검색 우선순위 정하는것 생각해보기 */
	      System.out.println(member); //검색한 이름
	      List searchList = new ArrayList();
	      searchList = sqlMap.queryForList("member.searchMember", member);
	      
	      FriendCategDTO fricagDTO = new FriendCategDTO();
	      List friendCateg = new ArrayList();
	      friendCateg = sqlMap.queryForList("friend.friendCateg", null);
	      

	      
	      request.setAttribute("name", memDTO.getName());
	      request.setAttribute("num", memDTO.getNum());
	      request.setAttribute("member", member);
	      request.setAttribute("searchList", searchList);
	      request.setAttribute("friendCateg", friendCateg);
	      
	      mv.setViewName("/main/MyUsedSearchMember.jsp");
	      return mv;
	   }   
	   
	
	@RequestMapping("/MyUsedLogin.nhn")
	public ModelAndView login(){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/member/MyUsedLogin.jsp");
		return mv;
	}
	
	
	

}
