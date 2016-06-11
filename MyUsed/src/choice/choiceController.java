package choice;

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

import member.MemberDTO;
import member.ProfilePicDTO;



@Controller
public class choiceController {
	@Autowired
	private SqlMapClientTemplate SqlMapClientTemplate;
	

	private ProfilePicDTO proDTO = new ProfilePicDTO();

	@RequestMapping("choiceInsert.nhn")
	public ModelAndView choice(int mem_num, int price, String pro_pic, String mem_name, String content, HttpSession session, int num){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		String sessionId = (String)session.getAttribute("memId");
		int mynum = (int)SqlMapClientTemplate.queryForObject("choice.mynum", sessionId);		// 회원 고유번호 가져오기
		map.put("mynum", mynum);	// 회원 고유번호
		map.put("num", num);			// 찜한 게시글의 게시글번호
		int numcount = (int)SqlMapClientTemplate.queryForObject("choice.numcount", map);		// 찜한 게시글이 이미 존재하면 1 아니면 0
		if (numcount == 0) {
			String categ = (String)SqlMapClientTemplate.queryForObject("choice.categ", num);	// 게시글의 카테고리이름 가져오기
			map.put("content", content);	// 찜한 게시글의 내용
			map.put("price", price);		// 찜한 게시글의 상품가격
			map.put("pro_pic", pro_pic);	// 찜한 게시글의 이미지경로
			map.put("mem_num", mem_num);	// 찜한 게시글의 회원번호
			map.put("mem_name", mem_name);	// 찜한 게시글의 아이디
			SqlMapClientTemplate.insert("choice.insert", map);	// 찜했을때 필요한 내용들 insert
			mv.setViewName("/choice/choiceAjax.jsp");
		}
		else{
			mv.setViewName("/choice/choiceFail.jsp");
		}
		return mv;
		
	}
	
	@RequestMapping("choiceMain.nhn")
	public ModelAndView choiceMain(int mynum, choiceDTO dto, HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		
		
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) SqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		Map picmap = new HashMap();
		picmap.put("mem_num", memDTO.getNum());
		proDTO = (ProfilePicDTO) SqlMapClientTemplate.queryForObject("profile.newpic", picmap); // 프로필
																					// 사진을
																					// 가져옴
		request.setAttribute("name", memDTO.getName());
		request.setAttribute("num", memDTO.getNum());
		
		
		List list = SqlMapClientTemplate.queryForList("choice.all", mynum);		// 찜한 게시글 다가져오기
		int count = (int)SqlMapClientTemplate.queryForObject("choice.count", mynum);	// 찜한 게시글 개수
		
		mv.addObject("proDTO",proDTO);
		mv.addObject("memDTO",memDTO);
		mv.addObject("list", list);
		mv.addObject("mynum", mynum);
		mv.addObject("count", count);
		mv.setViewName("/choice/choiceMain.jsp");
		return mv;
	}
	
	@RequestMapping("choiceDetail.nhn")
	public ModelAndView choiceDetail(int c_no, int mynum){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("c_no", c_no);
		map.put("mynum", mynum);
		int pro_num = (int)SqlMapClientTemplate.queryForObject("choice.num", map);	// 찜한 게시글의 게시글번호(proboardlist num)
		String pro_pic = (String)SqlMapClientTemplate.queryForObject("choice.pro_pic", pro_num);
		mv.addObject("pro_num", pro_num);
		mv.setViewName("/choice/choiceDetail.jsp");
		return mv;
	}
	
	@RequestMapping("choiceDelete.nhn")
	public ModelAndView choiceDelete(int mynum, int c_no){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("mynum", mynum);
		map.put("c_no", c_no);
		SqlMapClientTemplate.delete("choice.delete", map);
		mv.addObject("mynum", mynum);
		mv.setViewName("/choice/choiceDelete.jsp");
		return mv;
	}
}
