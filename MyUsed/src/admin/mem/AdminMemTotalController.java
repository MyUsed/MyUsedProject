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
public class AdminMemTotalController {

	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	@RequestMapping("/MyUsedMemTotal.nhn")
	public ModelAndView MyUsedMemTotal(){
		ModelAndView mv = new ModelAndView();	
		mv.setViewName("/admin_member/AdminMemTotal.jsp");	
		return mv;
	}	
	
	@RequestMapping("/MyUsedSearchMem.nhn")
	public ModelAndView MyUsedSearchMem(String categ, String word){
		ModelAndView mv = new ModelAndView();
		
		Map map = new HashMap();
		map.put("categ", categ);
		map.put("word", word);
		
		List searchMemList = new ArrayList();
		searchMemList = sqlMap.queryForList("admin_mem.searchMem", map);
		
		mv.addObject("searchMemList", searchMemList);
		mv.setViewName("/admin_member/AdminMemSearch.jsp");	
		return mv;
	}	
	
	@RequestMapping("/MyUsedGrade.nhn")
	public ModelAndView MyUsedGrade(int grade){
		ModelAndView mv = new ModelAndView();
		List searchMemList = new ArrayList();
		searchMemList = sqlMap.queryForList("admin_mem.searchGrade", grade);
		
		mv.addObject("searchMemList", searchMemList);
		mv.setViewName("/admin_member/AdminMemSearch.jsp");	
		return mv;
	}	
	
	@RequestMapping("/MyUsedPoint.nhn")
	public ModelAndView MyUsedPoint(String point){
		ModelAndView mv = new ModelAndView();
		List searchMemList = new ArrayList();
		searchMemList = sqlMap.queryForList("admin_mem.pointSort", point);
		
		mv.addObject("searchMemList", searchMemList);
		mv.setViewName("/admin_member/AdminMemSearch.jsp");	
		return mv;
	}	
	
	@RequestMapping("/MyUsedNaver.nhn")
	public ModelAndView MyUsedNaver(int naverid){
		ModelAndView mv = new ModelAndView();
		List searchMemList = new ArrayList();
		if(naverid == 0){//���̹� ȸ�� �ƴҶ�
			searchMemList = sqlMap.queryForList("admin_mem.not_naver", null);
		}else{
			searchMemList = sqlMap.queryForList("admin_mem.naver", null);
		}
		mv.addObject("searchMemList", searchMemList);
		mv.setViewName("/admin_member/AdminMemSearch.jsp");	
		return mv;
	}	
	
	@RequestMapping("/MyUsedOnoff.nhn")
	public ModelAndView MyUsedOnoff(int onoff){
		ModelAndView mv = new ModelAndView();
		List searchMemList = new ArrayList();
		if(onoff == 0){//������
			searchMemList = sqlMap.queryForList("admin_mem.onoff_mem", onoff);
		}else{
			searchMemList = sqlMap.queryForList("admin_mem.onoff_mem", onoff);
		}
		
		mv.addObject("searchMemList", searchMemList);
		mv.setViewName("/admin_member/AdminMemSearch.jsp");	
		return mv;
	}	
	
	
	@RequestMapping("/MyUsedGender.nhn")
	public ModelAndView MyUsedGender(String gender){
		ModelAndView mv = new ModelAndView();
		List searchMemList = new ArrayList();
		
		searchMemList = sqlMap.queryForList("admin_mem.genderSort", gender);
	
		mv.addObject("searchMemList", searchMemList);
		mv.setViewName("/admin_member/AdminMemSearch.jsp");	
		return mv;
	}	
}
