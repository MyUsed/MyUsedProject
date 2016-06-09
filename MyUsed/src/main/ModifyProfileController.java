package main;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import member.MemberDTO;
import member.ProfilePicDTO;

@Controller
public class ModifyProfileController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private MemberDTO memDTO = new MemberDTO();
	private HttpServletRequest request;

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
	
	@RequestMapping("/RecomfrimPw.nhn")
	public String RecomfrimPw(HttpServletRequest request){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		/** ������ ���� : ���� ���̵��� �����ʻ��� */
		Map profileMap2 = new HashMap();
		profileMap2.put("mem_num", memDTO.getNum());
		ProfilePicDTO sessionproDTO = new ProfilePicDTO();
		sessionproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap2);
		
		request.setAttribute("memDTO", memDTO);
		request.setAttribute("sessionproDTO", sessionproDTO);

		return "/main/recomfirmPw.jsp";
	}
	
	@RequestMapping("/ModifyPw.nhn")
	public String ModifyPw(HttpServletRequest request, String signup_pw){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		Map pw = new HashMap();
		pw.put("password", signup_pw);
		pw.put("num", memDTO.getNum());
		sqlMapClientTemplate.update("member.modiPw", pw);
		
		request.setAttribute("memDTO", memDTO);
		return "/main/ModifyPw.jsp";
	}
	
	@RequestMapping("/Modify_name.nhn")
	public String Modify_name(HttpServletRequest request, String fname, String lname, String reason){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		Map map = new HashMap();
		map.put("mem_num", memDTO.getNum());
		map.put("type", "name");
		map.put("changeval", lname+fname);
		map.put("reason", reason);
		sqlMapClientTemplate.insert("member.ModifyInfo", map);
		
		return "/main/MyUsedModifyProfilePro.jsp";
	}

	@RequestMapping("/Modify_id.nhn")
	public String Modify_id(HttpServletRequest request, String id, String reason){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		Map map = new HashMap();
		map.put("mem_num", memDTO.getNum());
		map.put("type", "id");
		map.put("changeval", id);
		map.put("reason", reason);
		sqlMapClientTemplate.insert("member.ModifyInfo", map);
		
		return "/main/MyUsedModifyProfilePro.jsp";
	}

	@RequestMapping("/Modify_birth.nhn")
	public String Modify_birth(HttpServletRequest request, String year, String month, String date, String reason){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		Map map = new HashMap();
		map.put("mem_num", memDTO.getNum());
		map.put("type", "birthdate");
		map.put("changeval", year+"-"+month+"-"+date);
		map.put("reason", reason);
		sqlMapClientTemplate.insert("member.ModifyInfo", map);
		
		return "/main/MyUsedModifyProfilePro.jsp";
	}

	@RequestMapping("/Modify_gender.nhn")
	public String Modify_gender(HttpServletRequest request, String gender, String reason){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		Map map = new HashMap();
		map.put("mem_num", memDTO.getNum());
		map.put("type", "gender");
		map.put("changeval", gender);
		map.put("reason", reason);
		sqlMapClientTemplate.insert("member.ModifyInfo", map);
		
		return "/main/MyUsedModifyProfilePro.jsp";
	}
}
