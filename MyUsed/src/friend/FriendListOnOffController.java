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
import member.ProfilePicDTO;

@Controller
public class FriendListOnOffController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	@RequestMapping("/FriendList.nhn")
	public String friendListonoff(HttpServletRequest request){
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		

		/** 상태2인 친구만 뽑음 */
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		System.out.println(map);
		
		List friendState2 = new ArrayList();
		friendState2 = sqlMapClientTemplate.queryForList("friend.friendState2", map);

		/** 친구 목록 프로필 사진뽑기 */
		if(friendState2.size() > 0){
			List friprofileList = new ArrayList();
			for(int i = 0 ; i < friendState2.size() ; i++){
				// 상태2인 친구 목록의 번호만 뽑기
				int frinum = ((FriendDTO)friendState2.get(i)).getMem_num();
				System.out.println(frinum);
				
				// 해당 번호를 가진 프로필 사진 테이블을 찾아 최근 사진 레코드를 리스트에 넣는다
				Map frinumMap = new HashMap();
				frinumMap.put("mem_num", frinum);
				
				ProfilePicDTO friproDTO = new ProfilePicDTO();
				friproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", frinumMap);

				friprofileList.add(i, friproDTO);				
			}

			for (int i = 0; i < friprofileList.size() ; i++){
				//System.out.println(knewFriendList_image.get(i));
				System.out.println(((ProfilePicDTO)friprofileList.get(i)).getProfile_pic());
			}
			request.setAttribute("friprofileList", friprofileList);
		}
		request.setAttribute("friendState2", friendState2);
		
		return "/mypage/friendList.jsp";
	}
	
	
}
