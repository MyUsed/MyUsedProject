package friend;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import member.MemberDTO;

@Controller
public class FriendDeleteController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;


	@RequestMapping("/DeleteFriend.nhn")
	public String deleteFriend(HttpServletRequest request, int mem_num){
		/** 삭제하려는 친구의 정보 */
		MemberDTO frimemDTO = new MemberDTO();
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);
	
		request.setAttribute("mem_num", mem_num);
		request.setAttribute("frimemDTO", frimemDTO);
		return "/friend/deleteFriend.jsp";
	}
	
	@RequestMapping("/DeleteFriendPro.nhn")
	public String deleteFriendPro(HttpServletRequest request, int mem_num){
		/** 로그인한 사용자의 정보 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		System.out.println(mem_num);
		
		/** 내 친구리스트에서도 삭제하고 삭제하려는 친구의 리스트에서도 나를 삭제*/
		Map map = new HashMap();
		map.put("num", memDTO.getNum());	// 내 번호
		map.put("mem_num", mem_num);		// 삭제하려는 친구 번호
		sqlMapClientTemplate.delete("friend.deleteMyFriend",map);
		
		Map map2 = new HashMap();
		map2.put("num", mem_num);				// 삭제하려는 친구 번호
		map2.put("mem_num", memDTO.getNum());	// 내 번호	
		sqlMapClientTemplate.delete("friend.deleteMyFriend",map2);
		
	
		request.setAttribute("mem_num",  memDTO.getNum());	// 나의 페이지로 이동하기우해 mem_num에 내 번호 넣음
		return "/friend/deleteFriendPro.jsp";
	}

}
