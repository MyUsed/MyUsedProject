package main;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import friend.FriendCategDTO;
import friend.FriendDTO;
import member.CoverPicDTO;
import member.MemberDTO;
import member.ProfilePicDTO;

@Controller
public class MainFriendController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate; 
	private MemberDTO memDTO = new MemberDTO();
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private ProfilePicDTO sessionproDTO = new ProfilePicDTO();
	private CoverPicDTO coverDTO = new CoverPicDTO();
	private CoverPicDTO sessionCoverDTO = new CoverPicDTO();
	private FriendDTO friDTO = new FriendDTO();
	
	
	
	@RequestMapping("/MyUsedFriend.nhn")
	public String MyUsedFriend(HttpServletRequest request, int mem_num){

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
		
		/** ģ�� ī�װ� */
		FriendCategDTO fricagDTO = new FriendCategDTO();
	    List friendCateg = new ArrayList();
	    friendCateg = sqlMapClientTemplate.queryForList("friend.friendCateg", null);
	    

		/** ������ ���� */
		// �ش� ������ ������ �����ʻ���
		Map profileMap = new HashMap();
		profileMap.put("mem_num", mem_num);
		proDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap);
		
		// ���� ���̵��� �����ʻ���
		Map profileMap2 = new HashMap();
		profileMap2.put("mem_num", memDTO.getNum());
		sessionproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap2);
		
		
		/** Ŀ�� ���� */
		// �ش� ������ ������ Ŀ������
		Map coverMap = new HashMap();
		coverMap.put("mem_num", mem_num);
		coverDTO =  (CoverPicDTO) sqlMapClientTemplate.queryForObject("profile.newCoverpic", coverMap);
		

		/** ������ ���� �̾ƿ���(���Ǿ��̵� �ƴ�) -> ������ ���� �����丮 */
		Map hisMap = new HashMap();
		hisMap.put("mem_num", mem_num);
		List prohisList = new ArrayList();
		prohisList = sqlMapClientTemplate.queryForList("profile.prohistory",hisMap);
		
		
		/** Ŀ�� ���� �̾ƿ���(���Ǿ��̵� �ƴ�) -> Ŀ�� ���� �����丮 */
		Map cohisrMap = new HashMap();
		cohisrMap.put("mem_num", mem_num);
		List coverhisList = new ArrayList();
		coverhisList = sqlMapClientTemplate.queryForList("profile.coverhistory",hisMap);
		
		
		
		/***** �� �� �� �ִ� ģ��*****/
		String sql = "";
		
		Map num_map = new HashMap();
		num_map.put("num", mem_num);
		
		List friNumList = new ArrayList();
		friNumList = sqlMapClientTemplate.queryForList("friend.friendNumList", num_map);
		int size = friNumList.size();
		System.out.println(size);
		
		// ģ���� ���� 0���� Ŭ����
		if(size > 0){
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

			// ����Ʈ�� �ڱ��ڽ��� ���ԵǾ� ���� �� �� �����Ƿ� ã�Ƽ� �������ش�
			FriendDTO friDTO = new FriendDTO();
			for (int i = 0; i < knewFriendList.size() ; i++){
				if(mem_num == ((FriendDTO) knewFriendList.get(i)).getMem_num()){
					knewFriendList.remove(i);
				}
			}
			
			// ����Ʈ�� �̹� ģ���� ��ϵ� ģ���� ��õ�Ǿ����� �� �����Ƿ� ã�Ƽ� �������ش�.
			for(int i = 0; i < friendList.size() ; i++){
				for(int j = 0; j < knewFriendList.size() ; j++){
					// ��� ģ�� ����Ʈ�� ���� friendList�� �ڱ� �ڽ��� ������ knewFriendList�� ���ؼ� ������ mem_num�� �ֳ� ã�´�
					if(((FriendDTO) friendList.get(i)).getMem_num() == ((FriendDTO) knewFriendList.get(j)).getMem_num()){
						// ���� �ִٸ� knewFriendList���� �����ش�.
						knewFriendList.remove(j);
					}
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

			request.setAttribute("knewFriendList_image", knewFriendList_image);
			request.setAttribute("knewFriendList", knewFriendList);
			
		}
		
		/** ģ�����  + ģ������ ������ ����  ����Ʈ
		 * 1. ģ������Ʈ���� ģ���� num�� ã�� ����Ʈ�� ��´�
		 * 2. ģ���� num�� �̿��� �ش� ģ���� ���� ������ ������ ã�´�(������ ���� ���̺��� ���� �ֱ� ���ڵ�) 
		 * 3. ģ���� ���� ������ ������ ����ִ� ���ڵ���� union�� �̿��Ͽ� �̾���δ�.
		 * 4. �̾���� ���̺�� ģ������Ʈ�� �����Ͽ� ����Ѵ�.
		 * */
		String friendpic_sql = "";
		
		for(int i = 0 ; i < friendState2.size() ; i++){
			System.out.println(friendState2.size());
		}
		
		// ģ������� 0���� Ŭ��
		if(friendState2.size() > 0){
			// ���Ͼ��� �Ͽ� ���̺��� �̾���δ� -> mem_num�� ģ������ŭ �ݺ�(���������� union�� ������ �ȵ����� ���κٿ���)
			for (int i = 0; i < friendState2.size() - 1; i++) {
				friendpic_sql += "select * from profilepic_" + ((FriendDTO)friendState2.get(i)).getMem_num() + " where pic_num = (select max(pic_num) from profilepic_" + ((FriendDTO)friendState2.get(i)).getMem_num() + ") union ";
			}
			friendpic_sql += "select * from profilepic_" + ((FriendDTO)friendState2.get(friendState2.size()-1)).getMem_num() + " where pic_num = (select max(pic_num) from profilepic_" + ((FriendDTO)friendState2.get(friendState2.size()-1)).getMem_num() + ")";
			
			System.out.println(friendpic_sql);
			
			Map frisqlMap = new HashMap();
			frisqlMap.put("friendpic_sql", friendpic_sql);
			frisqlMap.put("num", mem_num);	//���� ���̵��� mem_num�ƴ� / ���� �������� mem_num
			System.out.println(frisqlMap);
			
			// ���� �������� ģ�����+�����ʻ���
			List friendpicList = new ArrayList();
			friendpicList = sqlMapClientTemplate.queryForList("friend.friendproPic", frisqlMap);
			
			for(int i = 0 ; i < friendpicList.size() ; i++){
				System.out.println(((FriendDTO)friendpicList.get(i)).getProfile_pic());
			}
			
			request.setAttribute("friendpicList", friendpicList);
		}
		

		request.setAttribute("coverhisList", coverhisList);
		request.setAttribute("prohisList", prohisList);
		request.setAttribute("mem_num", mem_num); // ���Ǿ��̵��� mem_num �ƴ�/ ���� �������� mem_num
		request.setAttribute("proDTO", proDTO);
		request.setAttribute("coverDTO", coverDTO);
		request.setAttribute("sessionCoverDTO", sessionCoverDTO);
		request.setAttribute("sessionproDTO", sessionproDTO);
		request.setAttribute("sessionName", memDTO.getName());
		request.setAttribute("name", frimemDTO.getName());
		request.setAttribute("num", frimemDTO.getNum());
		request.setAttribute("mynum", memDTO.getNum());	// ���Ǿ��̵��� mem_num
		request.setAttribute("friendList", friendList);
		request.setAttribute("friendState0", friendState0);
		request.setAttribute("friendState1", friendState1);
		request.setAttribute("friendState2", friendState2);
		request.setAttribute("friendState_m1", friendState_m1);
	    request.setAttribute("friendCateg", friendCateg);
		

		return "/main/MyUsedFriend.jsp";
	}
	
	
	

}
