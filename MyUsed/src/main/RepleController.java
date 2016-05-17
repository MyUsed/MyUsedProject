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
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	private List<RepleDTO> replelist = new ArrayList<RepleDTO>();;	
	
	@RequestMapping("/reple.nhn")
	public ModelAndView reple(int num){
		ModelAndView mv = new ModelAndView();
		System.out.println(num);
		
		Timestamp reg = (Timestamp)sqlMap.queryForObject("reple.boardreg",num); // �Խñ� ��ϵ� �ð� ��������
		String name = (String)sqlMap.queryForObject("reple.boardname",num); // boardlist���� �۾��� �̸� ��������
		int mem_num = (int)sqlMap.queryForObject("reple.mem_num",num); // ��۴ٴ� ����� ȸ����ȣ ��������
		String content =(String)sqlMap.queryForObject("reple.content",num); // �Խñ��� ���� �������� 
		String board_pic = (String)sqlMap.queryForObject("reple.pic",num); // �Խñ��� ���� ��������
		
		replelist = sqlMap.queryForList("reple.select", num); // ��� �������� 
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy�� MM�� dd�� aa hh�� mm��");
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
		int mem_num = (int)sqlMap.queryForObject("main.num",sessionId); // ����ۼ��� ȸ���� ��ȣ ��������
		String re_name = (String)sqlMap.queryForObject("main.name",sessionId); // ����ۼ��� ȸ���� �̸� 
		
		System.out.println("����ID = "+sessionId);
		System.out.println("��۳��� = "+reple);
		System.out.println("��� �ۼ���ȸ����ȣ = "+mem_num);
		System.out.println("��� �ۼ���ȸ���̸� = "+re_name);
		
		System.out.println("�Խñ۹�ȣ ="+boardnum);
		
		Map map = new HashMap();
		map.put("boardnum", boardnum); 
		map.put("mem_num", mem_num);
		map.put("content", reple);
		map.put("name", re_name);
		
		sqlMap.insert("reple.insert",map);   // ��� ���� 
		
		
		mv.setViewName("reple.nhn?num="+boardnum);
		return mv;
	}
	
	


}
