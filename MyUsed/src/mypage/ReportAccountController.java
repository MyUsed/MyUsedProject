package mypage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ibatis.sqlmap.client.SqlMapClient;

import member.MemberDTO;

@Controller
public class ReportAccountController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	@RequestMapping("/ReportAccount.nhn")
	public String ReportAccount(HttpServletRequest request, int mem_num){
		/** 신고하려는 사람 정보 */
		MemberDTO frimemDTO = new MemberDTO();
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);
		
		/** 디비에 있는 신고 사유들  */
		List reasons = new ArrayList();
		reasons = sqlMapClientTemplate.queryForList("report.selectReasons", null);
		
		request.setAttribute("frimemDTO", frimemDTO);
		request.setAttribute("reasons", reasons);
		request.setAttribute("mem_num", mem_num);
		
		return "/mypage/reportAccount.jsp";
	}
	

	@RequestMapping("/ReportAccountPro.nhn")
	public String ReportAccountPro(HttpServletRequest request, int mem_num, String name, String reason){

		Map report = new HashMap();
		report.put("mem_num", mem_num);
		report.put("name", name);
		report.put("reason", reason);
		sqlMapClientTemplate.insert("report.insertReport", report);	//신고 내역 insert
		
		sqlMapClientTemplate.update("report.updatePoint", mem_num);	//memberlist에서 포인트 -1
		
		return "/mypage/reportAccountPro.jsp";
	}
}
