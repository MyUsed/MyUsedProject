package friend;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import member.MemberDTO;

@Controller
public class FriendDeleteController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;


	@RequestMapping("/DeleteFriend.nhn")
	public String deleteFriend(HttpServletRequest request, int mem_num){
		/** �����Ϸ��� ģ���� ���� */
		MemberDTO frimemDTO = new MemberDTO();
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);
	
		request.setAttribute("mem_num", mem_num);
		request.setAttribute("frimemDTO", frimemDTO);
		return "/friend/deleteFriend.jsp";
	}
	
	@RequestMapping("/DeleteFriendPro.nhn")
	public String deleteFriendPro(HttpServletRequest request, int mem_num){
		/** �α����� ������� ���� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		System.out.println(mem_num);
		
		/** �� ģ������Ʈ������ �����ϰ� �����Ϸ��� ģ���� ����Ʈ������ ���� ����*/
		Map map = new HashMap();
		map.put("num", memDTO.getNum());	// �� ��ȣ
		map.put("mem_num", mem_num);		// �����Ϸ��� ģ�� ��ȣ
		sqlMapClientTemplate.delete("friend.deleteMyFriend",map);
		
		Map map2 = new HashMap();
		map2.put("num", mem_num);				// �����Ϸ��� ģ�� ��ȣ
		map2.put("mem_num", memDTO.getNum());	// �� ��ȣ	
		sqlMapClientTemplate.delete("friend.deleteMyFriend",map2);
		
	
		request.setAttribute("mem_num",  memDTO.getNum());	// ���� �������� �̵��ϱ���� mem_num�� �� ��ȣ ����
		return "/friend/deleteFriendPro.jsp";
	}

}
