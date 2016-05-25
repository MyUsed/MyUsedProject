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
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	private List<AddressDTO> addresslist = new ArrayList<AddressDTO>();;
	private List<MemberDTO> memlist = new ArrayList<MemberDTO>();; 
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	@RequestMapping("productOrder.nhn")
	public ModelAndView productOrder(HttpServletRequest request, int mem_num,int price){
		ModelAndView mv = new ModelAndView();
		
		System.out.println("선택한 상품의 회원 번호는 = "+mem_num);
		
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		int num = (int)sqlMap.queryForObject("main.num",sessionId); // 회원번호 가져오기
		
		addresslist = sqlMap.queryForList("address.select",num); // address_$num$의 결과를 list로 담아줌
		
		memlist = sqlMap.queryForList("main.userInfo",mem_num);
		
		// 프로필 사진을 띄우기 위한 처리 
	    Map picmap = new HashMap();
		picmap.put("mem_num", num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // 프로필 사진을 가져옴

		
		// 상품 게시한 사람의 프로필
		
		Map mem_numMap = new HashMap();
		mem_numMap.put("mem_num", mem_num);
		String profilepic = (String) sqlMap.queryForObject("product.propic", mem_numMap);
		
		
				
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
	public ModelAndView oderDetail(int seq_num,int num,int price){
		ModelAndView mv = new ModelAndView ();
		
		System.out.println("주소넘버 = "+seq_num);
		System.out.println("회원넘버 = "+num);
		
		Map adrMap = new HashMap();
		adrMap.put("num", num);
		adrMap.put("seq_num", seq_num);
		
		AddressDTO addresslist = new AddressDTO();
		addresslist = (AddressDTO)sqlMap.queryForObject("address.seq_numSelect",adrMap);
		
		
		 // 프로필 사진을 띄우기 위한 처리 
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
		
		System.out.println("회원번호 = "+mem_num);
		
		
		Map map = new HashMap();
		map.put("num", num);
		map.put("name", addrDTO.getName());
		map.put("ph", addrDTO.getPh());
		map.put("addrNum", addrDTO.getAddrNum());
		map.put("addr", addrDTO.getAddr());
		map.put("addrr", addrDTO.getAddrr());
		
		sqlMap.insert("address.insert",map);
		System.out.println("주소 등록완료");
		
		mv.setViewName("redirect:/productOrder.nhn?mem_num="+mem_num+"&price="+price);
		return mv;
	}
	


}
