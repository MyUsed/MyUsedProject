package mypage;

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

import main.MainpicDTO;
import main.RepleDTO;
import member.ProfilePicDTO;

@Controller
public class ModalController {

	@Autowired
	private SqlMapClientTemplate sqlMap;

	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private ProfilePicDTO boardproDTO = new ProfilePicDTO();
	private List<RepleDTO> replelist = new ArrayList<RepleDTO>();;	
	private List<MainpicDTO> piclist = new ArrayList<MainpicDTO>();;
	
	@RequestMapping("/MypageModal.nhn")
	public ModelAndView MypageModal(HttpServletRequest request, int num){
		ModelAndView mv = new ModelAndView();
		System.out.println(num);
		
		Timestamp reg = (Timestamp)sqlMap.queryForObject("reple.boardreg",num); // 게시글 등록된 시간 가져오기
		String name = (String)sqlMap.queryForObject("reple.boardname",num); // boardlist에서 글쓴이 이름 가져오기
		int mem_num = (int)sqlMap.queryForObject("reple.mem_num",num); // 댓글다는 사람의 회원번호 가져오기
		String content =(String)sqlMap.queryForObject("reple.content",num); // 게시글의 내용 가져오기 
		String board_pic = (String)sqlMap.queryForObject("reple.pic",num); // 게시글의 사진 가져오기
		
		replelist = sqlMap.queryForList("reple.select", num); // 댓글 가져오기 
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 aa hh시 mm분"); // 시간을 뿌려주기위해 세팅
		String time = sdf.format(reg.getTime());
		
		// 사진을 전부 꺼내오는 작업
		
		
		String mem_pic = (String)sqlMap.queryForObject("reple.mem_pic",num); // 메인사진의 이름을 가져오기
		
		Map remap = new HashMap();
		
		
		remap.put("mem_num", mem_num);
		remap.put("mem_pic", mem_pic);
		if(mem_pic != null){
		int pic_num = (int)sqlMap.queryForObject("reple.pic_num",remap); // 사진의 num을 가져오기
		remap.put("pic_num", pic_num);
		}
		
		piclist = sqlMap.queryForList("reple.all_pic",remap);
		
		
	    HttpSession session = request.getSession();
	    String sessionId = (String) session.getAttribute("memId");
	    int session_num = (int)sqlMap.queryForObject("main.num",sessionId); // 회원번호 가져오기
	    
	    boardproDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", remap); // 프로필 사진을 가져옴
	    
	    Map picmap = new HashMap();
		picmap.put("mem_num", session_num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // 프로필 사진을 가져옴

		
		// 댓글 갯수를 가져옴
		
		int count = (int)sqlMap.queryForObject("reple.count",num);
		
		mv.addObject("count",count);
		mv.addObject("session_num",session_num);
		mv.addObject("boardproDTO",boardproDTO);
		mv.addObject("proDTO",proDTO);
		mv.addObject("piclist",piclist);
		mv.addObject("replelist",replelist);
		mv.addObject("name",name);
		mv.addObject("content",content);
		mv.addObject("num",num);
		mv.addObject("time",time);
		mv.addObject("mem_num",mem_num);
		mv.addObject("board_pic",board_pic);
		
		mv.setViewName("mypage/list_modalpic.jsp");
		return mv;
		
	}
}
