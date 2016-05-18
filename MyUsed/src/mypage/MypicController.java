package mypage;

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
import member.ProfilePicDTO;

@Controller
public class MypicController {
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private List<MainpicDTO> piclist = new ArrayList<MainpicDTO>();;
	
	@RequestMapping("/picture.nhn")
	public ModelAndView picture(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
			
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		
		String name = (String)sqlMap.queryForObject("main.name",sessionId); // �̸���������
		int num = (int)sqlMap.queryForObject("main.num",sessionId); // ȸ����ȣ ��������
		
		
		Map picmap = new HashMap();
		picmap.put("num", num);
		piclist = sqlMap.queryForList("reple.my_pic",picmap); // ������ ���θ� ������
		
		picmap.put("mem_num",num);
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // ������ ����������
		
		
		mv.addObject("proDTO",proDTO);
		mv.addObject("piclist",piclist);
		mv.addObject("name",name);
		mv.addObject("mem_num",num);
		mv.addObject("mynum",num);
		
		mv.setViewName("/mypage/picture.jsp");
		return mv;
		
	}

}
