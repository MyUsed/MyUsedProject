package product;

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

import main.MainProboardDTO;
import member.MemberDTO;
import member.ProfilePicDTO;
import mypage.AddressDTO;
@Controller
public class ProductOrderController {
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	private List<AddressDTO> addresslist = new ArrayList<AddressDTO>();;
	private List<MemberDTO> memlist = new ArrayList<MemberDTO>();; 
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	@RequestMapping("productOrder.nhn")
	public ModelAndView productOrder(HttpServletRequest request, int mem_num ,int price){
		ModelAndView mv = new ModelAndView();
		
		System.out.println("������ ��ǰ�� ȸ�� ��ȣ�� = "+mem_num);
		
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		int num = (int)sqlMap.queryForObject("main.num",sessionId); // ȸ����ȣ ��������
		
		addresslist = sqlMap.queryForList("address.select",num); // address_$num$�� ����� list�� �����
		
		memlist = sqlMap.queryForList("main.userInfo",mem_num);
		
		// ������ ������ ���� ���� ó�� 
	    Map picmap = new HashMap();
		picmap.put("mem_num", num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // ������ ������ ������

		
		// ��ǰ �Խ��� ����� ������
		
		Map mem_numMap = new HashMap();
		mem_numMap.put("mem_num", mem_num);
		String profilepic = (String) sqlMap.queryForObject("product.propic", mem_numMap);
		
		
		mv.addObject("mem_num",mem_num);
		mv.addObject("profilepic",profilepic);
		mv.addObject("proDTO",proDTO);
		mv.addObject("price",price);
		mv.addObject("num",num);
		mv.addObject("addresslist",addresslist);
		mv.addObject("memlist",memlist);
		mv.setViewName("/product/ProductOrder.jsp");
		
		return mv;
	}
	
	@RequestMapping("/addrInsertOrder.nhn")
	public ModelAndView addressInsert(AddressDTO addrDTO,int num){
		ModelAndView mv = new ModelAndView();
		
		System.out.println("ȸ����ȣ = "+num);
		
		Map map = new HashMap();
		map.put("num", num);
		map.put("name", addrDTO.getName());
		map.put("ph", addrDTO.getPh());
		map.put("addrNum", addrDTO.getAddrNum());
		map.put("addr", addrDTO.getAddr());
		map.put("addrr", addrDTO.getAddrr());
		
		sqlMap.insert("address.insert",map);
		System.out.println("�ּ� ��ϿϷ�");
		
		mv.setViewName("/productOrder.nhn?mem_num"+num);
		return mv;
	}
	


}
