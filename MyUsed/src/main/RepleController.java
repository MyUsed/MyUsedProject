package main;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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
	public ModelAndView reple(int num){
		ModelAndView mv = new ModelAndView();
		System.out.println(num);
		
		Timestamp reg = (Timestamp)sqlMap.queryForObject("reple.boardreg",num); // 게시글 등록된 시간 가져오기
		String name = (String)sqlMap.queryForObject("reple.boardname",num); // boardlist에서 글쓴이 이름 가져오기
		int mem_num = (int)sqlMap.queryForObject("reple.mem_num",num); // 댓글다는 사람의 회원번호 가져오기
		String content =(String)sqlMap.queryForObject("reple.content",num); // 게시글의 내용 가져오기 
		String board_pic = (String)sqlMap.queryForObject("reple.pic",num); // 게시글의 사진 가져오기
		
		replelist = sqlMap.queryForList("reple.select", num); // 댓글 가져오기 
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 aa hh시 mm분");
		String time = sdf.format(reg.getTime());
		
		System.out.println(time);
		
		
		
		mv.addObject("replelist",replelist);
		mv.addObject("name",name);
		mv.addObject("content",content);
		mv.addObject("num",num);
		mv.addObject("time",time);
		mv.addObject("mem_num",mem_num);
		mv.addObject("board_pic",board_pic);
		mv.setViewName("/main/reple.jsp");
		return mv;
	}
	
	@RequestMapping("/replesubmit.nhn")
	public ModelAndView replesubmit(HttpServletRequest request , String reple , int boardnum , String content){
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		int mem_num = (int)sqlMap.queryForObject("main.num",sessionId); // 댓글작성한 회원의 번호 가져오기
		String re_name = (String)sqlMap.queryForObject("main.name",sessionId); // 댓글작성한 회원의 이름 
		
		System.out.println("세션ID = "+sessionId);
		System.out.println("댓글내용 = "+reple);
		System.out.println("댓글 작성한회원번호 = "+mem_num);
		System.out.println("댓글 작성한회원이름 = "+re_name);
		
		System.out.println("게시글번호 ="+boardnum);
		
		Map map = new HashMap();
		map.put("boardnum", boardnum); 
		map.put("mem_num", mem_num);
		map.put("content", reple);
		map.put("name", re_name);
		
		sqlMap.insert("reple.insert",map);   // 댓글 삽입 
		
		
		mv.setViewName("reple.nhn?num="+boardnum);
		return mv;
	}
	
	


}
