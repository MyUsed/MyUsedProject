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

import friend.FriendCategDTO;
import friend.FriendDTO;
import member.CoverPicDTO;
import member.MemberDTO;
import member.ProfilePicDTO;

@Controller
public class MyPictureController {
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	
	@RequestMapping("/MyPageBottom_picture.nhn")
	public String MyPicture(HttpServletRequest request, int mem_num){
		/** 해당 페이지 주인의 정보 */
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTOforNum", mem_num);

		/** 해당 페이지 주인이 올린 모든 사진 */
		List picList = new ArrayList();
		picList = sqlMapClientTemplate.queryForList("member.All_image", mem_num);
		
		
	    request.setAttribute("memDTO", memDTO);
		request.setAttribute("picList", picList);
		
		return "/mypage/MyPageBottom_picture.jsp";
	}
	

}
