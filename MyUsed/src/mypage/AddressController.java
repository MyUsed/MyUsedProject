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

	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	private List<AddressDTO> addresslist = new ArrayList<AddressDTO>();;
	private List<AddressDTO> fianllist = new ArrayList<AddressDTO>();;
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	@RequestMapping("/address.nhn")
	public ModelAndView address(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		int num = (int)sqlMap.queryForObject("main.num",sessionId); // 회원번호 가져오기
		
		
		addresslist = sqlMap.queryForList("address.select",num); // address_$num$의 결과를 list로 담아줌
		fianllist = sqlMap.queryForList("address.oneselect",num); // 최신의 주소목록 가져오기
		
		
		
	    
	    // 프로필 사진을 띄우기 위한 처리 
	    Map picmap = new HashMap();
		picmap.put("mem_num", num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // 댓글단 프로필 사진을 가져옴
		
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
		
		System.out.println("회원번호 = "+num);
		
		Map map = new HashMap();
		map.put("num", num);
		map.put("name", addrDTO.getName());
		map.put("ph", addrDTO.getPh());
		map.put("addrNum", addrDTO.getAddrNum());
		map.put("addr", addrDTO.getAddr());
		map.put("addrr", addrDTO.getAddrr());
		
		sqlMap.insert("address.insert",map);
		System.out.println("주소 등록완료");
		
		mv.setViewName("/address.nhn");
		return mv;
	}
	

}
	
	
	
	
	

