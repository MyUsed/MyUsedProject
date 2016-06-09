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

		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		/** ģ������2�� ģ���� �̱�*/
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		System.out.println(map);
		
		List friendState2 = new ArrayList();
		friendState2 = sqlMapClientTemplate.queryForList("friend.friendState2", map);
		
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
			frisqlMap.put("num", memDTO.getNum());	//���� ���̵��� mem_num�ƴ� / ���� �������� mem_num
			System.out.println(frisqlMap);
			
			// ���� �������� ģ�����+�����ʻ���
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
