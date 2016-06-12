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
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
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
		
		// << 공지사항 메뉴 >>
		// 1. 공지사항 띄우기
		admin_Notice = sqlMap.queryForList("adminMain.select_Notice",null);
		// << 게시글통계 메뉴 >>
		// 1. 게시글통계
		int total_board = (int)sqlMap.queryForObject("adminMain.total_board",null);
		// 2. 댓글 1000개 이상
		int board_reples = (int)sqlMap.queryForObject("adminMain.board_reples",null);
		// 3. 좋아요 1000개 이상
		int board_likes = (int)sqlMap.queryForObject("adminMain.board_likes",null);
		
		
		
		
		// << 회원통계 메뉴 >>
		// 1.총 회원수 
		int total_mem = (int)sqlMap.queryForObject("adminMain.total_mem",null);
		// 2.접속중 회원
		int mem_login = (int)sqlMap.queryForObject("adminMain.mem_login",null);
		// 3.신고접수 회원
		int mem_report = (int)sqlMap.queryForObject("adminMain.mem_report",null);
		// 4.일반 회원수 
		int nomal_mem = (int)sqlMap.queryForObject("adminMain.nomal_mem",null);
		// 5.네이버 회원소
		int naver_mem = (int)sqlMap.queryForObject("adminMain.naver_mem",null);
		
		
		
		
		
		// << 거래 현황 메뉴 >>
		// 1. 거래신청
		int trade_all = (int)sqlMap.queryForObject("adminMain.trade_all",null);
		// 2. 입금완료
		int trade_deposit = (int)sqlMap.queryForObject("adminMain.trade_deposit",null);
		// 3. 송금완료
		int trade_finish = (int)sqlMap.queryForObject("adminMain.trade_finish",null);
		// 4. 배송중
		int trade_send = (int)sqlMap.queryForObject("adminMain.trade_send",null);
		
		
		// << 상품 현황 메뉴 >>
		// 1.총 상품판매글
		int total_pro = (int)sqlMap.queryForObject("adminMain.total_pro",null);
		// 2.거래중인 상품
		
		
		
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
