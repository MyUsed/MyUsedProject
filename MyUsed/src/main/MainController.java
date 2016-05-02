package main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {

	
	
	@RequestMapping("/MyUsed.nhn")
	public ModelAndView main(){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/main/MyUsed.jsp");
		return mv;
	}
	
	@RequestMapping("/MyUsedLogin.nhn")
	public ModelAndView login(){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/main/MyUsedLogin.jsp");
		return mv;
	}
	

}
