package paper;

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
public class PaperController {
	@Autowired
	private SqlMapClientTemplate SqlMapClientTemplate;

	@RequestMapping("paperMain.nhn")	// ���� �����ִ� ����
	public ModelAndView paperMain(int mynum, HttpServletRequest request){
		
		String pagecurrent = request.getParameter("currentPage");	// ������������ parameter���� ��� ����
		int currentPage = 1;	// ����������
		int totalCount = 0;		// ��ü �Խñ� ��
		int blockCount = 10;	// �� ������ �Խñ� ��
		int blockPage = 5;		// 5���������� �����Ǹ� 6���� �ٽû� ��
		int lastCount = 0;		// ������ ���� �� �Խñ�
		String pagingHtml;
		
		if(pagecurrent != null){	// ���������� parameter�� ���� ������ null�� �ƴϸ�
			currentPage = Integer.parseInt(pagecurrent);	// ������������ ����
		}
		else{	
			currentPage = 1;	// ������������ null�̸� 1
		}
		
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("mynum", mynum);	// ȸ�� ���� ��ȣ
		List list = SqlMapClientTemplate.queryForList("paper.all", map); // �������̺� ���� �ٰ�������

		totalCount = list.size();	// list�� �����ŭ totalCount�� ����
		pagingAction page = new pagingAction(currentPage, totalCount, blockCount, blockPage, mynum);
		pagingHtml = page.getPagingHtml().toString();	// ���ڷ� ��ȯ
		lastCount = totalCount;	
		
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;
		
		 list = list.subList(page.getStartCount(), lastCount);
		 
		
		int paperCount = (int)SqlMapClientTemplate.queryForObject("paper.paperCount", map);	// �� ���� ����. state�� ��������
		mv.addObject("list", list);
		mv.addObject("mynum", mynum);
		mv.addObject("pagingHtml", pagingHtml);
		mv.addObject("paperCount", paperCount);
		mv.setViewName("/paper/paperMain.jsp");
		return mv;
	}
	
	@RequestMapping("paperForm.nhn")	// ���� ���� ��
	public ModelAndView paperForm(int mynum, String name){
		ModelAndView mv = new ModelAndView();
		mv.addObject("mynum", mynum);
		mv.addObject("name", name);
		mv.setViewName("/paper/paperForm.jsp");
		return mv;
	}
	
	@RequestMapping("paperSend.nhn")	// ���� ������ ��
	public ModelAndView paperSend(PaperDTO dto, int mynum, String r_content, String r_name, HttpSession session){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		String sessionId = (String)session.getAttribute("memId");
		map.put("mynum", mynum);	// ���� ���� ȸ�� ���� ��ȣ
		map.put("r_id", r_name);	// ���� ���� ȸ�� id
		int memNum = (int)SqlMapClientTemplate.queryForObject("paper.memberNum", map);	//DB�� insert�� ȸ�� ���� ��ȣ ã��
		map.put("memNum", memNum);	// ���� ���� ȸ�� ���� ��ȣ
		map.put("s_content", r_content);	// ���� ���� ����
		map.put("s_name", sessionId);	// ���� ��� ���̵�
		SqlMapClientTemplate.insert("paper.send", map);	// ���� ���� ȸ�� DB�� insert
		
		mv.addObject("mynum", mynum);
		mv.setViewName("/paper/paperSend.jsp");
		return mv;
	}
	
	@RequestMapping("paperDelete.nhn")	// ��ü �� ���� ���� ����
	public ModelAndView paperDelete(int check[], int mynum){
		Map map = new HashMap();
		for (int i = 0; i < check.length; i++) {	//check�� ���� ��ŭ ����
			map.put("m_no", check[i]);	// �۹�ȣ(check[i])��  m_no�� map�� �־���
			map.put("mynum", mynum);
			SqlMapClientTemplate.delete("paper.delete", map);	// ���� ����
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("mynum", mynum);
		mv.setViewName("/paper/paperDelete.jsp");
		return mv;
	}
	
	@RequestMapping("paperView.nhn")	// ���� ���� ����
	public ModelAndView paperView(PaperDTO dto, int m_no, HttpSession session){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		String sessionId = (String)session.getAttribute("memId");
		map.put("r_id", sessionId);	// sessionId
		
		int mynum = (int)SqlMapClientTemplate.queryForObject("paper.memberNum", map);	// ȸ�� ���� ��ȣ ��������
		map.put("mynum", mynum);	// ȸ�� ���� ��ȣ
		map.put("m_no", m_no);		// ���� �� ��ȣ
		
		dto = (PaperDTO)SqlMapClientTemplate.queryForObject("paper.memAll", map);	// ���� ���� 1�� ��������
		int stateCount = (int)SqlMapClientTemplate.queryForObject("paper.stateCount", map);	// �� ���� ����. state�� ��������
		
		if(stateCount == 1){	// ���� ��������(1)�̸� 0���� �ٲ���
			SqlMapClientTemplate.update("paper.state", map);	// ���� ������ state�� 0���� �ٲ���.
		}
		
		String memname = dto.getS_name();	// memberlist���� �̸��� ���������� ����� ����
		String name = (String)SqlMapClientTemplate.queryForObject("paper.name", memname);	// memberlist���� ����� �̸� ��������
		
		mv.addObject("dto", dto);
		mv.addObject("mynum", mynum);
		mv.addObject("m_no", m_no);
		mv.addObject("name", name);
		mv.setViewName("/paper/paperView.jsp");
		return mv;
		
	}
	
	@RequestMapping("paperViewDelete.nhn")	// �信�� ���� ����
	public ModelAndView paperViewDelete(int mynum, int m_no){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("mynum", mynum);
		map.put("m_no", m_no);
		SqlMapClientTemplate.delete("paper.delete", map);
		mv.addObject("mynum", mynum);
		mv.setViewName("/paper/paperDelete.jsp");
		return mv;
	}
	
	@RequestMapping("paperFriendList.nhn")	// ģ�����
	public ModelAndView paperFriendList(int mynum){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("mynum", mynum);
		List list = SqlMapClientTemplate.queryForList("paper.FriendId", map);
		mv.addObject("list", list);
		mv.setViewName("/paper/paperFriendList.jsp");
		return mv;
		
	}
}
