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
import member.ProfilePicDTO;

@Controller
public class MainController {

	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private List<MainboardDTO> list = new ArrayList<MainboardDTO>();;	
	private List<MainProboardDTO> prolist = new ArrayList<MainProboardDTO>();; 
	private List<RepleDTO> replelist = new ArrayList<RepleDTO>();;
	
	   @RequestMapping("/MyUsed.nhn")
	   public ModelAndView main(HttpServletRequest request){
	      ModelAndView mv = new ModelAndView();
	  
	      HttpSession session = request.getSession();
	      String sessionId = (String) session.getAttribute("memId");
	      MemberDTO memDTO = new MemberDTO();
	      memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);
	      
	      request.setAttribute("name", memDTO.getName());
	      request.setAttribute("num", memDTO.getNum());
	      
	      /** ī�װ� ���� */
	      List viewCategList = new ArrayList();
	      viewCategList = sqlMap.queryForList("procateg.viewCateg", null);
	      request.setAttribute("viewCategList", viewCategList);
	   
	      
	      /** ī�װ� �߰�  */
	      ProBoardCategDTO categDTO0 = new ProBoardCategDTO();
	      List categList = new ArrayList();
	      categList = sqlMap.queryForList("procateg.selectCateg", 0);
			
	      request.setAttribute("categList", categList);
	      request.setAttribute("checked", "checked");
	      
	      int renum = (int)sqlMap.queryForObject("main.boardnum",null);
	 
	      
	  	  list = sqlMap.queryForList("main.boardView", null); // state ����Ʈ
	  	  prolist = sqlMap.queryForList("main.proboardView", null); 	// product ����Ʈ 
	  	  
	  	  
	  	  Map picmap = new HashMap();
	  	  picmap.put("mem_num",memDTO.getNum());
		  proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // ������ ������ ������
	  	  
		  
		  mv.addObject("proDTO",proDTO);
	  	  mv.addObject("list", list);
	  	  mv.addObject("prolist",prolist);
	  	  mv.addObject("replelist",replelist);
	  	  
	  	  mv.addObject("memDTO" , memDTO);
	      mv.setViewName("/main/MyUsed.jsp");
	      return mv;
	   }   
	   
	   
	   @RequestMapping("/MyUsedSearchMember.nhn")
	   public ModelAndView MyUsedSearchMember(HttpServletRequest request, String member){
	      ModelAndView mv = new ModelAndView();
	      /** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
	      HttpSession session = request.getSession();
	      String sessionId = (String) session.getAttribute("memId");
	      MemberDTO memDTO = new MemberDTO();
	      memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);
	      
	      System.out.println(memDTO.getName()+memDTO.getNum());
	      
	      /** ȸ���˻� -> ���������� ������ ��� �˻� �켱���� ���ϴ°� �����غ��� */
	      System.out.println(member); //�˻��� �̸�
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
