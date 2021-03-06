package trade;

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
import org.springframework.web.servlet.ModelAndView;

import admin.BannerApplyDTO;
import member.MemberDTO;
import member.ProfilePicDTO;
import product.orderlistDTO;

@Controller
public class tradeController {
	

	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	private orderlistDTO orderlist = new orderlistDTO();
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private ProfilePicDTO sellDTO = new ProfilePicDTO();
	private List <orderlistDTO> orderAll = new ArrayList<orderlistDTO>();;
	
	@RequestMapping("/tradeState.nhn")
	public ModelAndView tradeView(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		int mem_num = (int)sqlMap.queryForObject("main.num",sessionId); // 회원번호를 꺼내옴
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);


		request.setAttribute("name", memDTO.getName());
		request.setAttribute("num", memDTO.getNum());

		 // 프로필 사진을 띄우기 위한 처리 
	    Map picmap = new HashMap();
		picmap.put("mem_num", mem_num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // 로그인한 프로필 가져옴
		
		orderlist = (orderlistDTO)sqlMap.queryForObject("order.buyOrderlist",mem_num); // orderlist에서 회원번호를 이용해 구매 정보를 가져옴 
		if(orderlist != null){
		orderlistDTO sellnum = new orderlistDTO();
		sellnum = (orderlistDTO)sqlMap.queryForObject("order.buyOrderlist",mem_num); // 판매자 회원번호 가져오기
		
		
		picmap.put("mem_num",sellnum.getSell_memnum());
		sellDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // 판매자 프로필 가져옴
		
		// 광고 가져옴 
		BannerApplyDTO banner = new BannerApplyDTO();
		banner = (BannerApplyDTO)sqlMap.queryForObject("main.bannerSelect",null);
		
		mv.addObject("sellDTO",sellDTO);
		mv.addObject("proDTO",proDTO);
		mv.addObject("orderlist",orderlist);		
		mv.addObject("banner",banner);
		mv.setViewName("/admin_trade/tradeView.jsp");
		
		}else if(orderlist == null){
		mv.addObject("proDTO",proDTO);
		// 광고 가져옴 
		BannerApplyDTO banner = new BannerApplyDTO();
		banner = (BannerApplyDTO)sqlMap.queryForObject("main.bannerSelect",null);
		
		mv.addObject("banner",banner);
		mv.setViewName("/admin_trade/tradeNotView.jsp");
		}
		return mv;
	}
	
	@RequestMapping("/tradeAllView.nhn")
	public ModelAndView tradeAll(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		int mem_num = (int)sqlMap.queryForObject("main.num",sessionId); // 회원번호를 꺼내옴
		
		 // 프로필 사진을 띄우기 위한 처리 
	    Map picmap = new HashMap();
		picmap.put("mem_num", mem_num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // 로그인한 프로필 가져옴
		
		orderAll = sqlMap.queryForList("order.butOrderAll",mem_num); // orderlist에서 회원번호를 이용해 구매 정보를 가져옴 
		
		mv.addObject("orderAll",orderAll);
		mv.addObject("proDTO",proDTO);
		mv.setViewName("/admin_trade/tradeAllView.jsp");
		
		return mv;
	}
	
	@RequestMapping("/tradeCall.nhn")
	public ModelAndView tradecall(HttpServletRequest request, int mem_num,int pro_num){
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		int num = (int)sqlMap.queryForObject("main.num",sessionId); // 회원번호를 꺼내옴
		
		Map map = new HashMap();
		map.put("num", num);
		map.put("mem_num", mem_num);
		map.put("pro_num", pro_num);
		System.out.println(mem_num+"============================");
		orderlistDTO orderInfo = new orderlistDTO();
		orderInfo = (orderlistDTO)sqlMap.queryForObject("trade.orderInfo",map);
		
		sqlMap.update("order.updateNotice",map); // 읽은 창은 알림에서 안띄우게
		
		mv.addObject("orderInfo",orderInfo);
		mv.setViewName("/admin_trade/tradeInfo.jsp");
		return mv;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
