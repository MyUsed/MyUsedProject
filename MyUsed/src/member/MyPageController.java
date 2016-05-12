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
		
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		MemberDTO frimemDTO = new MemberDTO();
		System.out.println("mem_num : "+mem_num);
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);
		
		
		//ģ�� ��� ����Ʈ ��������(state����)
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
		
		/***** �� �� �� �ִ� ģ��*****/
		String sql = "";
		
		Map num_map = new HashMap();
		num_map.put("num", mem_num);
		
		List friNumList = new ArrayList();
		friNumList = sqlMapClientTemplate.queryForList("friend.friendNumList", num_map);
		int size = friNumList.size();
		
		System.out.println(size);
		// ���Ͼ��� �Ͽ� ���̺��� �̾���δ� -> mem_num�� ģ������ŭ �ݺ�(���������� union�� ������ �ȵ����� ���� �ٿ���)
		for(int i = 0 ; i < friNumList.size()-1 ; i++){
			sql += "select * from friendlist_"+friNumList.get(i)+" union ";
		}
		sql = sql + "select * from friendlist_"+friNumList.get(size-1);
		
		System.out.println(sql);

		// �̾���� sql���� �Ϻθ� Map�� �̿��� sqlMap���� ��������
		Map sqlmap = new HashMap();
		sqlmap.put("sql", sql);
		
		// mem_num�� ģ������Ʈ(�󵵼� ����)
		List knewFriendList = new ArrayList();
		knewFriendList = sqlMapClientTemplate.queryForList("friend.all", sqlmap);

		//����Ʈ�� �ڱ��ڽ��� ���ԵǾ� ���� �� �� �����Ƿ� ã�Ƽ� �������ش�
		FriendDTO friDTO = new FriendDTO();
		for (int i = 0; i < knewFriendList.size() ; i++){
			if(mem_num == ((FriendDTO) knewFriendList.get(i)).getMem_num()){
				knewFriendList.remove(i);
			}
		}
		
		
		/** �� �� �� �ִ� ģ������ ������ ���� */
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
		
		
		
		
		/** ������ ���� */
		// �ش� ������ ������ �����ʻ���
		Map profileMap = new HashMap();
		profileMap.put("mem_num", mem_num);
		proDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap);
		
		// ���� ���̵��� �����ʻ���
		Map profileMap2 = new HashMap();
		profileMap2.put("mem_num", memDTO.getNum());
		sessionproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap);
		
		
		/** Ŀ�� ���� */
		// �ش� ������ ������ Ŀ������
		Map coverMap = new HashMap();
		coverMap.put("mem_num", mem_num);
		coverDTO =  (CoverPicDTO) sqlMapClientTemplate.queryForObject("profile.newCoverpic", coverMap);
		
	
		

		request.setAttribute("knewFriendList_image", knewFriendList_image);
		request.setAttribute("mem_num", mem_num); // ���Ǿ��̵��� mem_num �ƴ�/ ���� �������� mem_num
		request.setAttribute("proDTO", proDTO);
		request.setAttribute("coverDTO", coverDTO);
		request.setAttribute("sessionCoverDTO", sessionCoverDTO);
		request.setAttribute("knewFriendList", knewFriendList);
		request.setAttribute("sessionName", memDTO.getName());
		request.setAttribute("name", frimemDTO.getName());
		request.setAttribute("num", frimemDTO.getNum());
		request.setAttribute("mynum", memDTO.getNum());	// ���Ǿ��̵��� mem_num
		request.setAttribute("friendList", friendList);
		request.setAttribute("friendState0", friendState0);
		request.setAttribute("friendState1", friendState1);
		request.setAttribute("friendState2", friendState2);
		request.setAttribute("friendState_m1", friendState_m1);
		
		return "/member/MyUsedMyPage.jsp";
	}

}
