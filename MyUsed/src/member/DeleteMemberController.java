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
		tablelist.add("friendlist_"+num);
		tablelist.add("board_"+num);
		tablelist.add("pic_"+num);
		tablelist.add("likes_"+num);
		tablelist.add("profilepic_"+num);
		tablelist.add("coverpic_"+num);
		tablelist.add("proboard_"+num);
		tablelist.add("propic_"+num);
		tablelist.add("prolikes_"+num);
		tablelist.add("proreple_"+num);
		//tablelist.add("address_"+num);
		tablelist.add("proreple_"+num);
		
		for(int i = 0 ; i < tablelist.size() ; i++){
			String tablename = (String) tablelist.get(i);
			sqlMapClientTemplate.update("memDelete.delPersonalTable",tablename);
		}

		/** ���̺� ������ ���� */
		List seqlist = new ArrayList();
		seqlist.add("sq_friendlist_"+num);
		seqlist.add("board_"+num+"seq");
		seqlist.add("profilepic_"+num+"seq");
		seqlist.add("coverpic_"+num+"seq");
		seqlist.add("proboard_"+num+"seq");
		//seqlist.add("address_"+num+"seq");
		//seqlist.add("proreple_"+num+"seq");
		
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
