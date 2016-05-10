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
		
		
		
		request.setAttribute("knewFriendList", knewFriendList);
		
		request.setAttribute("sessionName", memDTO.getName());
		request.setAttribute("name", frimemDTO.getName());
		request.setAttribute("num", frimemDTO.getNum());
		request.setAttribute("mynum", memDTO.getNum());
		request.setAttribute("friendList", friendList);
		request.setAttribute("friendState0", friendState0);
		request.setAttribute("friendState1", friendState1);
		request.setAttribute("friendState2", friendState2);
		request.setAttribute("friendState_m1", friendState_m1);
		
		return "/member/MyUsedMyPage.jsp";
	}

}
