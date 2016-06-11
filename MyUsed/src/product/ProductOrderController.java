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
	public ModelAndView productOrder(HttpServletRequest request, int mem_num,int price ,int pronum){
		ModelAndView mv = new ModelAndView();
		
		System.out.println("������ ��ǰ�� ȸ�� ��ȣ�� = "+mem_num);
		System.out.println("������ ��ǰ�Խ��� ��ȣ�� = "+pronum);
		
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		int num = (int)sqlMap.queryForObject("main.num",sessionId); // ȸ����ȣ ��������
		
		
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);
		
		request.setAttribute("name", memDTO.getName());
		request.setAttribute("num", memDTO.getNum());
		
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
		
		
		mv.addObject("pronum",pronum);
		mv.addObject("mem_num",mem_num);
		mv.addObject("profilepic",profilepic);
		mv.addObject("proDTO",proDTO);
		mv.addObject("price", price);
		mv.addObject("num",num);
		mv.addObject("addresslist",addresslist);
		mv.addObject("memlist",memlist);
		mv.setViewName("/product/ProductOrder.jsp");
		
		return mv;
	}
	
	@RequestMapping("/orderDetail.nhn")
	public ModelAndView oderDetail(HttpServletRequest request , int seq_num,int num,int price,int mem_num ,int pronum){
		ModelAndView mv = new ModelAndView ();
		
		System.out.println("�ǸŰԽñ۹�ȣ = "+pronum);
		System.out.println("�Ǹ���ȸ���ѹ� = "+mem_num);
		System.out.println("�ּҳѹ� = "+seq_num);
		System.out.println("������ȸ���ѹ� = "+num);
		
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		
		
		

		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);
		
		request.setAttribute("name", memDTO.getName());
		
		
		
		MainProboardDTO proboardDTO = new MainProboardDTO();
		proboardDTO = (MainProboardDTO)sqlMap.queryForObject("product.proInfoSelect",pronum); // �Ǹű� ���� 
		String categ = (String)sqlMap.queryForObject("product.proCategInfoSelect",pronum); // �ش��ǰ ī�װ� ��������
		MemberDTO sellDTO = new MemberDTO();
		sellDTO = (MemberDTO)sqlMap.queryForObject("member.selectDTOforNum",mem_num); // �Ǹ��� ȸ������
		MemberDTO buyDTO = new MemberDTO();
		buyDTO = (MemberDTO)sqlMap.queryForObject("member.selectDTOforNum",num); // ������ ȸ������
		
		Map adrMap = new HashMap();
		adrMap.put("num", num);
		adrMap.put("seq_num", seq_num);
		
		AddressDTO addresslist = new AddressDTO();
		addresslist = (AddressDTO)sqlMap.queryForObject("address.seq_numSelect",adrMap); // �ּ�����
		
		
		Map orderMap = new HashMap();
		orderMap.put("buy_memnum", buyDTO.getNum());
		orderMap.put("buy_id", buyDTO.getId());
		orderMap.put("buy_name",buyDTO.getName());
		orderMap.put("sell_pronum",pronum);
		orderMap.put("sell_memnum",sellDTO.getNum());
		orderMap.put("sell_id", sellDTO.getId());
		orderMap.put("sell_name",sellDTO.getName());
		orderMap.put("sell_categ",categ);
		orderMap.put("sell_propic",proboardDTO.getPro_pic());
		orderMap.put("send_name",addresslist.getName());
		orderMap.put("send_ph",addresslist.getPh());
		orderMap.put("send_adrnum",addresslist.getAddrNum());
		orderMap.put("send_addr",addresslist.getAddr());
		orderMap.put("send_addrr",addresslist.getAddrr());
		orderMap.put("buy_price",proboardDTO.getPrice());
		
		sqlMap.insert("order.insertOrderlist",orderMap); // orderlist�� ����
		
		
		
		
		
		
		 // ������ ������ ���� ���� ó�� 
	    Map picmap = new HashMap();
		picmap.put("mem_num", num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); 
		
		mv.addObject("proDTO",proDTO);
		mv.addObject("price",price);
		mv.addObject("addresslist",addresslist);
		mv.setViewName("/product/OrderDetail.jsp");
		return mv;
		
	}
	
	
	@RequestMapping("/addrInsertOrder.nhn")
	public ModelAndView addressInsert(AddressDTO addrDTO,int mem_num,int num,int price){
		ModelAndView mv = new ModelAndView();
		
		System.out.println("ȸ����ȣ = "+mem_num);
		
		
		Map map = new HashMap();
		map.put("num", num);
		map.put("name", addrDTO.getName());
		map.put("ph", addrDTO.getPh());
		map.put("addrNum", addrDTO.getAddrNum());
		map.put("addr", addrDTO.getAddr());
		map.put("addrr", addrDTO.getAddrr());
		
		sqlMap.insert("address.insert",map);
		System.out.println("�ּ� ��ϿϷ�");
		
		mv.setViewName("redirect:/productOrder.nhn?mem_num="+mem_num+"&price="+price);
		return mv;
	}
	


}
