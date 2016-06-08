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

	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
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
		map.put("type", type);				// 수정할 memberlist의 컬럼명
		map.put("changeval", changeval);	// 수정 값
		map.put("num", mem_num);			// 회원번호
		
		sqlMap.update("admin_mem.modifyInfo", map);	// memberlist테이블에서 수정
		sqlMap.update("admin_mem.permit", num);		// 상태를 1로 바꿔줌
		
		
		Map map2 = new HashMap();
		map2.put("num", mem_num);
		map2.put("categ", "modify_permit");	//개인 알림 테이블
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
		map2.put("categ", "modify_reject");	//개인 알림 테이블
		sqlMap.insert("admin_mem.insertNotice", map2);
		
		mv.setViewName("/admin_member/AdminModifyReject.jsp");	
		return mv;
	}
}
