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
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
		
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
		System.out.println("�Է¹��� id = "+ id);
		System.out.println("�Է¹��� pw = "+ pw);
		
		int check = (int)sqlMap.queryForObject("admin.checkId",map);
		System.out.println("���̵� �ִ������� = "+check);
		
		// id�� pw�� ��ġ�ϸ� �α��� ó�� 
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
			
			session.removeAttribute("adminId"); // �α׾ƿ�ó��
			
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
