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
	public ModelAndView choice(int mem_num, int price, String pro_pic, String mem_name, String content, HttpSession session, int num){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		String sessionId = (String)session.getAttribute("memId");
		int mynum = (int)SqlMapClientTemplate.queryForObject("choice.mynum", sessionId);		// ȸ�� ������ȣ ��������
		map.put("mynum", mynum);	// ȸ�� ������ȣ
		map.put("num", num);			// ���� �Խñ��� �Խñ۹�ȣ
		int numcount = (int)SqlMapClientTemplate.queryForObject("choice.numcount", map);		// ���� �Խñ��� �̹� �����ϸ� 1 �ƴϸ� 0
		if (numcount == 0) {
			String categ = (String)SqlMapClientTemplate.queryForObject("choice.categ", num);	// �Խñ��� ī�װ��̸� ��������
			map.put("content", content);	// ���� �Խñ��� ����
			map.put("price", price);		// ���� �Խñ��� ��ǰ����
			map.put("pro_pic", pro_pic);	// ���� �Խñ��� �̹������
			map.put("mem_num", mem_num);	// ���� �Խñ��� ȸ����ȣ
			map.put("mem_name", mem_name);	// ���� �Խñ��� ���̵�
			SqlMapClientTemplate.insert("choice.insert", map);	// �������� �ʿ��� ����� insert
			mv.setViewName("/choice/choiceAjax.jsp");
		}
		else{
			mv.setViewName("/choice/choiceFail.jsp");
		}
		return mv;
		
	}
	
	@RequestMapping("choiceMain.nhn")
	public ModelAndView choiceMain(int mynum, choiceDTO dto, HttpSession session){
		ModelAndView mv = new ModelAndView();
		String sessionId = (String)session.getAttribute("memId");
		List list = SqlMapClientTemplate.queryForList("choice.all", mynum);		// ���� �Խñ� �ٰ�������
		int count = (int)SqlMapClientTemplate.queryForObject("choice.count", mynum);	// ���� �Խñ� ����
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
		int pro_num = (int)SqlMapClientTemplate.queryForObject("choice.num", map);	// ���� �Խñ��� �Խñ۹�ȣ(proboardlist num)
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
