package main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProBoardCategController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

/*	// 카테고리 조회
	@RequestMapping("/categtest.nhn")
	public String categtest(HttpServletRequest request){

		ProBoardCategDTO categDTO0 = new ProBoardCategDTO();
		List categList = new ArrayList();
		
		categList = sqlMapClientTemplate.queryForList("procateg.selectCateg", 0);
		
		request.setAttribute("categList", categList);
		
		return "/member/categtest.jsp";
	}*/
	

	@RequestMapping("/categindex.nhn")
	public String categindex(HttpServletRequest request, String categ0,String deposit){
		Map categMap = new HashMap();
		categMap.put("categ", categ0);
		categMap.put("ca_level", 0);
		int ca_group = (Integer)sqlMapClientTemplate.queryForObject("procateg.findgroup", categMap);
		System.out.println(categMap);
		
		Map categMap2 = new HashMap();
		categMap2.put("ca_group", ca_group);
		categMap2.put("ca_level", 1);
		
		List categList = new ArrayList();	
		categList = sqlMapClientTemplate.queryForList("procateg.selectCategGroup", categMap2);
		
		List prolist = new ArrayList();
		prolist = sqlMapClientTemplate.queryForList("main.proboardView", null); 	// product 리스트
		
		request.setAttribute("prolist", prolist);
		request.setAttribute("categList", categList);
		request.setAttribute("categ0", categ0);
		
		
		return "/main/categindex.jsp";
	}
	
	
		
}
