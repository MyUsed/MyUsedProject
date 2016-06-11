package trade;

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

import member.MemberDTO;
import member.ProfilePicDTO;
import product.orderlistDTO;

@Controller
public class depositController {
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private selllistDTO sellDTO = new selllistDTO();
	private List selllist = new ArrayList();
	
	private int currentPage = 1;	//현재 페이지
	private int totalCount; 		// 총 게시물의 수
	private int blockCount = 10;	// 한 페이지의  게시물의 수
	private int blockPage = 5; 	// 한 화면에 보여줄 페이지 수
	private String pagingHtml; 	//페이징을 구현한 HTML
	private bankPagingAction page; 	// 페이징 클래스
	
	@RequestMapping("/depositState.nhn")
	public ModelAndView depositsate(HttpServletRequest request){
		 ModelAndView mv = new  ModelAndView();
		 
		HttpSession session = request.getSession();
		
		String sessionId = (String) session.getAttribute("memId");
		int mem_num = (int)sqlMap.queryForObject("main.num",sessionId); // 회원번호를 꺼내옴
		Map picmap = new HashMap();
		picmap.put("mem_num", mem_num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // 로그인한 프로필 가져옴
		
		
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);

		request.setAttribute("name", memDTO.getName());
		request.setAttribute("num", memDTO.getNum());

		
		orderlistDTO depositlist = new orderlistDTO();
		depositlist = (orderlistDTO)sqlMap.queryForObject("trade.depositInfo",mem_num); // 거래요청된 정보
		
		mv.addObject("depositlist",depositlist);
		mv.addObject("proDTO",proDTO);
		mv.setViewName("/admin_deposit/depositState.jsp");
		return mv;
	}
	
	@RequestMapping("/submitAcount.nhn")
	public ModelAndView sunmitDeposit(selllistDTO sellDTO){
		ModelAndView mv = new ModelAndView();
		
		sqlMap.insert("trade.insertDepositInfo",sellDTO); // 입력받은값 selllist 에 삽입 ;
		
		mv.setViewName("/MyUsed.nhn");
		return mv;
	}
	
	@RequestMapping("/tradePost.nhn")
	public ModelAndView tradepost(String currentPage){
		ModelAndView mv = new ModelAndView();
		
		selllist = sqlMap.queryForList("trade.selectSelllist",null);
		
		
		
		totalCount = selllist.size();
		if(currentPage != null){
			this.currentPage = new Integer(currentPage);
		}
		page = new bankPagingAction(this.currentPage, totalCount, blockCount, blockPage); // pagingAction 객체 생성.
		pagingHtml = page.getPagingHtml().toString(); // 페이지 HTML 생성.
		// 현재 페이지에서 보여줄 마지막 글의 번호 설정.
	
		int lastCount = totalCount;
		// 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;
		selllist = selllist.subList(page.getStartCount(), lastCount);
		
		mv.addObject("pagingHtml",pagingHtml);
		mv.addObject("selllist",selllist);
		mv.setViewName("/admin_deposit/postState.jsp");
		return mv;
	}
	
	@RequestMapping("/depositCheck.nhn")
	public ModelAndView depositCheck(int seq_num){
		ModelAndView mv = new ModelAndView();
		
		sqlMap.update("trade.updateSelllist",seq_num); // 배송상태 업데이트
		
		int pro_num = (int)sqlMap.queryForObject("trade.selectPronum",seq_num); // 게시글 번호를 가져옴
		sqlMap.update("order.updateOrderlist",pro_num);// orderlist 상태 2로 변경 
		
		mv.setViewName("tradePost.nhn");
		return mv;
	}

	
	
	
	
	
	
	
	
	
	
}

