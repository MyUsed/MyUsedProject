package choice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class choiceController {
	@Autowired
	private SqlMapClientTemplate SqlMapClientTemplate;

	@RequestMapping("choiceInsert.nhn")
	public ModelAndView choice(int mem_num, int price, String pro_pic, String mem_name, String content, HttpSession session){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		String sessionId = (String)session.getAttribute("memId");
		int mynum = (int)SqlMapClientTemplate.queryForObject("choice.mynum", sessionId);		// 회원 고유번호 가져오기
		String categ = (String)SqlMapClientTemplate.queryForObject("choice.categ", mem_num);	// 게시글의 카테고리이름 가져오기
		map.put("mynum", mynum);	// 회원 고유번호
		map.put("content", content);	// 찜한 게시글의 내용
		map.put("price", price);		// 찜한 게시글의 상품가격
		map.put("pro_pic", pro_pic);	// 찜한 게시글의 이미지경로
		map.put("mem_num", mem_num);	// 찜한 게시글의 회원번호
		map.put("mem_name", mem_name);	// 찜한 게시글의 아이디
		SqlMapClientTemplate.insert("choice.insert", map);	// 찜했을때 필요한 내용들 insert
		mv.setViewName("MyUsed.nhn");
		return mv;
	}
	
	@RequestMapping("choiceMain.nhn")
	public ModelAndView choiceMain(int mynum){
		ModelAndView mv = new ModelAndView();
		List list = SqlMapClientTemplate.queryForList("choice.all", mynum);
		mv.addObject("list", list);
		mv.setViewName("/choice/choiceMain.jsp");
		return mv;
	}
}
