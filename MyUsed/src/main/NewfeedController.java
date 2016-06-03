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
public class NewfeedController {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	@RequestMapping("/newsfeed.nhn")
	public String newsfeed(HttpServletRequest request, int mem_num){
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		/** 상태 2인 친구들 */
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		List friend = new ArrayList();
		friend = sqlMapClientTemplate.queryForList("friend.friendState2", map);
		
		
		/*********** 상태 글 뉴스피드 뽑아내기 ***********/
		/** 친구들의 board테이블을 union한다. */
		String sql = "";
		if(friend.size() > 0){
			for(int i = 0 ; i < friend.size() ; i++){
				sql += "select * from board_"+((FriendDTO)friend.get(i)).getMem_num()+" union ";
			}
			sql += "select * from board_"+((FriendDTO)friend.get(friend.size()-1)).getMem_num();
		
		
		/** union한 쿼리를 최신순으로 정렬해 뉴스피드 목록을 뽑아낸다 */
		List newsfeed = new ArrayList();
		newsfeed = sqlMapClientTemplate.queryForList("main.newsfeed", sql);
		
		request.setAttribute("newsfeed", newsfeed);
		
		}
		
		/*********** 상품 글 뉴스피드 뽑아내기 ***********/
		/** 친구들의 proboard테이블을 union한다. */
		String prosql = "";
		// 해당 사용자가 친구(상태2인)가 있을 때
		if(friend.size() > 0){
			for(int i = 0 ; i < friend.size() ; i++){
				prosql += "select * from proboard_"+((FriendDTO)friend.get(i)).getMem_num()+" union ";
			}
			prosql += "select * from proboard_"+((FriendDTO)friend.get(friend.size()-1)).getMem_num();
		
		System.out.println(prosql);
		
		/** union한 쿼리를 최신순으로 정렬해 뉴스피드 목록을 뽑아낸다 */
		List pronewsfeed = new ArrayList();
		pronewsfeed = sqlMapClientTemplate.queryForList("main.pro_newsfeed", prosql);
		
		request.setAttribute("pronewsfeed", pronewsfeed);
		}
		
		request.setAttribute("num", memDTO.getNum());
		
		
		return "/main/MyUsedNewsfeed.jsp";
	}

	
}
