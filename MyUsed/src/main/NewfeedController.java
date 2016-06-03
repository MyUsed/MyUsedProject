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
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);

		/** ���� 2�� ģ���� */
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		List friend = new ArrayList();
		friend = sqlMapClientTemplate.queryForList("friend.friendState2", map);
		
		
		/*********** ���� �� �����ǵ� �̾Ƴ��� ***********/
		/** ģ������ board���̺��� union�Ѵ�. */
		String sql = "";
		if(friend.size() > 0){
			for(int i = 0 ; i < friend.size() ; i++){
				sql += "select * from board_"+((FriendDTO)friend.get(i)).getMem_num()+" union ";
			}
			sql += "select * from board_"+((FriendDTO)friend.get(friend.size()-1)).getMem_num();
		
		
		/** union�� ������ �ֽż����� ������ �����ǵ� ����� �̾Ƴ��� */
		List newsfeed = new ArrayList();
		newsfeed = sqlMapClientTemplate.queryForList("main.newsfeed", sql);
		
		request.setAttribute("newsfeed", newsfeed);
		
		}
		
		/*********** ��ǰ �� �����ǵ� �̾Ƴ��� ***********/
		/** ģ������ proboard���̺��� union�Ѵ�. */
		String prosql = "";
		// �ش� ����ڰ� ģ��(����2��)�� ���� ��
		if(friend.size() > 0){
			for(int i = 0 ; i < friend.size() ; i++){
				prosql += "select * from proboard_"+((FriendDTO)friend.get(i)).getMem_num()+" union ";
			}
			prosql += "select * from proboard_"+((FriendDTO)friend.get(friend.size()-1)).getMem_num();
		
		System.out.println(prosql);
		
		/** union�� ������ �ֽż����� ������ �����ǵ� ����� �̾Ƴ��� */
		List pronewsfeed = new ArrayList();
		pronewsfeed = sqlMapClientTemplate.queryForList("main.pro_newsfeed", prosql);
		
		request.setAttribute("pronewsfeed", pronewsfeed);
		}
		
		request.setAttribute("num", memDTO.getNum());
		
		
		return "/main/MyUsedNewsfeed.jsp";
	}

	
}
