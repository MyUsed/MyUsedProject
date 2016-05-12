package login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class chatLoginBean {
	@Autowired
	private SqlMapClientTemplate SqlMapClientTemplate;
	
	@RequestMapping("chatloginForm.nhn")
	public String loginForm(){
		return "/login/loginForm.jsp";	//로그인 폼
	}
	
	
	
	
	@RequestMapping("chatloginPro.nhn")
	public ModelAndView loginPro(loginDTO dto, HttpSession session){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		int count = (Integer)SqlMapClientTemplate.queryForObject("chat.logincheck", dto);	//id와 pw check
		map.put("id", dto.getId());
		if(count == 1){
			session.setAttribute("memId", dto.getId());	//check완료시 메인으로 가서 세션생성
			mv.setViewName("/views/main.jsp");
		}
		
		else{
			mv.setViewName("/login/loginPro.jsp");	//id와 pw 틀림
		}
		return mv;
	}

}
