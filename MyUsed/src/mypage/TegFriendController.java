package mypage;

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
public class TegFriendController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private MemberDTO memDTO = new MemberDTO();
	
	/** 태그된 링크를 눌렀을때 그 사람의 페이지로 링크(댓글쓴이의 친구목록중에서 찾는다.) */
	@RequestMapping("/tegfriend.nhn")
	public String tegfriend(HttpServletRequest request, String name, int writer){
		/** 댓글쓴이의 정보*/
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", writer);
		
		System.out.println(name);	//태그한 이름
		name = name.substring(1, name.length());	//앞에 특수문자, 빼고 나머지 String 추출
		
		/** 댓글쓴이의 친구 목록해서 일치하는 이름을 찾아 해당 정보를 DTO에 넣음 */
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		map.put("name", name);
		
		FriendDTO tegFriDTO = new FriendDTO();
		tegFriDTO = (FriendDTO) sqlMapClientTemplate.queryForObject("friend.searchfriName", map);

		request.setAttribute("mem_num", tegFriDTO.getMem_num());
		
		return "/mypage/tegfriend.jsp";
	}
	
	/** 이름 태그 친구 목록에서 실시간으로 검색 */
	@RequestMapping("/findname.nhn")
	public String findname(HttpServletRequest request, String name){
		System.out.println(name);
	//	name = name.substring(1, name.length());	//앞에 특수문자, 빼고 나머지 String 추출
		
		return "/main/tegname.jsp";
	}
}
