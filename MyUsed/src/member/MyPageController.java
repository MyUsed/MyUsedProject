package member;

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

@Controller
public class MyPageController {
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private MemberDTO memDTO = new MemberDTO();
	
	
	@RequestMapping("/MyUsedMyPage.nhn")
	public String MyUsedMyPage(HttpServletRequest request){
		
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		//친구 목록 리스트 가져가기
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		System.out.println(map);
		
		List friendList = new ArrayList();
		friendList = sqlMapClientTemplate.queryForList("friend.allFriend", map);

		List friendState0 = new ArrayList();
		friendState0 = sqlMapClientTemplate.queryForList("friend.friendState0", map);

		List friendState1 = new ArrayList();
		friendState1 = sqlMapClientTemplate.queryForList("friend.friendState1", map);
		
		List friendState2 = new ArrayList();
		friendState2 = sqlMapClientTemplate.queryForList("friend.friendState2", map);
		
		List friendState_m1 = new ArrayList();
		friendState_m1 = sqlMapClientTemplate.queryForList("friend.friendState_m1", map);


		request.setAttribute("name", memDTO.getName());
		request.setAttribute("num", memDTO.getNum());
		request.setAttribute("friendList", friendList);
		request.setAttribute("friendState0", friendState0);
		request.setAttribute("friendState1", friendState1);
		request.setAttribute("friendState2", friendState2);
		request.setAttribute("friendState_m1", friendState_m1);
		
		return "/member/MyUsedMyPage.jsp";
	}
	

}
