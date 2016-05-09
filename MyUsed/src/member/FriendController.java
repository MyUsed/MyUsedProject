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

	Calendar today = Calendar.getInstance(); //���� ��¥ ���ϱ�.
	
	private MemberDTO memDTO = new MemberDTO();
	private FriendDTO friDTO = new FriendDTO();
			
	@RequestMapping("/MyUsedAddFriend.nhn")
	public String addFriend(HttpServletRequest request, int num, int mem_num, String id, String fri_categ){
		String result = "";
		
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		MemberDTO mem_friDTO = new MemberDTO();
		// ���� ����
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		// ������ ����
		mem_friDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", id);
		
		/** ģ������Ʈ�� ���ԵǾ� �ִ� �ѹ����� �˻� */
		Map frimap = new HashMap();
		frimap.put("num", num);	// ���� num
		frimap.put("mem_num", mem_num);	// ģ����û �޴� ����� num
		
		// 1 ģ�� ���� / 0 �̸� ģ�����̾ƴ� -> ������־�� 
		int amongFriend = (Integer)sqlMapClientTemplate.queryForObject("friend.amongFriend", frimap);
		if(amongFriend == 1){
			
			result = "/member/MyUsedAlreadyFriend.jsp";
			
		}else{

			/** ���� ģ������Ʈ�� �߰� */
			Map map1 = new HashMap();
			map1.put("num", num);	// ���� num
			map1.put("mem_num", mem_num);	// ģ����û �޴� ����� num
			map1.put("id", id);
			map1.put("name", mem_friDTO.getName());
			map1.put("state", "0");
			map1.put("categ", fri_categ);
			
			System.out.println(map1);
			
			sqlMapClientTemplate.insert("friend.addFriend", map1);
			

			/** ģ����û �޴� ����� ģ������Ʈ�� ���� �߰� */
			Map map2 = new HashMap();
			map2.put("num", mem_num);	// ���� num
			map2.put("mem_num", num);	// ģ����û �޴� ����� num
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
		// mem_num�� ģ�� ��û�� ������ ��ȣ, num�� ���� ��ȣ

		System.out.println("num : "+num);
		System.out.println("mem_num : "+mem_num);
		System.out.println("agree : "+agree);	//0 : ���� /1 : ����
		
		
		if(agree == 0){	// ������ ģ���� �������� ���

			// ���� ����Ʈ���� ������ ���¸� �ٲ�
			Map map = new HashMap();
			map.put("num", num);	// ���� num
			map.put("mem_num", mem_num);	// ģ����û �޴� ����� num
			map.put("state", "2");
		
			// ������ ����Ʈ���� ���� ���¸� �ٲ�
			Map map1 = new HashMap();
			map1.put("num", mem_num);	// ���� num
			map1.put("mem_num", num);	// ģ����û �޴� ����� num
			map1.put("state", "2");
			
			sqlMapClientTemplate.update("friend.friendAgree", map);
			sqlMapClientTemplate.update("friend.friendAgree", map1);
			
		}else{ // ģ�� ��û�� �������� ��� ���� ����Ʈ������ ���� ����� ���� ����Ʈ������ ���¸� -1�� �ٲ��ش�
			Map map = new HashMap();
			map.put("num", num);	// ���� num
			map.put("mem_num", mem_num);	// ģ����û �޴� ����� num
			map.put("state", "-1");

			sqlMapClientTemplate.update("friend.friendAgree", map);
			sqlMapClientTemplate.delete("friend.deleteFriend", map);
			
		}
		request.setAttribute("num", num);
		return "/member/MyUsedAgreeFriend.jsp";
	}
	
	/** ������ ���� ������ ��� ���� ���̺��� ���� */
	@RequestMapping("/MyUsedRejectionFriend.nhn")
    
	public String MyUsedRejectionFriend(int agree, int mem_num, int num){
		// mem_num�� ģ�� ��û�� ������ ��ȣ, num�� ���� ��ȣ
		
		Map map = new HashMap();
		map.put("num", num);	// ���� num
		map.put("mem_num", mem_num);	// ģ����û �޴� ����� num

		sqlMapClientTemplate.delete("friend.deleteFriend", map);

		
		return "/member/MyUsedAgreeFriend.jsp";
	}

}
