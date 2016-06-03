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
	
	/** �±׵� ��ũ�� �������� �� ����� �������� ��ũ(��۾����� ģ������߿��� ã�´�.) */
	@RequestMapping("/tegfriend.nhn")
	public String tegfriend(HttpServletRequest request, String name, int writer){
		/** ��۾����� ����*/
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", writer);
		
		System.out.println(name);	//�±��� �̸�
		name = name.substring(1, name.length());	//�տ� Ư������, ���� ������ String ����
		
		/** ��۾����� ģ�� ����ؼ� ��ġ�ϴ� �̸��� ã�� �ش� ������ DTO�� ���� */
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		map.put("name", name);
		
		FriendDTO tegFriDTO = new FriendDTO();
		tegFriDTO = (FriendDTO) sqlMapClientTemplate.queryForObject("friend.searchfriName", map);

		request.setAttribute("mem_num", tegFriDTO.getMem_num());
		
		return "/mypage/tegfriend.jsp";
	}
	
	/** �̸� �±� ģ�� ��Ͽ��� �ǽð����� �˻� */
	@RequestMapping("/findname.nhn")
	public String findname(HttpServletRequest request, String name){
		System.out.println(name);
	//	name = name.substring(1, name.length());	//�տ� Ư������, ���� ������ String ����
		
		return "/main/tegname.jsp";
	}
}
