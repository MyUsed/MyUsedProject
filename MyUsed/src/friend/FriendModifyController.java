package friend;

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

import member.MemberDTO;

@Controller
public class FriendModifyController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;


	@RequestMapping("/ModifyFriendCateg.nhn")
	public String modifyFriendCateg(HttpServletRequest request, int mem_num){
		System.out.println(mem_num);
		
		/** 변경하려는 친구의 정보 */
		MemberDTO frimemDTO = new MemberDTO();
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);

		FriendCategDTO fricagDTO = new FriendCategDTO();
		List friendCateg = new ArrayList();
		friendCateg = sqlMapClientTemplate.queryForList("friend.friendCateg", null);

		request.setAttribute("frimemDTO", frimemDTO);
		request.setAttribute("friendCateg", friendCateg);
		request.setAttribute("mem_num", mem_num);
		
		return "/friend/modifyFriendCateg.jsp";
	}

	@RequestMapping("/ModifyFriendCategPro.nhn")
	public String modifyFriendCategPro(HttpServletRequest request, int mem_num, String fri_categ){
		/** 로그인한 사용자의 정보 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		/** 변경하려는 친구의 정보 */
		MemberDTO frimemDTO = new MemberDTO();
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);

		/** 내 친구리스트에서도 변경하고 변경하려는 친구의 리스트에서도 나를 변경*/
		Map map = new HashMap();
		map.put("num", memDTO.getNum());	// 내 번호
		map.put("mem_num", mem_num);		// 변경하려는 친구 번호
		map.put("categ", fri_categ);
		sqlMapClientTemplate.update("friend.ModifyFriend",map);

		Map map2 = new HashMap();
		map2.put("mem_num", mem_num);		// 내 번호
		map2.put("num", memDTO.getNum());	// 변경하려는 친구 번호
		map2.put("categ", fri_categ);
		sqlMapClientTemplate.update("friend.ModifyFriend",map2);
		
		

		request.setAttribute("frimemDTO", frimemDTO);

		return "/friend/modifyFriendCategPro.jsp";
	}


}
