package main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import member.MemberDTO;

@Controller
public class ModifyProfileController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	@RequestMapping("/ModifyProfile.nhn")
	public String ModifyProfile(HttpServletRequest request){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		request.setAttribute("memDTO", memDTO);

		return "/main/MyUsedModifyProfile.jsp";
	}
}
