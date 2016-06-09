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
	 * << 회원탈퇴 시 지워야 할 목록 >>
	 * 01. 친구들의 리스트에서 지우기
	 * 02. 게시글마다 생성된 댓글 테이블
	 * 03. 게시글(다른 글에 단 댓글의 경우는 사실상 찾기 힘듦) 
	 * 04. 회원가입 시 생성된 테이블들
	 * 05. 회원가입 시 생성된 테이블 시퀀스들
	 * 06. memberlist에서 삭제
	 ******************************************/

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
		tablelist.add("friendlist_"+num);	// 01. 친구목록
		tablelist.add("board_"+num);		// 02. 상태글
		tablelist.add("pic_"+num);			// 03. 상태글의 사진
		tablelist.add("likes_"+num);		// 04. 상태글 좋아요
		tablelist.add("boardreple_"+num);	// 05. 상태글 댓글(수정! 개인num이 아니라 개인의 쓴 글마다 생성된다)
		tablelist.add("profilepic_"+num);	// 06. 프로필 사진
		tablelist.add("coverpic_"+num);		// 07. 커버 사진
		tablelist.add("proboard_"+num);		// 08. 상품글
		tablelist.add("propic_"+num);		// 09. 상품글의 사진
		tablelist.add("prolikes_"+num);		// 10. 상품글 좋아요
		tablelist.add("proboardreple_"+num);// 11. 상품글 댓글(수정! 개인num이 아니라 개인의 쓴 글마다 생성된다)
		tablelist.add("address_"+num);		// 12. 주소 목록
		tablelist.add("message_r_"+num);	// 13. 쪽지
		
		for(int i = 0 ; i < tablelist.size() ; i++){
			String tablename = (String) tablelist.get(i);
			sqlMapClientTemplate.update("memDelete.delPersonalTable",tablename);
		}

		/** 테이블 시퀀스 삭제 */
		List seqlist = new ArrayList();
		seqlist.add("sq_friendlist_"+num);		// 01. 친구목록
		seqlist.add("board_"+num+"seq");		// 02. 상태글
		seqlist.add("profilepic_"+num+"seq");	// 03. 프로필 사진
		seqlist.add("coverpic_"+num+"seq");		// 04. 커버 사진
		seqlist.add("proboard_"+num+"seq");		// 05. 상품글
		seqlist.add("address_"+num+"seq");		// 06. 주소 목록
		seqlist.add("boardreple_"+num+"seq");	// 07. 상태글 댓글
		seqlist.add("proboardreple_"+num+"seq");// 08. 상품글 댓글
		seqlist.add("message_r_"+num+"_seq");	// 09. 쪽지
		
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
