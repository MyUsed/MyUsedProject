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
		int mynum = (int)SqlMapClientTemplate.queryForObject("choice.mynum", sessionId);		// ȸ�� ������ȣ ��������
		String categ = (String)SqlMapClientTemplate.queryForObject("choice.categ", mem_num);	// �Խñ��� ī�װ��̸� ��������
		map.put("mynum", mynum);	// ȸ�� ������ȣ
		map.put("content", content);	// ���� �Խñ��� ����
		map.put("price", price);		// ���� �Խñ��� ��ǰ����
		map.put("pro_pic", pro_pic);	// ���� �Խñ��� �̹������
		map.put("mem_num", mem_num);	// ���� �Խñ��� ȸ����ȣ
		map.put("mem_name", mem_name);	// ���� �Խñ��� ���̵�
		SqlMapClientTemplate.insert("choice.insert", map);	// �������� �ʿ��� ����� insert
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
