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
import member.ProfilePicDTO;

@Controller
public class TagSearchController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private MemberDTO memDTO = new MemberDTO();
	
	@RequestMapping("/tegSearch.nhn")
	public String tegSearch(HttpServletRequest request, String word){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		/** ���� ���̵��� �����ʻ��� */
		Map picmap = new HashMap();
		picmap.put("mem_num", memDTO.getNum());
		proDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", picmap); // ������
		
		/** ģ�� ��� ����Ʈ(state2) */
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		List friendState2 = new ArrayList();
		friendState2 = sqlMapClientTemplate.queryForList("friend.friendState2", map);

		/** ģ�� ��� ������ �����̱� */
		if (friendState2.size() > 0) {
			List friprofileList = new ArrayList();
			for (int i = 0; i < friendState2.size(); i++) {
				// ����2�� ģ�� ����� ��ȣ�� �̱�
				int frinum = ((FriendDTO) friendState2.get(i)).getMem_num();
				System.out.println(frinum);

				// �ش� ��ȣ�� ���� ������ ���� ���̺��� ã�� �ֱ� ���� ���ڵ带 ����Ʈ�� �ִ´�
				Map frinumMap = new HashMap();
				frinumMap.put("mem_num", frinum);

				ProfilePicDTO friproDTO = new ProfilePicDTO();
				friproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", frinumMap);

				friprofileList.add(i, friproDTO);
			}

			for (int i = 0; i < friprofileList.size(); i++) {
				// System.out.println(knewFriendList_image.get(i));
				System.out.println(((ProfilePicDTO) friprofileList.get(i)).getProfile_pic());
			}
			request.setAttribute("friprofileList", friprofileList);// ģ����� ������
																	// ����
			request.setAttribute("friendState2", friendState2); // ģ����� �ҷ����� ����Ʈ
		}
		
		/** �±� �˻� */
		System.out.println(word);	// �±� �˻��� ����
		word = word.substring(1, word.length());	//�տ� Ư������, ���� ������ String ����
		String content = "#"+word;
		
		List tegList = new ArrayList();
		tegList = sqlMapClientTemplate.queryForList("main.tegSearch", content);
		
		for(int i = 0; i < tegList.size() ; i++){
			System.out.println(((MainboardDTO)tegList.get(i)).getContent());
		}
		
		request.setAttribute("list", tegList);
		request.setAttribute("content", content);	//�˻��� �ܾ�
		request.setAttribute("name", memDTO.getName());
		request.setAttribute("num", memDTO.getNum());
		request.setAttribute("proDTO", proDTO);
		
		return "/main/MyUsedTegSearch.jsp";
	}
	
	@RequestMapping("/protegSearch.nhn")
	public String protegSearch(HttpServletRequest request, String word){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		/** ���� ���̵��� �����ʻ��� */
		Map picmap = new HashMap();
		picmap.put("mem_num", memDTO.getNum());
		proDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", picmap); // ������
		
		/** ģ�� ��� ����Ʈ(state2) */
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		List friendState2 = new ArrayList();
		friendState2 = sqlMapClientTemplate.queryForList("friend.friendState2", map);

		/** ģ�� ��� ������ �����̱� */
		if (friendState2.size() > 0) {
			List friprofileList = new ArrayList();
			for (int i = 0; i < friendState2.size(); i++) {
				// ����2�� ģ�� ����� ��ȣ�� �̱�
				int frinum = ((FriendDTO) friendState2.get(i)).getMem_num();
				System.out.println(frinum);

				// �ش� ��ȣ�� ���� ������ ���� ���̺��� ã�� �ֱ� ���� ���ڵ带 ����Ʈ�� �ִ´�
				Map frinumMap = new HashMap();
				frinumMap.put("mem_num", frinum);

				ProfilePicDTO friproDTO = new ProfilePicDTO();
				friproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", frinumMap);

				friprofileList.add(i, friproDTO);
			}

			for (int i = 0; i < friprofileList.size(); i++) {
				// System.out.println(knewFriendList_image.get(i));
				System.out.println(((ProfilePicDTO) friprofileList.get(i)).getProfile_pic());
			}
			request.setAttribute("friprofileList", friprofileList);// ģ����� ������
																	// ����
			request.setAttribute("friendState2", friendState2); // ģ����� �ҷ����� ����Ʈ
		}
		
		/** �±� �˻� */
		System.out.println(word);	// �±� �˻��� ����
		word = word.substring(1, word.length());	//�տ� Ư������, ���� ������ String ����
		String content = "#"+word;
		
		List protegList = new ArrayList();
		protegList = sqlMapClientTemplate.queryForList("main.protegSearch", content);
		
		for(int i = 0; i < protegList.size() ; i++){
			System.out.println(((MainProboardDTO)protegList.get(i)).getContent());
		}
		
		request.setAttribute("prolist", protegList);
		request.setAttribute("content", content);	//�˻��� �ܾ�
		request.setAttribute("name", memDTO.getName());
		request.setAttribute("num", memDTO.getNum());
		request.setAttribute("proDTO", proDTO);
		
		return "/main/MyUsedProTegSearch.jsp";
	}
}
