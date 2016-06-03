package main;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import admin.BannerApplyDTO;
import friend.FriendCategDTO;
import friend.FriendDTO;
import member.MemberDTO;
import member.ProfilePicDTO;
import trade.noticeDTO;

@Controller
public class MainController {

	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private List<MainboardDTO> list = new ArrayList<MainboardDTO>();;	
	private ProfilePicDTO sessionproDTO = new ProfilePicDTO();
	private List<MainProboardDTO> prolist = new ArrayList<MainProboardDTO>();; 
	private List<RepleDTO> replelist = new ArrayList<RepleDTO>();;
	private List<noticeDTO> noticelist = new ArrayList<noticeDTO>();;
	
	
	   @RequestMapping("/MyUsed.nhn")
	   public ModelAndView main(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();

		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);

		request.setAttribute("name", memDTO.getName());
		request.setAttribute("num", memDTO.getNum());

		/** 카테고리 보기 */
		List viewCategList = new ArrayList();
		viewCategList = sqlMap.queryForList("procateg.viewCateg", null);
		request.setAttribute("viewCategList", viewCategList);

		/** 카테고리 추가 */
		ProBoardCategDTO categDTO0 = new ProBoardCategDTO();
		List categList = new ArrayList();
		categList = sqlMap.queryForList("procateg.selectCateg", 0);

		request.setAttribute("categList", categList);
		request.setAttribute("checked", "checked");

		// 세션 아이디의 프로필사진
		Map profileMap2 = new HashMap();
		profileMap2.put("mem_num", memDTO.getNum());
		sessionproDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", profileMap2);
		request.setAttribute("sessionproDTO", sessionproDTO);

		/** 친구 목록 리스트(state2) */
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		List friendState2 = new ArrayList();
		friendState2 = sqlMap.queryForList("friend.friendState2", map);

		/** 친구 목록 프로필 사진뽑기 */
		if (friendState2.size() > 0) {
			List friprofileList = new ArrayList();
			for (int i = 0; i < friendState2.size(); i++) {
				// 상태2인 친구 목록의 번호만 뽑기
				int frinum = ((FriendDTO) friendState2.get(i)).getMem_num();
				System.out.println(frinum);

				// 해당 번호를 가진 프로필 사진 테이블을 찾아 최근 사진 레코드를 리스트에 넣는다
				Map frinumMap = new HashMap();
				frinumMap.put("mem_num", frinum);

				ProfilePicDTO friproDTO = new ProfilePicDTO();
				friproDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", frinumMap);

				friprofileList.add(i, friproDTO);
			}

			for (int i = 0; i < friprofileList.size(); i++) {
				// System.out.println(knewFriendList_image.get(i));
				System.out.println(((ProfilePicDTO) friprofileList.get(i)).getProfile_pic());
			}
			request.setAttribute("friprofileList", friprofileList);// 친구목록 프로필
																	// 사진
			request.setAttribute("friendState2", friendState2); // 친구목록 불러오는 리스트
		}

		int renum = (int) sqlMap.queryForObject("main.boardnum", null);

		list = sqlMap.queryForList("main.boardView", null); // state 리스트
		prolist = sqlMap.queryForList("main.proboardView", null); // product 리스트

		Map picmap = new HashMap();
		picmap.put("mem_num", memDTO.getNum());
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // 프로필
																					// 사진을
																					// 가져옴
		
		// 광고 가져옴 
		BannerApplyDTO banner = new BannerApplyDTO();
		banner = (BannerApplyDTO)sqlMap.queryForObject("main.bannerSelect",null);
		
		
		
		noticelist = sqlMap.queryForList("main.AllNoticeSelect",picmap);
		
		
		
		mv.addObject("noticelist",noticelist);
		mv.addObject("banner",banner);
		mv.addObject("proDTO", proDTO);
		mv.addObject("list", list);
		mv.addObject("prolist", prolist);
		mv.addObject("replelist", replelist);

		mv.addObject("memDTO", memDTO);
		mv.setViewName("/main/MyUsed.jsp");
		return mv;
	   }   
	   

	
	@RequestMapping("/MyUsedLogin.nhn")
	public ModelAndView login(){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/member/MyUsedLogin.jsp");
		return mv;
	}
	
	
	

}
