package main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import friend.FriendDTO;
import member.MemberDTO;

@Controller
public class PictureController {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	@RequestMapping("/AllPicture.nhn")
	public String AllPicture(HttpServletRequest request){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		Map picMap = new HashMap();
		picMap.put("mem_num", memDTO.getNum());
		
		/** ������ ���� */
		List profileList = new ArrayList();
		profileList = sqlMapClientTemplate.queryForList("profile.prohistory",picMap);
		
		/** Ŀ�� ���� */
		List coverList = new ArrayList();
		coverList = sqlMapClientTemplate.queryForList("profile.coverhistory",picMap);
		
		/** ���� ���� */
		List stateList = new ArrayList();
		stateList = sqlMapClientTemplate.queryForList("profile.selectpic",picMap);

		/** ��ǰ ���� */
		List productList = new ArrayList();
		productList = sqlMapClientTemplate.queryForList("profile.selectpropic",picMap);
		

		request.setAttribute("profileList", profileList);
		request.setAttribute("coverList", coverList);
		request.setAttribute("stateList", stateList);
		request.setAttribute("productList", productList);
		
		
		return "/main/MyUsedPicture.jsp";
	}
	

	
}
