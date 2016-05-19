package member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ImageDeleteController {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	@RequestMapping("/MyUsedDeleteAll.nhn")
	public String MyUsedDeleteAll(HttpServletRequest request, int mem_num){
		
		request.setAttribute("mem_num", mem_num);
		
		return "/member/MyUsedDeleteAll.jsp";
	}

	@RequestMapping("/MyUsedDeleteAllPro.nhn")
	public String MyUsedDeletePro(HttpServletRequest request, int mem_num){
		String result = "";
		
		Map deleteMap = new HashMap();
		deleteMap.put("mem_num", mem_num);
		
		// 디폴트 이미지를 제외한 이미지 개수
		int count = (Integer)sqlMapClientTemplate.queryForObject("profile.countProPic", deleteMap);
		
		// count가 0보다 켜야 전체 삭제 가능
		if(count > 0){
			sqlMapClientTemplate.delete("profile.deleteAll_profile", deleteMap);
			System.out.println(mem_num+" 의 프로필 이미지가 모두 삭제되었습니다.");
			result = "/member/MyUsedDeletePro.jsp";
			
		} else{
			result = "/member/MyUsedDeleteAll_fail.jsp";
		}
		
		request.setAttribute("mem_num", mem_num);
		
		return result;
	}
	
	
	@RequestMapping("/MyUsedDeleteCoverAll.nhn")
	public String MyUsedDeleteCoverAll(HttpServletRequest request, int mem_num){
		
		request.setAttribute("mem_num", mem_num);
		
		return "/member/MyUsedDeleteCoverAll.jsp";
	}

	@RequestMapping("/MyUsedDeleteCoverAllPro.nhn")
	public String MyUsedDeleteCoverAllPro(HttpServletRequest request, int mem_num){
		String result = "";
		
		Map deleteMap = new HashMap();
		deleteMap.put("mem_num", mem_num);
		
		// 디폴트 이미지를 제외한 이미지 개수
		int count = (Integer)sqlMapClientTemplate.queryForObject("profile.countcoverPic", deleteMap);
		
		// count가 0보다 켜야 전체 삭제 가능
		if(count > 0){
			sqlMapClientTemplate.delete("profile.deleteCoverAll_profile", deleteMap);
			System.out.println(mem_num+" 의 커버 이미지가 모두 삭제되었습니다.");
			result = "/member/MyUsedDeletePro.jsp";
			
		} else{
			result = "/member/MyUsedDeleteAll_fail.jsp";
		}
		
		request.setAttribute("mem_num", mem_num);
		
		return result;
	}
}
