package admin.mem;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminMemInfoController {

	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	@RequestMapping("/MyUsedMemInfo.nhn")
	public ModelAndView MyUsedMemInfo(){
		ModelAndView mv = new ModelAndView();	
		
		List modifyList = new ArrayList();
		modifyList = sqlMap.queryForList("admin_mem.allRequest", null);
		
		mv.addObject("modifyList", modifyList);
		
		mv.setViewName("/admin_member/AdminMemInfo.jsp");	
		return mv;
	}	
	
	@RequestMapping("/MyUsedMemInfo_index.nhn")
	public ModelAndView MyUsedMemInfo_index(String sort, String categ){
		ModelAndView mv = new ModelAndView();	

		System.out.println(sort+"/"+categ);
		List modifyList = new ArrayList();
		
		if(sort.equals("type")){
			String type = categ;
			System.out.println(type);
			modifyList = sqlMap.queryForList("admin_mem.type_sort", type);
			System.out.println(modifyList.size());
		}else if(sort.equals("state")){
			int state = Integer.parseInt(categ);
			modifyList = sqlMap.queryForList("admin_mem.state_sort", state);
			System.out.println(modifyList.size());
		}

		mv.addObject("modifyList", modifyList);
		mv.setViewName("/admin_member/AdminMemInfo_index.jsp");	
		return mv;
	}
	
	@RequestMapping("/MyUsedMemInfo_searchmem.nhn")
	public ModelAndView MyUsedMemInfo_searchmem(int mem_num){
		ModelAndView mv = new ModelAndView();	

		List modifyList = new ArrayList();
		System.out.println(mem_num);
		modifyList = sqlMap.queryForList("admin_mem.search_mem", mem_num);
	
		mv.addObject("modifyList", modifyList);
		mv.setViewName("/admin_member/AdminMemInfo_index.jsp");	
		return mv;
	}
	
	@RequestMapping("/ModifyInfo.nhn")
	public ModelAndView ModifyInfo(int num, int mem_num, String type, String changeval){
		ModelAndView mv = new ModelAndView();	

		Map map = new HashMap();
		map.put("type", type);				// ������ memberlist�� �÷���
		map.put("changeval", changeval);	// ���� ��
		map.put("num", mem_num);			// ȸ����ȣ
		
		sqlMap.update("admin_mem.modifyInfo", map);	// memberlist���̺��� ����
		sqlMap.update("admin_mem.permit", num);		// ���¸� 1�� �ٲ���
		
		
		Map map2 = new HashMap();
		map2.put("num", mem_num);
		map2.put("categ", "modify_permit");	//���� �˸� ���̺�
		sqlMap.insert("admin_mem.insertNotice", map2);
		
		mv.setViewName("/admin_member/AdminModifyReject.jsp");	
		return mv;
	}

	@RequestMapping("/ModifyReject.nhn")
	public ModelAndView ModifyReject(int num, String type, int mem_num){
		ModelAndView mv = new ModelAndView();	

		sqlMap.update("admin_mem.reject", num);	
		
		Map map2 = new HashMap();
		map2.put("num", mem_num);
		map2.put("categ", "modify_reject");	//���� �˸� ���̺�
		sqlMap.insert("admin_mem.insertNotice", map2);
		
		mv.setViewName("/admin_member/AdminModifyReject.jsp");	
		return mv;
	}
}
