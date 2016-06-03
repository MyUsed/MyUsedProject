package trade;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import product.orderlistDTO;

@Controller
public class tradeApplyController {


	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
		
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
	
	@RequestMapping("insertNotice.nhn")
	public ModelAndView inserDeposit(int seq_num){
		ModelAndView mv = new ModelAndView();
		System.out.println("���޹��� seq_num = "+seq_num);
		
		sqlMap.update("order.updateState",seq_num); // seq_num ��ȣ�� orderlist �ԱݿϷ� ó�� 
		int pro_num = (int)sqlMap.queryForObject("order.selectProNum",seq_num); // orderlist ���� �Խñ� ��ȣ�� ������
		sqlMap.update("order.updateProboardlist",pro_num); // proboardlist�� sendpay���¸� 0���� ���� �ŷ��� ó��
		int mem_num = (int)sqlMap.queryForObject("order.selectMem_num",pro_num); // �Ǹ�ȸ����ȣ�� ������ 
		
		Map updateMap = new HashMap();
		updateMap.put("pro_num", pro_num);
		updateMap.put("mem_num", mem_num);
		sqlMap.update("order.updateProboard",updateMap); // ���� proboard�� ���¸� ������Ʈ �ŷ���ó��������
		
		
		orderlistDTO orderDTO = new orderlistDTO();
		orderDTO = (orderlistDTO)sqlMap.queryForObject("order.noticeOrderlist",seq_num); // �������������� �̾ƿ��� orderlist����
		
		
		Map map = new HashMap();
		map.put("num", orderDTO.getSell_memnum()); // notice_(��ȣ) �� �־��� (�Ǹ��ڹ�ȣ)
		map.put("board_num", 0);
		map.put("pro_num",orderDTO.getSell_pronum()); // ��ǰ��ȣ 
		map.put("call_memnum",orderDTO.getBuy_memnum()); // ����ȸ����ȣ
		map.put("call_name",orderDTO.getBuy_name()); // ������
		map.put("categ","product");
		map.put("state", 1);
		
		sqlMap.insert("order.insertNotice",map); // notice ���̺� �� ����
		
		mv.setViewName("tradeDeposit.nhn");
		return mv;
	}
	
}
