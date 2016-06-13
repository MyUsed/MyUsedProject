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
	

	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	private orderlistDTO orderlist = new orderlistDTO();
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private ProfilePicDTO sellDTO = new ProfilePicDTO();
	private List <orderlistDTO> orderAll = new ArrayList<orderlistDTO>();;
	
	@RequestMapping("/tradeState.nhn")
	public ModelAndView tradeView(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		int mem_num = (int)sqlMap.queryForObject("main.num",sessionId); // ȸ����ȣ�� ������
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);


		request.setAttribute("name", memDTO.getName());
		request.setAttribute("num", memDTO.getNum());

		 // ������ ������ ���� ���� ó�� 
	    Map picmap = new HashMap();
		picmap.put("mem_num", mem_num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // �α����� ������ ������
		
		orderlist = (orderlistDTO)sqlMap.queryForObject("order.buyOrderlist",mem_num); // orderlist���� ȸ����ȣ�� �̿��� ���� ������ ������ 
		if(orderlist != null){
		orderlistDTO sellnum = new orderlistDTO();
		sellnum = (orderlistDTO)sqlMap.queryForObject("order.buyOrderlist",mem_num); // �Ǹ��� ȸ����ȣ ��������
		
		
		picmap.put("mem_num",sellnum.getSell_memnum());
		sellDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // �Ǹ��� ������ ������
		
		// ���� ������ 
		BannerApplyDTO banner = new BannerApplyDTO();
		banner = (BannerApplyDTO)sqlMap.queryForObject("main.bannerSelect",null);
		
		mv.addObject("sellDTO",sellDTO);
		mv.addObject("proDTO",proDTO);
		mv.addObject("orderlist",orderlist);		
		mv.addObject("banner",banner);
		mv.setViewName("/admin_trade/tradeView.jsp");
		
		}else if(orderlist == null){
		mv.addObject("proDTO",proDTO);
		// ���� ������ 
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
		int mem_num = (int)sqlMap.queryForObject("main.num",sessionId); // ȸ����ȣ�� ������
		
		 // ������ ������ ���� ���� ó�� 
	    Map picmap = new HashMap();
		picmap.put("mem_num", mem_num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // �α����� ������ ������
		
		orderAll = sqlMap.queryForList("order.butOrderAll",mem_num); // orderlist���� ȸ����ȣ�� �̿��� ���� ������ ������ 
		
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
		int num = (int)sqlMap.queryForObject("main.num",sessionId); // ȸ����ȣ�� ������
		
		Map map = new HashMap();
		map.put("num", num);
		map.put("mem_num", mem_num);
		map.put("pro_num", pro_num);
		System.out.println(mem_num+"============================");
		orderlistDTO orderInfo = new orderlistDTO();
		orderInfo = (orderlistDTO)sqlMap.queryForObject("trade.orderInfo",map);
		
		sqlMap.update("order.updateNotice",map); // ���� â�� �˸����� �ȶ���
		
		mv.addObject("orderInfo",orderInfo);
		mv.setViewName("/admin_trade/tradeInfo.jsp");
		return mv;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
