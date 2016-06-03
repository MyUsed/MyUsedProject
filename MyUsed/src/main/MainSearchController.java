package main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import friend.FriendCategDTO;
import member.MemberDTO;

@Controller
public class MainSearchController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private	MemberDTO memDTO = new MemberDTO();
	
	 
	@RequestMapping("/MyUsedSearchMember.nhn")
	public String MyUsedSearchMember(HttpServletRequest request, String sword) {
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		/** 검색어의 첫글자가 #이면 태그 검색으로 */
		/*String firstword = word.substring(0,1);
		if(firstword.equals("#")){
			
		}*/
		

		/** 회원검색 -> 동명이인이 많아질 경우 검색 우선순위 정하는것 생각해보기 */
		System.out.println(sword); // 검색한 이름
		List searchList = new ArrayList();
		searchList = sqlMapClientTemplate.queryForList("member.searchMember", sword);
		String sql = "";
		if(searchList.size() > 0){
			for(int i = 0 ; i < searchList.size() ; i++){
				sql += "select * from profilepic_"+((MemberDTO)searchList.get(i)).getNum()+
						" where pic_num = (select max(pic_num) from profilepic_"+((MemberDTO)searchList.get(i)).getNum()+") union ";
			}
			sql += "select * from profilepic_"+((MemberDTO)searchList.get(searchList.size()-1)).getNum()+
					" where pic_num = (select max(pic_num) from profilepic_"+((MemberDTO)searchList.get(searchList.size()-1)).getNum()+")";
		}		
		List searchMemList = new ArrayList();
		searchMemList = sqlMapClientTemplate.queryForList("member.searchMemNpic", sql);
		
		
		FriendCategDTO fricagDTO = new FriendCategDTO();
		List friendCateg = new ArrayList();
		friendCateg = sqlMapClientTemplate.queryForList("friend.friendCateg", null);

		request.setAttribute("name", memDTO.getName());
		request.setAttribute("num", memDTO.getNum());
		request.setAttribute("member", sword);
		request.setAttribute("searchMemList", searchMemList);
		request.setAttribute("friendCateg", friendCateg);

		return "/main/MyUsedSearchMember.jsp";

	}
	
}
