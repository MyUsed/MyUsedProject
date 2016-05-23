package mypage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AddressController {
	
	@RequestMapping("/address.nhn")
	public ModelAndView address (){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/menu/address.jsp");
		return mv;
	}

}
