package admin.categ;

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
public class AdminCategController {

	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	@RequestMapping("/ModifyCateg.nhn")
	public ModelAndView ModifyCateg(){
		ModelAndView mv = new ModelAndView();	
		
		List categ0List = new ArrayList();
		categ0List = sqlMap.queryForList("procateg.viewCateg", null);

		mv.addObject("categ0List", categ0List);
		mv.setViewName("/admin_categ/AdminModifyCateg.jsp");	
		return mv;
	}	
	
	@RequestMapping("/ModifyCateg_index.nhn")
	public ModelAndView ModifyCateg_index(int ca_group){
		ModelAndView mv = new ModelAndView();	
		Map map = new HashMap();
		map.put("ca_level", 1);
		map.put("ca_group", ca_group);
		
		List categ1List = new ArrayList();
		categ1List = sqlMap.queryForList("procateg.selectCategGroup", map);

		mv.addObject("ca_group", ca_group);
		mv.addObject("categ1List", categ1List);
		mv.setViewName("/admin_categ/AdminModifyCateg_index.jsp");	
		return mv;
	}	
	
	@RequestMapping("/ModifyCateg0insert.nhn")
	public ModelAndView ModifyCateg0insert(String categ){
		ModelAndView mv = new ModelAndView();
		sqlMap.insert("procateg.insertCateg", categ);
		mv.setViewName("/admin_categ/AdminModifyCateg0Plus_redirect.jsp");	
		return mv;
	}	
	
	@RequestMapping("/ModifyCateg1insert.nhn")
	public ModelAndView ModifyCateg1insert(String categ, int ca_group){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("categ", categ);
		map.put("ca_group", ca_group);
		System.out.println(map);
		sqlMap.insert("procateg.insertCateg1", map);
		mv.setViewName("/admin_categ/AdminModifyCateg_index.jsp");	
		return mv;
	}	
	
	@RequestMapping("/ModifyCateg0modify.nhn")
	public ModelAndView ModifyCateg0modify(String categ, String categ_modi){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("categ", categ);
		map.put("categ_modi", categ_modi);
		
		sqlMap.update("procateg.modifyCateg0", map);
		mv.setViewName("/admin_categ/AdminModifyCateg0Plus_redirect.jsp");	
		return mv;
	}	
	
	
	@RequestMapping("/ModifyCateg1modify.nhn")
	public ModelAndView ModifyCateg1modify(String categ, String categ_modi, int ca_group){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("categ", categ);
		map.put("categ_modi", categ_modi);
		map.put("ca_group", ca_group);
		
		sqlMap.update("procateg.modifyCateg1", map);
		mv.setViewName("/admin_categ/AdminModifyCateg0Plus_redirect.jsp");	
		return mv;
	}	
	
	@RequestMapping("/ModifyCategdelete.nhn")
	public ModelAndView ModifyCateg0delete(String categ, int ca_group, int ca_level){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("categ", categ);
		map.put("ca_group", ca_group);
		map.put("ca_level", ca_level);
		
		sqlMap.delete("procateg.deleteCateg", map);
		mv.setViewName("/admin_categ/AdminModifyCategdelete_redirect.jsp");	
		return mv;
	}	
	
}
