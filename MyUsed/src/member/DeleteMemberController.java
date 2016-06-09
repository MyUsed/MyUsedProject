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

import friend.FriendDTO;

@Controller
public class DeleteMemberController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private MemberDTO memDTO = new MemberDTO();
	
	/******************************************
	 * << ȸ��Ż�� �� ������ �� ��� >>
	 * 01. ģ������ ����Ʈ���� �����
	 * 02. �Խñ۸��� ������ ��� ���̺�
	 * 03. �Խñ�(�ٸ� �ۿ� �� ����� ���� ��ǻ� ã�� ����) 
	 * 04. ȸ������ �� ������ ���̺��
	 * 05. ȸ������ �� ������ ���̺� ��������
	 * 06. memberlist���� ����
	 ******************************************/

	@RequestMapping("/DeleteDB.nhn")
	public String delete(HttpServletRequest request){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		int num = memDTO.getNum();
		
		/** ģ�� ����Ʈ���� ���� ���� */
		List friendList = new ArrayList();
		friendList = sqlMapClientTemplate.queryForList("memDelete.friendlist", num);
		
		Map map = new HashMap();
		map.put("mem_num", num);
		for(int i = 0 ; i < friendList.size() ; i++){
			map.put("fri_num", ((FriendDTO)friendList.get(i)).getMem_num());
			sqlMapClientTemplate.delete("memDelete.delFriend", map);
		}
		
		
		/** ���� ���̺� ���� */
		List tablelist = new ArrayList();
		tablelist.add("friendlist_"+num);	// 01. ģ�����
		tablelist.add("board_"+num);		// 02. ���±�
		tablelist.add("pic_"+num);			// 03. ���±��� ����
		tablelist.add("likes_"+num);		// 04. ���±� ���ƿ�
		tablelist.add("boardreple_"+num);	// 05. ���±� ���(����! ����num�� �ƴ϶� ������ �� �۸��� �����ȴ�)
		tablelist.add("profilepic_"+num);	// 06. ������ ����
		tablelist.add("coverpic_"+num);		// 07. Ŀ�� ����
		tablelist.add("proboard_"+num);		// 08. ��ǰ��
		tablelist.add("propic_"+num);		// 09. ��ǰ���� ����
		tablelist.add("prolikes_"+num);		// 10. ��ǰ�� ���ƿ�
		tablelist.add("proboardreple_"+num);// 11. ��ǰ�� ���(����! ����num�� �ƴ϶� ������ �� �۸��� �����ȴ�)
		tablelist.add("address_"+num);		// 12. �ּ� ���
		tablelist.add("message_r_"+num);	// 13. ����
		
		for(int i = 0 ; i < tablelist.size() ; i++){
			String tablename = (String) tablelist.get(i);
			sqlMapClientTemplate.update("memDelete.delPersonalTable",tablename);
		}

		/** ���̺� ������ ���� */
		List seqlist = new ArrayList();
		seqlist.add("sq_friendlist_"+num);		// 01. ģ�����
		seqlist.add("board_"+num+"seq");		// 02. ���±�
		seqlist.add("profilepic_"+num+"seq");	// 03. ������ ����
		seqlist.add("coverpic_"+num+"seq");		// 04. Ŀ�� ����
		seqlist.add("proboard_"+num+"seq");		// 05. ��ǰ��
		seqlist.add("address_"+num+"seq");		// 06. �ּ� ���
		seqlist.add("boardreple_"+num+"seq");	// 07. ���±� ���
		seqlist.add("proboardreple_"+num+"seq");// 08. ��ǰ�� ���
		seqlist.add("message_r_"+num+"_seq");	// 09. ����
		
		for(int i = 0 ; i < seqlist.size() ; i++){
			String sqname = (String) seqlist.get(i);
			sqlMapClientTemplate.update("memDelete.delPersonalSq",sqname);
		}
		
		/** �ɹ� ����Ʈ���� ���� */
		sqlMapClientTemplate.delete("memDelete.delmemlist",num);
		


		System.out.println("���̺� ������");
		
		return "/main/MemDelete.jsp";
	}
}
