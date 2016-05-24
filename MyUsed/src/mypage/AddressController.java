package mypage;

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





@Controller
public class AddressController {

	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	private List<AddressDTO> addresslist = new ArrayList<AddressDTO>();;
	private List<AddressDTO> fianllist = new ArrayList<AddressDTO>();;
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	@RequestMapping("/address.nhn")
	public ModelAndView address(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		int num = (int)sqlMap.queryForObject("main.num",sessionId); // ȸ����ȣ ��������
		
		
		addresslist = sqlMap.queryForList("address.select",num); // address_$num$�� ����� list�� �����
		fianllist = sqlMap.queryForList("address.oneselect",num); // �ֽ��� �ּҸ�� ��������
		
		
		
	    
	    // ������ ������ ���� ���� ó�� 
	    Map picmap = new HashMap();
		picmap.put("mem_num", num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // ��۴� ������ ������ ������
		
		mv.addObject("num",num);
		mv.addObject("addresslist",addresslist);
		mv.addObject("fianllist",fianllist);
		mv.addObject("proDTO",proDTO);
		mv.setViewName("/mypage/address.jsp");
		return mv;
	}
	
	
	
	@RequestMapping("/addrInsert.nhn")
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
		
		mv.setViewName("/address.nhn");
		return mv;
	}
	

}
	
	
	
	
	

