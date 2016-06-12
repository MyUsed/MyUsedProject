package admin;

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

@Controller
public class AdminLoginController {
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	private List <AdminNoticeDTO> admin_Notice = new ArrayList<AdminNoticeDTO>();;  
		
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
		
		// << �������� �޴� >>
		// 1. �������� ����
		admin_Notice = sqlMap.queryForList("adminMain.select_Notice",null);
		// << �Խñ���� �޴� >>
		// 1. �Խñ����
		int total_board = (int)sqlMap.queryForObject("adminMain.total_board",null);
		// 2. ��� 1000�� �̻�
		int board_reples = (int)sqlMap.queryForObject("adminMain.board_reples",null);
		// 3. ���ƿ� 1000�� �̻�
		int board_likes = (int)sqlMap.queryForObject("adminMain.board_likes",null);
		
		
		
		
		// << ȸ����� �޴� >>
		// 1.�� ȸ���� 
		int total_mem = (int)sqlMap.queryForObject("adminMain.total_mem",null);
		// 2.������ ȸ��
		int mem_login = (int)sqlMap.queryForObject("adminMain.mem_login",null);
		// 3.�Ű����� ȸ��
		int mem_report = (int)sqlMap.queryForObject("adminMain.mem_report",null);
		// 4.�Ϲ� ȸ���� 
		int nomal_mem = (int)sqlMap.queryForObject("adminMain.nomal_mem",null);
		// 5.���̹� ȸ����
		int naver_mem = (int)sqlMap.queryForObject("adminMain.naver_mem",null);
		
		
		
		
		
		// << �ŷ� ��Ȳ �޴� >>
		// 1. �ŷ���û
		int trade_all = (int)sqlMap.queryForObject("adminMain.trade_all",null);
		// 2. �ԱݿϷ�
		int trade_deposit = (int)sqlMap.queryForObject("adminMain.trade_deposit",null);
		// 3. �۱ݿϷ�
		int trade_finish = (int)sqlMap.queryForObject("adminMain.trade_finish",null);
		// 4. �����
		int trade_send = (int)sqlMap.queryForObject("adminMain.trade_send",null);
		
		
		// << ��ǰ ��Ȳ �޴� >>
		// 1.�� ��ǰ�Ǹű�
		int total_pro = (int)sqlMap.queryForObject("adminMain.total_pro",null);
		// 2.�ŷ����� ��ǰ
		
		
		
		mv.addObject("admin_Notice",admin_Notice);
		mv.addObject("total_board",total_board);
		mv.addObject("board_reples",board_reples);
		mv.addObject("board_likes",board_likes);
		mv.addObject("total_mem",total_mem);
		mv.addObject("mem_login",mem_login);
		mv.addObject("mem_report",mem_report);
		mv.addObject("nomal_mem",nomal_mem);
		mv.addObject("naver_mem",naver_mem);
		mv.addObject("trade_all",trade_all);
		mv.addObject("trade_deposit",trade_deposit);
		mv.addObject("trade_finish",trade_finish);
		mv.addObject("trade_send",trade_send);
		mv.addObject("total_pro",total_pro);
		
		mv.setViewName("/admin/AdminPage.jsp");	
		return mv;
	}
	
	

}
