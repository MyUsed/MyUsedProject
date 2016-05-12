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
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private ProfilePicDTO sessionproDTO = new ProfilePicDTO();
	private CoverPicDTO coverDTO = new CoverPicDTO();
	private CoverPicDTO sessionCoverDTO = new CoverPicDTO();
	
	
	@RequestMapping("/MyUsedMyPage.nhn")
	public String MyUsedMyPage(HttpServletRequest request, int mem_num){
		
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		MemberDTO frimemDTO = new MemberDTO();
		System.out.println("mem_num : "+mem_num);
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);
		
		
		//친구 목록 리스트 가져가기(state별로)
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
		
		/***** 알 수 도 있는 친구*****/
		String sql = "";
		
		Map num_map = new HashMap();
		num_map.put("num", mem_num);
		
		List friNumList = new ArrayList();
		friNumList = sqlMapClientTemplate.queryForList("friend.friendNumList", num_map);
		int size = friNumList.size();
		
		System.out.println(size);
		// 유니언을 하여 테이블을 이어붙인다 -> mem_num의 친구수만큼 반복(마지막줄은 union이 붙으면 안됨으로 따로 붙여줌)
		for(int i = 0 ; i < friNumList.size()-1 ; i++){
			sql += "select * from friendlist_"+friNumList.get(i)+" union ";
		}
		sql = sql + "select * from friendlist_"+friNumList.get(size-1);
		
		System.out.println(sql);

		// 이어붙인 sql문의 일부를 Map을 이용해 sqlMap으로 가져간다
		Map sqlmap = new HashMap();
		sqlmap.put("sql", sql);
		
		// mem_num의 친구리스트(빈도순 정렬)
		List knewFriendList = new ArrayList();
		knewFriendList = sqlMapClientTemplate.queryForList("friend.all", sqlmap);

		//리스트에 자기자신이 포함되어 있을 수 도 있으므로 찾아서 삭제해준다
		FriendDTO friDTO = new FriendDTO();
		for (int i = 0; i < knewFriendList.size() ; i++){
			if(mem_num == ((FriendDTO) knewFriendList.get(i)).getMem_num()){
				knewFriendList.remove(i);
			}
		}
		
		
		/** 알 수 도 있는 친구들의 프로필 사진 */
		int friend_num;
		Map friend_numMap = new HashMap();
		List knewFriendList_image = new ArrayList();
		for (int i = 0; i < knewFriendList.size() ; i++){
			friend_num = ((FriendDTO) knewFriendList.get(i)).getMem_num();
			
			friend_numMap.put("mem_num", friend_num);

			ProfilePicDTO friproDTO = new ProfilePicDTO();
			friproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", friend_numMap);

			knewFriendList_image.add(i, friproDTO);
		}

		for (int i = 0; i < knewFriendList_image.size() ; i++){
			//System.out.println(knewFriendList_image.get(i));
			System.out.println(((ProfilePicDTO)knewFriendList_image.get(i)).getProfile_pic());
		}
		
		
		
		
		/** 프로필 사진 */
		// 해당 페이지 주인의 프로필사진
		Map profileMap = new HashMap();
		profileMap.put("mem_num", mem_num);
		proDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap);
		
		// 세션 아이디의 프로필사진
		Map profileMap2 = new HashMap();
		profileMap2.put("mem_num", memDTO.getNum());
		sessionproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap);
		
		
		/** 커버 사진 */
		// 해당 페이지 주인의 커버사진
		Map coverMap = new HashMap();
		coverMap.put("mem_num", mem_num);
		coverDTO =  (CoverPicDTO) sqlMapClientTemplate.queryForObject("profile.newCoverpic", coverMap);
		
	
		

		request.setAttribute("knewFriendList_image", knewFriendList_image);
		request.setAttribute("mem_num", mem_num); // 세션아이디의 mem_num 아님/ 현재 페이지의 mem_num
		request.setAttribute("proDTO", proDTO);
		request.setAttribute("coverDTO", coverDTO);
		request.setAttribute("sessionCoverDTO", sessionCoverDTO);
		request.setAttribute("knewFriendList", knewFriendList);
		request.setAttribute("sessionName", memDTO.getName());
		request.setAttribute("name", frimemDTO.getName());
		request.setAttribute("num", frimemDTO.getNum());
		request.setAttribute("mynum", memDTO.getNum());	// 세션아이디의 mem_num
		request.setAttribute("friendList", friendList);
		request.setAttribute("friendState0", friendState0);
		request.setAttribute("friendState1", friendState1);
		request.setAttribute("friendState2", friendState2);
		request.setAttribute("friendState_m1", friendState_m1);
		
		return "/member/MyUsedMyPage.jsp";
	}

}
