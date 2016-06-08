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
public class AdminDetailInfoController {

	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	@RequestMapping("/MyUsedMemReport.nhn")
	public ModelAndView MyUsedMemReport(){
		ModelAndView mv = new ModelAndView();	
		List reportList = new ArrayList();
		reportList = sqlMap.queryForList("admin_mem.reportAcc", null);

		List reasonList = new ArrayList();
		reasonList = sqlMap.queryForList("report.selectReasons", null);

		
		mv.addObject("reasonList", reasonList);
		mv.addObject("reportList", reportList);
		mv.setViewName("/admin_member/AdminMemReport.jsp");	
		return mv;
	}	
	
	@RequestMapping("/MyUsedMemReport_index.nhn")
	public ModelAndView MyUsedMemReport_index(String sort, String word){
		ModelAndView mv = new ModelAndView();	

		Map map = new HashMap();
		map.put("sort", sort);
		map.put("word", word);
		List searchList = new ArrayList();
		searchList = sqlMap.queryForList("admin_mem.searchSort", map);

		mv.addObject("searchList", searchList);
		mv.setViewName("/admin_member/AdminMemReport_index.jsp");	
		return mv;
	}	
	
	@RequestMapping("/MyUsedMemReport_reason.nhn")
	public ModelAndView MyUsedMemReport_reason(int re_num){
		ModelAndView mv = new ModelAndView();	

		String reason = (String)sqlMap.queryForObject("admin_mem.selectReasons", re_num);
		List searchList = new ArrayList();
		searchList = sqlMap.queryForList("admin_mem.sortReason", reason);

		mv.addObject("searchList", searchList);
		mv.setViewName("/admin_member/AdminMemReport_index.jsp");	
		return mv;
	}		
}
