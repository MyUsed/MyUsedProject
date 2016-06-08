package admin.mem;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import member.MemberDTO;

@Controller
public class AdminReportAccController {

	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	@RequestMapping("/MyUsedDetailInfo.nhn")
	public ModelAndView MyUsedDetailInfo(int mem_num){
		ModelAndView mv = new ModelAndView();	
		int num = mem_num;
		MemberDTO memDTO = new MemberDTO();  
		memDTO = (MemberDTO) sqlMap.queryForObject("admin_mem.selectMem", num);
		
		String profile = (String) sqlMap.queryForObject("admin_mem.profile", mem_num);

		mv.addObject("profile", profile);
		mv.addObject("mem_num", mem_num);
		mv.addObject("memDTO", memDTO);
		mv.setViewName("/admin_member/AdminMemDetail.jsp");	
		return mv;
	}	
	
	@RequestMapping("/MyUsedModPoint.nhn")
	public ModelAndView MyUsedModPoint(int num, int point){
		ModelAndView mv = new ModelAndView();	
		Map map = new HashMap();
		map.put("num", num);
		map.put("point", point);
		System.out.println(map);
		sqlMap.update("admin_mem.updatePoint", map);

		mv.addObject("point", point);
		mv.setViewName("/admin_member/modify_point.jsp");	
		return mv;
	}	
	
	@RequestMapping("/MyUsedModGrade.nhn")
	public ModelAndView MyUsedModGrade(int num, int grade){
		ModelAndView mv = new ModelAndView();	
		Map map = new HashMap();
		map.put("num", num);
		map.put("grade", grade);
		System.out.println(map);
		sqlMap.update("admin_mem.updateGrade", map);

		mv.addObject("grade", grade);
		mv.setViewName("/admin_member/modify_grade.jsp");	
		return mv;
	}	
	
}
