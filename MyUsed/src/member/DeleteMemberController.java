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
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		int num = memDTO.getNum();
		
		/** 친구 리스트에서 나를 삭제 */
		List friendList = new ArrayList();
		friendList = sqlMapClientTemplate.queryForList("memDelete.friendlist", num);
		
		Map map = new HashMap();
		map.put("mem_num", num);
		for(int i = 0 ; i < friendList.size() ; i++){
			map.put("fri_num", ((FriendDTO)friendList.get(i)).getMem_num());
			sqlMapClientTemplate.delete("memDelete.delFriend", map);
		}
		
		
		/** 개인 테이블 삭제 */
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

		/** 테이블 시퀀스 삭제 */
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
		
		/** 맴버 리스트에서 삭제 */
		sqlMapClientTemplate.delete("memDelete.delmemlist",num);
		

		System.out.println("테이블 지워짐");
		
		return "/main/MemDelete.jsp";
	}
}
