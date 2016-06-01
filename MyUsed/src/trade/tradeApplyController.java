package trade;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import product.orderlistDTO;

@Controller
public class tradeApplyController {


	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
		
	private List<orderlistDTO> orderlist = new ArrayList<orderlistDTO>();;
	
	@RequestMapping("/tradeApply.nhn")
	public ModelAndView tradeApply(){
		ModelAndView mv = new ModelAndView();
		
		orderlist = sqlMap.queryForList("order.selectOrderlist",null);
		
		mv.addObject("orderlist",orderlist);
		mv.setViewName("/admin_trade/tradeApply.jsp");
		return mv;
	}
	
	@RequestMapping("/tradeDeposit.nhn")
	public ModelAndView tradeDeposit(){
		ModelAndView mv = new ModelAndView();
		
		orderlist = sqlMap.queryForList("order.selectOrderlist",null);
		
		mv.addObject("orderlist",orderlist);
		mv.setViewName("/admin_trade/tradeDeposit.jsp");
		return mv;
	}
	
}
