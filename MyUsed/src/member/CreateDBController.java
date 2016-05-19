package member;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CreateDBController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private MemberDTO memDTO = new MemberDTO();
	
	@RequestMapping("/createDB.nhn")
	public String create(int num){
		String result = "";
		
		System.out.println(num);
		Map map = new HashMap();
		map.put("num", num);
		
		// �ش� num�� naverȸ���� ��� num_naver�� 0�� �ƴ� ���� ����.
		String num_naver = (String) sqlMapClientTemplate.queryForObject("member.num_NaverId",map);
		if(num_naver.equals("0")){
			result = "/member/MyUsedJoinPro.jsp";
		}else{
			result = "/member/MyUsedNaverFirstLoginPro.jsp";
		}
		
		
		/** ģ�� ����Ʈ ���̺�&������ ���� */
		sqlMapClientTemplate.update("friend.friendlistTable", map);
		System.out.println("friendlist_"+num+" create");
		
		sqlMapClientTemplate.update("friend.friendlistSeq", map);
		System.out.println("sq_friendlist_"+num+" create");

		/***************************************************/
		
		/** ����(board) �۾��� ���̺�&������ ���� */
		sqlMapClientTemplate.update("create.board", map);
		System.out.println("board_"+num+" create");
		
		sqlMapClientTemplate.update("create.board_seq", map);
		System.out.println("board_"+num+"seq create");

		/** ���λ���(pic) �۾��� ���̺� */
		sqlMapClientTemplate.update("create.pic", map);
		System.out.println("pic_"+num+" create");

		/** �Ϲ� ���ƿ�(like) �۾��� ���̺� */
		sqlMapClientTemplate.update("create.likes", map);
		System.out.println("likes_"+num+" create");

		/** �Ϲ� ���(reple) �۾��� ���̺� */
		sqlMapClientTemplate.update("create.reple", map);
		System.out.println("reple_"+num+" create");

		/** �����ʻ��� ���̺�&������ ���� */
		sqlMapClientTemplate.update("create.profilepic", map);
		map.put("mem_num", num);
		sqlMapClientTemplate.insert("profile.insertDefaultPic", map);
		System.out.println("profilepic_"+num+" create");
		
		sqlMapClientTemplate.update("create.profilepic_seq", map);
		System.out.println("profilepic_"+num+"seq create");

		/** Ŀ������ ���̺�&������ ���� */
		sqlMapClientTemplate.update("create.coverpic", map);
		System.out.println("profilepic_"+num+" create");
		
		sqlMapClientTemplate.update("create.coverpic_seq", map);
		System.out.println("coverpic_"+num+"seq create");
		
		/***************************************************/

		/** ��ǰ(board) �۾��� ���̺�&������ ���� */
		sqlMapClientTemplate.update("create.proboard", map);
		System.out.println("proboard_"+num+" create");
		
		sqlMapClientTemplate.update("create.proboard_seq", map);
		System.out.println("proboard_"+num+"seq create");

		/** ��ǰ����(pic) �۾��� ���̺� */
		sqlMapClientTemplate.update("create.propic", map);
		System.out.println("propic_"+num+" create");

		/** ��ǰ ���ƿ�(like) �۾��� ���̺� */
		sqlMapClientTemplate.update("create.prolikes", map);
		System.out.println("prolikes_"+num+" create");

		/** ��ǰ ���(reple) �۾��� ���̺� */
		sqlMapClientTemplate.update("create.proreple", map);
		System.out.println("proreple_"+num+" create");
		
		return result;
	}
	
			
}
