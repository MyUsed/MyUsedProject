package mypage;

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

import friend.FriendCategDTO;
import friend.FriendDTO;
import main.ProBoardCategDTO;
import member.CoverPicDTO;
import member.MemberDTO;
import member.ProfilePicDTO;

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
		String result="";	//리턴될 view경로
		
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		/** 해당 페이지 주인의 정보 */
		MemberDTO frimemDTO = new MemberDTO();
		System.out.println("mem_num : "+mem_num);
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);
		
		/** mem_num이 등록된 사용자인지 확인 */
		int judMem_num  = (Integer) sqlMapClientTemplate.queryForObject("member.judmem_num", mem_num);
		if(judMem_num == 0){	// 해당 mem_num이 없음
			result = "/mypage/MyPageNone.jsp";
			
		}else{
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
			
			/** 친구 카테고리 */
			FriendCategDTO fricagDTO = new FriendCategDTO();
		    List friendCateg = new ArrayList();
		    friendCateg = sqlMapClientTemplate.queryForList("friend.friendCateg", null);
		    
			/** 로그인한 사용자와 해당 페이지의 주인이 친구 관계인지 확인 */
		    for(int i = 0 ; i < friendList.size() ; i++){
		    	// mem_num이 나 자신이 아니고 mem_num이 친구리스트에 포함된 번호일때 => 방문한 페이지가 친구로 등록된 페이지 일 때
		    	if( mem_num != memDTO.getNum() && mem_num == ((FriendDTO)friendList.get(i)).getMem_num()){
		    		request.setAttribute("friendCheck", 1);	//friendCheck로 1을 보냄
		    	}
		    }
			
			/***** 알 수 도 있는 친구*****/
			String sql = "";
			
			Map num_map = new HashMap();
			num_map.put("num", mem_num);
			
			List friNumList = new ArrayList();
			friNumList = sqlMapClientTemplate.queryForList("friend.friendNumList", num_map);
			int size = friNumList.size();
			System.out.println(size);
			
			// 친구의 수가 0보다 클때만
			if(size > 0){
				// 유니언을 하여 테이블을 이어붙인다 -> mem_num의 친구수만큼 반복(마지막줄은 union이 붙으면 안됨으로 따로 붙여줌)
				for(int i = 0 ; i < friNumList.size()-1 ; i++){
					sql += "select * from friendlist_"+friNumList.get(i)+" union ";
				}
				sql = sql + "select * from friendlist_"+friNumList.get(size-1);
				
				System.out.println("sql : "+sql);

				// 이어붙인 sql문의 일부를 Map을 이용해 sqlMap으로 가져간다
				Map sqlmap = new HashMap();
				sqlmap.put("sql", sql);
				
				// mem_num의 친구리스트(빈도순 정렬)
				List knewFriendList = new ArrayList();
				knewFriendList = sqlMapClientTemplate.queryForList("friend.all", sqlmap);

				// 리스트에 자기자신이 포함되어 있을 수 도 있으므로 찾아서 삭제해준다
				FriendDTO friDTO = new FriendDTO();
				for (int i = 0; i < knewFriendList.size() ; i++){
					if(mem_num == ((FriendDTO) knewFriendList.get(i)).getMem_num()){
						knewFriendList.remove(i);
					}
				}
				
				// 리스트에 이미 친구로 등록된 친구가 추천되어있을 수 있으므로 찾아서 삭제해준다.
				for(int i = 0; i < friendList.size() ; i++){
					for(int j = 0; j < knewFriendList.size() ; j++){
						// 모든 친구 리스트가 뽑힌 friendList와 자기 자신을 제거한 knewFriendList를 비교해서 동일한 mem_num이 있나 찾는다
						if(((FriendDTO) friendList.get(i)).getMem_num() == ((FriendDTO) knewFriendList.get(j)).getMem_num()){
							// 만약 있다면 knewFriendList에서 지워준다.
							knewFriendList.remove(j);
						}
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

				request.setAttribute("knewFriendList_image", knewFriendList_image);
				request.setAttribute("knewFriendList", knewFriendList);
				
			}
			
			
			
			/** 프로필 사진 */
			// 해당 페이지 주인의 프로필사진
			Map profileMap = new HashMap();
			profileMap.put("mem_num", mem_num);
			proDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap);
			
			// 세션 아이디의 프로필사진
			Map profileMap2 = new HashMap();
			profileMap2.put("mem_num", memDTO.getNum());
			sessionproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap2);
			
			
			/** 커버 사진 */
			// 해당 페이지 주인의 커버사진
			Map coverMap = new HashMap();
			coverMap.put("mem_num", mem_num);
			coverDTO =  (CoverPicDTO) sqlMapClientTemplate.queryForObject("profile.newCoverpic", coverMap);
			
			
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
			
			/** 프로필 사진 뽑아오기(세션아이디 아님) -> 프로필 사진 히스토리 */
			Map hisMap = new HashMap();
			hisMap.put("mem_num", mem_num);
			List prohisList = new ArrayList();
			prohisList = sqlMapClientTemplate.queryForList("profile.prohistory",hisMap);
			
			
			/** 커버 사진 뽑아오기(세션아이디 아님) -> 커버 사진 히스토리 */
			List coverhisList = new ArrayList();
			coverhisList = sqlMapClientTemplate.queryForList("profile.coverhistory",hisMap);
			

			/** 해당 페이지 주인이 올린 모든 사진 */
			List picList = new ArrayList();
			picList = sqlMapClientTemplate.queryForList("member.All_image", mem_num);
			
			/** 내가 쓴 글목록 불러오기 */
			List list = new ArrayList();
			list = sqlMapClientTemplate.queryForList("main.per_board", mem_num); // state 리스트
			List prolist = new ArrayList();
			prolist = sqlMapClientTemplate.queryForList("main.per_proboard", mem_num); // product 리스트
			
			/** 상품 카테고리 추가 */
			ProBoardCategDTO categDTO0 = new ProBoardCategDTO();
			List categList = new ArrayList();
			categList = sqlMapClientTemplate.queryForList("procateg.selectCateg", 0);

			request.setAttribute("categList", categList);
			request.setAttribute("checked", "checked");
			
			request.setAttribute("list",list);
			request.setAttribute("prolist",prolist);
			request.setAttribute("picList", picList);
			request.setAttribute("coverhisList", coverhisList);
			request.setAttribute("prohisList", prohisList);
			request.setAttribute("mem_num", mem_num); // 세션아이디의 mem_num 아님/ 현재 페이지의 mem_num
			request.setAttribute("proDTO", proDTO);
			request.setAttribute("coverDTO", coverDTO);
			request.setAttribute("sessionCoverDTO", sessionCoverDTO);
			request.setAttribute("sessionproDTO", sessionproDTO);
			request.setAttribute("sessionName", memDTO.getName());
			request.setAttribute("name", frimemDTO.getName());
			request.setAttribute("num", frimemDTO.getNum());
			request.setAttribute("mynum", memDTO.getNum());	// 세션아이디의 mem_num
			request.setAttribute("friendList", friendList);
			request.setAttribute("friendState0", friendState0);
			request.setAttribute("friendState1", friendState1);
			request.setAttribute("friendState2", friendState2);
			request.setAttribute("friendState_m1", friendState_m1);
		    request.setAttribute("friendCateg", friendCateg);
		    request.setAttribute("memDTO", memDTO);
			
		    result = "/mypage/MyUsedMyPage.jsp";
		}
		
		return result;
	}

	@RequestMapping("/BigViewImage.nhn")
	public String BigViewimage(HttpServletRequest request, String pic){	
		request.setAttribute("pic", pic);
		return "/mypage/bigViewImage.jsp";
	}

	@RequestMapping("/prowrite_categ2.nhn")
	public String prowrite_categ2(HttpServletRequest request, String categ0){
		System.out.println("=================== ajax실행 =======================");
		Map categMap = new HashMap();
	
		categMap.put("categ", categ0);
		categMap.put("ca_level", 0);
		int ca_group = (Integer)sqlMapClientTemplate.queryForObject("procateg.findgroup", categMap);
		System.out.println(categMap);
		
		Map categMap2 = new HashMap();
		categMap2.put("ca_group", ca_group);
		categMap2.put("ca_level", 1);
		
		List categList = new ArrayList();	
		categList = sqlMapClientTemplate.queryForList("procateg.selectCategGroup", categMap2);
		
		request.setAttribute("categList", categList);
		request.setAttribute("categ0", categ0);
		
		return "/mypage/prowrite_categ2.jsp";
	}
}
