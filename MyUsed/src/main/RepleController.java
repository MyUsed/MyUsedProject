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
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	private List<RepleDTO> replelist = new ArrayList<RepleDTO>();;	
	
	@RequestMapping("/reple.nhn")
	public ModelAndView reple(String reple,int renum,int remem_num, HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
	
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		
		
		String name = (String)sqlMap.queryForObject("main.name",sessionId);
		
		System.out.println("����ۼ��� ="+name);
		System.out.println("ȸ����ȣ = "+remem_num);
		System.out.println("�۹�ȣ = "+renum);
		System.out.println("��۳��� = "+reple);
		
		Map map = new HashMap();
		map.put("boardnum", renum); // �Խñ۹�ȣ
		map.put("mem_num", remem_num); // ���ôٴ� ȸ����ȣ
		map.put("content", reple);  // ���ôٴ� ����
		map.put("name", name); // ���ôٴ� ȸ���̸�
		
		sqlMap.insert("reple.insert",map); // ��� ���� 
		System.out.println("��� ���Լ���");
		
		
		replelist = sqlMap.queryForList("reple.select", renum);
		System.out.println("����Ʈ ������ ");
		
		
		
		mv.addObject("replelist",replelist);
		mv.addObject("reple",reple);
		mv.setViewName("/main/test.jsp");
		return mv;
	}
	
	


}
