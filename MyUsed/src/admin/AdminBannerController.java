package admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import member.ProfilePicDTO;

@Controller
public class AdminBannerController {
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private ProfilePicDTO boardproDTO = new ProfilePicDTO();
	
	
	@RequestMapping("/adver.nhn")
	public ModelAndView adver(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		 HttpSession session = request.getSession();
		    String sessionId = (String) session.getAttribute("memId");
		    int session_num = (int)sqlMap.queryForObject("main.num",sessionId); // 회원번호 가져오기

		    Map picmap = new HashMap();
			picmap.put("mem_num", session_num);   
			proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // 프로필 사진을 가져옴
		mv.addObject("proDTO",proDTO);
		mv.setViewName("/main/applyAdvertise.jsp");
		return mv;
	}
	
	@RequestMapping("/applyBanner.nhn")
	public ModelAndView applybanner(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin_banner/applyBanner.jsp");
		return mv;
	}
	@RequestMapping("/insertBanner.nhn")
	public ModelAndView insertbanner(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin_banner/insertBanner.jsp");
		return mv;
	}
	
	@RequestMapping("/applyBannerSubmit.nhn")
	public ModelAndView applyBannersubmit(BannerApplyDTO bannerDTO){
		ModelAndView mv = new ModelAndView();
		
		System.out.println(bannerDTO.getHostname());
		
		mv.setViewName("/admin_banner/applyalert.jsp");
		return mv;
		
	}


}
