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

@Controller
public class RepleController {
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	private List<RepleDTO> replelist = new ArrayList<RepleDTO>();;	
	
	@RequestMapping("/reple.nhn")
	public ModelAndView reple(String reple,int renum,int remem_num, HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
	
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		
		
		String name = (String)sqlMap.queryForObject("main.name",sessionId);
		
		System.out.println("댓글작성자 ="+name);
		System.out.println("회원번호 = "+remem_num);
		System.out.println("글번호 = "+renum);
		System.out.println("댓글내용 = "+reple);
		
		Map map = new HashMap();
		map.put("boardnum", renum); // 게시글번호
		map.put("mem_num", remem_num); // 리플다는 회워번호
		map.put("content", reple);  // 리플다는 내용
		map.put("name", name); // 리플다는 회원이름
		
		sqlMap.insert("reple.insert",map); // 댓글 삽입 
		System.out.println("댓글 삽입성공");
		
		
		replelist = sqlMap.queryForList("reple.select", renum);
		System.out.println("리스트 가져옴 ");
		
		
		
		mv.addObject("replelist",replelist);
		mv.addObject("reple",reple);
		mv.setViewName("/main/test.jsp");
		return mv;
	}
	
	


}
