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

	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
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

		/** ī�װ� ���� */
		List viewCategList = new ArrayList();
		viewCategList = sqlMap.queryForList("procateg.viewCateg", null);
		request.setAttribute("viewCategList", viewCategList);

		/** ī�װ� �߰� */
		ProBoardCategDTO categDTO0 = new ProBoardCategDTO();
		List categList = new ArrayList();
		categList = sqlMap.queryForList("procateg.selectCateg", 0);

		request.setAttribute("categList", categList);
		request.setAttribute("checked", "checked");

		// ���� ���̵��� �����ʻ���
		Map profileMap2 = new HashMap();
		profileMap2.put("mem_num", memDTO.getNum());
		sessionproDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", profileMap2);
		request.setAttribute("sessionproDTO", sessionproDTO);

		/** ģ�� ��� ����Ʈ(state2) */
		Map map = new HashMap();
		map.put("num", memDTO.getNum());
		List friendState2 = new ArrayList();
		friendState2 = sqlMap.queryForList("friend.friendState2", map);

		/** ģ�� ��� ������ �����̱� */
		if (friendState2.size() > 0) {
			List friprofileList = new ArrayList();
			for (int i = 0; i < friendState2.size(); i++) {
				// ����2�� ģ�� ����� ��ȣ�� �̱�
				int frinum = ((FriendDTO) friendState2.get(i)).getMem_num();
				System.out.println(frinum);

				// �ش� ��ȣ�� ���� ������ ���� ���̺��� ã�� �ֱ� ���� ���ڵ带 ����Ʈ�� �ִ´�
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
			request.setAttribute("friprofileList", friprofileList);// ģ����� ������
																	// ����
			request.setAttribute("friendState2", friendState2); // ģ����� �ҷ����� ����Ʈ
		}

		int renum = (int) sqlMap.queryForObject("main.boardnum", null);

		list = sqlMap.queryForList("main.boardView", null); // state ����Ʈ
		prolist = sqlMap.queryForList("main.proboardView", null); // product ����Ʈ

		Map picmap = new HashMap();
		picmap.put("mem_num", memDTO.getNum());
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // ������
																					// ������
																					// ������
		
		// ���� ������ 
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
