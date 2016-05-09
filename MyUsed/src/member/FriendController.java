package member;


import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FriendController {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	Calendar today = Calendar.getInstance(); //오늘 날짜 구하기.
	
	private MemberDTO memDTO = new MemberDTO();
	private FriendDTO friDTO = new FriendDTO();
			
	@RequestMapping("/MyUsedAddFriend.nhn")
	public String addFriend(HttpServletRequest request, int num, int mem_num, String id, String fri_categ){
		String result = "";
		
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		MemberDTO mem_friDTO = new MemberDTO();
		// 나의 정보
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		// 상대방의 정보
		mem_friDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", id);
		
		/** 친구리스트에 포함되어 있는 넘버인지 검사 */
		Map frimap = new HashMap();
		frimap.put("num", num);	// 나의 num
		frimap.put("mem_num", mem_num);	// 친구신청 받는 사람의 num
		
		// 1 친구 사이 / 0 이면 친구사이아님 -> 등록해주어야 
		int amongFriend = (Integer)sqlMapClientTemplate.queryForObject("friend.amongFriend", frimap);
		if(amongFriend == 1){
			
			result = "/member/MyUsedAlreadyFriend.jsp";
			
		}else{

			/** 나의 친구리스트에 추가 */
			Map map1 = new HashMap();
			map1.put("num", num);	// 나의 num
			map1.put("mem_num", mem_num);	// 친구신청 받는 사람의 num
			map1.put("id", id);
			map1.put("name", mem_friDTO.getName());
			map1.put("state", "0");
			map1.put("categ", fri_categ);
			
			System.out.println(map1);
			
			sqlMapClientTemplate.insert("friend.addFriend", map1);
			

			/** 친구신청 받는 사람의 친구리스트에 나를 추가 */
			Map map2 = new HashMap();
			map2.put("num", mem_num);	// 나의 num
			map2.put("mem_num", num);	// 친구신청 받는 사람의 num
			map2.put("id", sessionId);
			map2.put("name", memDTO.getName());
			map2.put("state", "1");
			map2.put("categ", fri_categ);
			
			System.out.println(map2);
			
			sqlMapClientTemplate.insert("friend.addFriend", map2);
			
			result = "/member/MyUsedAddFriend.jsp";
			
		}
		
		
		request.setAttribute("mem_num", mem_num);
		
		return result;
	}
	
	
	@RequestMapping("/MyUsedAgreeFriend.nhn")
	public String MyUsedAgreeFriend(HttpServletRequest request ,int agree, int mem_num, int num){
		// mem_num은 친구 신청한 상대방의 번호, num은 나의 번호

		System.out.println("num : "+num);
		System.out.println("mem_num : "+mem_num);
		System.out.println("agree : "+agree);	//0 : 수락 /1 : 거절
		
		
		if(agree == 0){	// 상대방이 친구를 수락했을 경우

			// 나의 리스트에서 상대방의 상태를 바꿈
			Map map = new HashMap();
			map.put("num", num);	// 나의 num
			map.put("mem_num", mem_num);	// 친구신청 받는 사람의 num
			map.put("state", "2");
		
			// 상대방의 리스트에서 나의 상태를 바꿈
			Map map1 = new HashMap();
			map1.put("num", mem_num);	// 나의 num
			map1.put("mem_num", num);	// 친구신청 받는 사람의 num
			map1.put("state", "2");
			
			sqlMapClientTemplate.update("friend.friendAgree", map);
			sqlMapClientTemplate.update("friend.friendAgree", map1);
			
		}else{ // 친구 신청을 거절했을 경우 상대방 리스트에서는 나를 지우고 나의 리스트에서는 상태를 -1로 바꿔준다
			Map map = new HashMap();
			map.put("num", num);	// 나의 num
			map.put("mem_num", mem_num);	// 친구신청 받는 사람의 num
			map.put("state", "-1");

			sqlMapClientTemplate.update("friend.friendAgree", map);
			sqlMapClientTemplate.delete("friend.deleteFriend", map);
			
		}
		request.setAttribute("num", num);
		return "/member/MyUsedAgreeFriend.jsp";
	}
	
	/** 상대방이 거절 눌렀을 경우 나의 테이블에서 삭제 */
	@RequestMapping("/MyUsedRejectionFriend.nhn")
    
	public String MyUsedRejectionFriend(int agree, int mem_num, int num){
		// mem_num은 친구 신청한 상대방의 번호, num은 나의 번호
		
		Map map = new HashMap();
		map.put("num", num);	// 나의 num
		map.put("mem_num", mem_num);	// 친구신청 받는 사람의 num

		sqlMapClientTemplate.delete("friend.deleteFriend", map);

		
		return "/member/MyUsedAgreeFriend.jsp";
	}

}
