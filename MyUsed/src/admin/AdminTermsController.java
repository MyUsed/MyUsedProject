package admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminTermsController {
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private ModelAndView mv = new ModelAndView();

	@RequestMapping("admin_termsMain.nhn")
	public ModelAndView termsMain(adminTermsDTO Tdto){
		Tdto = (adminTermsDTO)sqlMapClientTemplate.queryForObject("adminTerms.all", null);
		int count = (int)sqlMapClientTemplate.queryForObject("adminTerms.count", null);
		mv.addObject("Tdto", Tdto);
		mv.addObject("count", count);
		mv.setViewName("/admin_terms/termsMain.jsp");
		return mv;
	}
	
	@RequestMapping("admin_termsWrite.nhn")
	public ModelAndView termsWrite(){
		mv.setViewName("/admin_terms/termsWrite.jsp");
		return mv;
	}
	
	@RequestMapping("admin_termsInsert.nhn")
	public ModelAndView termsInsert(String content1, String content2, String content3){
		Map map = new HashMap();
		map.put("content1", content1);
		map.put("content2", content2);
		map.put("content3", content3);
		sqlMapClientTemplate.insert("adminTerms.insert", map);
		mv.setViewName("/admin_terms/termsInsert.jsp");
		return mv;
	}
	
	@RequestMapping("admin_termsUpdateForm.nhn")
	public ModelAndView termsUpdateForm(int seq_num, adminTermsDTO Tdto){
		Tdto = (adminTermsDTO)sqlMapClientTemplate.queryForObject("adminTerms.one", seq_num);
		mv.addObject("Tdto", Tdto);
		mv.setViewName("/admin_terms/termsUpdateForm.jsp");
		return mv;
	}
	
	@RequestMapping("admin_termsUpdate.nhn")
	public ModelAndView termsUpdate(String content1, String content2, String content3){
		Map map = new HashMap();
		map.put("content1", content1);
		map.put("content2", content2);
		map.put("content3", content3);
		sqlMapClientTemplate.insert("adminTerms.update", map);
		mv.setViewName("/admin_terms/termsUpdate.jsp");
		return mv;
	}
	
	@RequestMapping("admin_termsDelete.nhn")
	public String termsDelete(int seq_num){
		sqlMapClientTemplate.delete("adminTerms.delete", seq_num);
		return "/admin_terms/termsDelete.jsp";
	}
		
	@RequestMapping("admin_termsSubmit.nhn")
	public ModelAndView termsSubmit(){
		ModelAndView mv = new ModelAndView();
		sqlMapClientTemplate.queryForList("adminTerms.all", null);
		
		return mv;
		
	}
	
}
