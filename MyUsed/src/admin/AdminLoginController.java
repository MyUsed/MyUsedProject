package admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminLoginController {
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
		
	@RequestMapping("/MyUsedAdmin.nhn")
	public ModelAndView login(){
		ModelAndView mv = new ModelAndView();	
		mv.setViewName("/admin/AdminLogin.jsp");	
		return mv;
	}
	
	@RequestMapping("/AdminLogin.nhn")
	public ModelAndView adminlogin(HttpServletRequest request, String id , String pw){
		ModelAndView mv = new ModelAndView();	
		
		Map map = new HashMap();
		map.put("id", id);
		map.put("pw", pw);
		System.out.println("입력받은 id = "+ id);
		System.out.println("입력받은 pw = "+ pw);
		
		int check = (int)sqlMap.queryForObject("admin.checkId",map);
		System.out.println("아이디가 있는지여부 = "+check);
		
		// id와 pw가 일치하면 로그인 처리 
		if(check == 1){
			HttpSession session = request.getSession();
			session.setAttribute("adminId", id);
			
		mv.setViewName("/admin/AdminLoginPro.jsp");
		
		}else{
			mv.setViewName("/admin/AdminLogin.jsp");
		}
		return mv;
}
	
		
	@RequestMapping("/MyUsedAdminLogout.nhn")
	public ModelAndView logoutAdmin(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
			HttpSession session = request.getSession();
			
			session.removeAttribute("adminId"); // 로그아웃처리
			
		mv.setViewName("/admin/AdminLogin.jsp");	
		return mv;
	}
	
	
	@RequestMapping("/Admin.nhn")
	public ModelAndView adminPage(){
		ModelAndView mv = new ModelAndView();	

		mv.setViewName("/admin/AdminPage.jsp");	
		return mv;
	}
	
	

}
