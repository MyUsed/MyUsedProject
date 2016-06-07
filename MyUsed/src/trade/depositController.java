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

import member.ProfilePicDTO;
import product.orderlistDTO;

@Controller
public class depositController {
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private selllistDTO sellDTO = new selllistDTO();
	private List selllist = new ArrayList();
	
	
	@RequestMapping("/depositState.nhn")
	public ModelAndView depositsate(HttpServletRequest request){
		 ModelAndView mv = new  ModelAndView();
		 
		HttpSession session = request.getSession();
		
		String sessionId = (String) session.getAttribute("memId");
		int mem_num = (int)sqlMap.queryForObject("main.num",sessionId); // ȸ����ȣ�� ������
		Map picmap = new HashMap();
		picmap.put("mem_num", mem_num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // �α����� ������ ������
		
		orderlistDTO depositlist = new orderlistDTO();
		depositlist = (orderlistDTO)sqlMap.queryForObject("trade.depositInfo",mem_num); // �ŷ���û�� ����
		
		mv.addObject("depositlist",depositlist);
		mv.addObject("proDTO",proDTO);
		mv.setViewName("/admin_deposit/depositState.jsp");
		return mv;
	}
	
	@RequestMapping("/submitAcount.nhn")
	public ModelAndView sunmitDeposit(selllistDTO sellDTO){
		ModelAndView mv = new ModelAndView();
		
		sqlMap.insert("trade.insertDepositInfo",sellDTO); // �Է¹����� selllist �� ���� ;
		
		mv.setViewName("/MyUsed.nhn");
		return mv;
	}
	
	@RequestMapping("/tradePost.nhn")
	public ModelAndView tradepost(){
		ModelAndView mv = new ModelAndView();
		
		selllist = sqlMap.queryForList("trade.selectSelllist",null);
		
		mv.addObject("selllist",selllist);
		mv.setViewName("/admin_deposit/postState.jsp");
		return mv;
	}
	
	@RequestMapping("/depositCheck.nhn")
	public ModelAndView depositCheck(int seq_num){
		ModelAndView mv = new ModelAndView();
		
		sqlMap.update("trade.updateSelllist",seq_num); // ��ۻ��� ������Ʈ
		
		int pro_num = (int)sqlMap.queryForObject("trade.selectPronum",seq_num); // �Խñ� ��ȣ�� ������
		sqlMap.update("order.updateOrderlist",pro_num);// orderlist ���� 2�� ���� 
		
		mv.setViewName("tradePost.nhn");
		return mv;
	}

	
	
	
	
	
	
	
	
	
	
}

