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

@Controller
public class FriendModifyController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;


	@RequestMapping("/ModifyFriendCateg.nhn")
	public String modifyFriendCateg(HttpServletRequest request, int mem_num){
		System.out.println(mem_num);
		
		/** �����Ϸ��� ģ���� ���� */
		MemberDTO frimemDTO = new MemberDTO();
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);

		FriendCategDTO fricagDTO = new FriendCategDTO();
		List friendCateg = new ArrayList();
		friendCateg = sqlMapClientTemplate.queryForList("friend.friendCateg", null);

		request.setAttribute("frimemDTO", frimemDTO);
		request.setAttribute("friendCateg", friendCateg);
		request.setAttribute("mem_num", mem_num);
		
		return "/friend/modifyFriendCateg.jsp";
	}

	@RequestMapping("/ModifyFriendCategPro.nhn")
	public String modifyFriendCategPro(HttpServletRequest request, int mem_num, String fri_categ){
		/** �α����� ������� ���� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		/** �����Ϸ��� ģ���� ���� */
		MemberDTO frimemDTO = new MemberDTO();
		frimemDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);

		/** �� ģ������Ʈ������ �����ϰ� �����Ϸ��� ģ���� ����Ʈ������ ���� ����*/
		Map map = new HashMap();
		map.put("num", memDTO.getNum());	// �� ��ȣ
		map.put("mem_num", mem_num);		// �����Ϸ��� ģ�� ��ȣ
		map.put("categ", fri_categ);
		sqlMapClientTemplate.update("friend.ModifyFriend",map);

		Map map2 = new HashMap();
		map2.put("mem_num", mem_num);		// �� ��ȣ
		map2.put("num", memDTO.getNum());	// �����Ϸ��� ģ�� ��ȣ
		map2.put("categ", fri_categ);
		sqlMapClientTemplate.update("friend.ModifyFriend",map2);
		
		

		request.setAttribute("frimemDTO", frimemDTO);

		return "/friend/modifyFriendCategPro.jsp";
	}


}
