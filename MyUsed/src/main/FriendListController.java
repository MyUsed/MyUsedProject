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
public class FriendListController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	@RequestMapping("/MyUsedfriendList.nhn")
	public String MyUsedfriendList(HttpServletRequest request){

		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		/** 친구상태2인 친구만 뽑기*/
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		System.out.println(map);
		
		List friendState2 = new ArrayList();
		friendState2 = sqlMapClientTemplate.queryForList("friend.friendState2", map);
		
		/** 친구목록  + 친구들의 프로필 사진  리스트
		 * 1. 친구리스트에서 친구의 num를 찾아 리스트에 담는다
		 * 2. 친구의 num을 이용해 해당 친구의 현재 프로필 사진을 찾는다(프로필 사진 테이블의 가장 최근 레코드) 
		 * 3. 친구의 현재 프로필 사진이 들어있는 레코드들을 union을 이용하여 이어붙인다.
		 * 4. 이어붙인 테이블과 친구리스트와 조인하여 출력한다.
		 * */
		String friendpic_sql = "";
		
		for(int i = 0 ; i < friendState2.size() ; i++){
			System.out.println(friendState2.size());
		}
		
		// 친구목록이 0보다 클때
		if(friendState2.size() > 0){
			// 유니언을 하여 테이블을 이어붙인다 -> mem_num의 친구수만큼 반복(마지막줄은 union이 붙으면 안됨으로 따로붙여줌)
			for (int i = 0; i < friendState2.size() - 1; i++) {
				friendpic_sql += "select * from profilepic_" + ((FriendDTO)friendState2.get(i)).getMem_num() + " where pic_num = (select max(pic_num) from profilepic_" + ((FriendDTO)friendState2.get(i)).getMem_num() + ") union ";
			}
			friendpic_sql += "select * from profilepic_" + ((FriendDTO)friendState2.get(friendState2.size()-1)).getMem_num() + " where pic_num = (select max(pic_num) from profilepic_" + ((FriendDTO)friendState2.get(friendState2.size()-1)).getMem_num() + ")";
			
			System.out.println(friendpic_sql);
			
			Map frisqlMap = new HashMap();
			frisqlMap.put("friendpic_sql", friendpic_sql);
			frisqlMap.put("num", memDTO.getNum());	//세션 아이디의 mem_num아님 / 현재 페이지의 mem_num
			System.out.println(frisqlMap);
			
			// 현재 페이지의 친구목록+프로필사진
			List friendpicList = new ArrayList();
			friendpicList = sqlMapClientTemplate.queryForList("friend.friendproPic", frisqlMap);
			
			for(int i = 0 ; i < friendpicList.size() ; i++){
				System.out.println(((FriendDTO)friendpicList.get(i)).getProfile_pic());
			}
			
			request.setAttribute("friendpicList", friendpicList);
		}
		request.setAttribute("memDTO", memDTO);
		
		return "/main/MyUsedFriendList.jsp";
	}
}
