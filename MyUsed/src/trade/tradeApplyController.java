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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import trade.pagingAction;
import product.orderlistDTO;

@Controller
public class tradeApplyController {


	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
		
	private List<orderlistDTO> orderlist = new ArrayList<orderlistDTO>();;
	
	
	
	private int currentPage = 1;	//현재 페이지
	private int totalCount; 		// 총 게시물의 수
	private int blockCount = 10;	// 한 페이지의  게시물의 수
	private int blockPage = 5; 	// 한 화면에 보여줄 페이지 수
	private String pagingHtml; 	//페이징을 구현한 HTML
	private pagingAction page; 	// 페이징 클래스
	private depositPagingAction depositPage; 	// 페이징 클래스
	
	
	@RequestMapping("/tradeApply.nhn")
	public ModelAndView tradeApply(String currentPage,String search ,String text,String year,String yyear,String month,String mmonth,String day,String dday){
		ModelAndView mv = new ModelAndView();

		if(year == null && search == null){
		orderlist = sqlMap.queryForList("order.selectOrderlist",null);
		}else if(year != null){	
			if(Integer.parseInt(month) < 10 || Integer.parseInt(day) < 10 || Integer.parseInt(mmonth) < 10 || Integer.parseInt(dday) < 10){
				month = "0"+month;
				day = "0"+day;
				mmonth = "0"+mmonth;
				dday = "0"+dday;
			
			}
		String beginReg = year+month+day; // 시작 기간
		String endReg = yyear+mmonth+dday; // 끝기간
	
		Map map = new HashMap();
		map.put("beginReg", beginReg);
		map.put("endReg", endReg);
		orderlist = sqlMap.queryForList("order.RegSearchOrderlist",map); // 기간별 검색
		}else if(search.equals("memnum")){
			
			orderlist = sqlMap.queryForList("order.memnumSearchOrderlist",Integer.parseInt(text)); //회원번호 검색
			
		}else if(search.equals("pronum")){
			
			orderlist = sqlMap.queryForList("order.pronumSearchOrderlist",Integer.parseInt(text)); // 상품번호 검색
		}
		
		
		totalCount = orderlist.size();
		if(currentPage != null){
			this.currentPage = new Integer(currentPage);
		}
		page = new pagingAction(this.currentPage, totalCount, blockCount, blockPage); // pagingAction 객체 생성.
		pagingHtml = page.getPagingHtml().toString(); // 페이지 HTML 생성.
		// 현재 페이지에서 보여줄 마지막 글의 번호 설정.
	
		int lastCount = totalCount;
		// 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;
		orderlist = orderlist.subList(page.getStartCount(), lastCount);
		
		mv.addObject("pagingHtml",pagingHtml);
		mv.addObject("orderlist",orderlist);
		mv.setViewName("/admin_trade/tradeApply.jsp");
		return mv;
	}
	
	@RequestMapping("/tradeDeposit.nhn")
	public ModelAndView tradeDeposit(String currentPage){
		ModelAndView mv = new ModelAndView();
		
		orderlist = sqlMap.queryForList("order.selectOrderlist",null);
		
		totalCount = orderlist.size();
		if(currentPage != null){
			this.currentPage = new Integer(currentPage);
		}
		depositPage = new depositPagingAction(this.currentPage, totalCount, blockCount, blockPage); // pagingAction 객체 생성.
		pagingHtml = depositPage.getPagingHtml().toString(); // 페이지 HTML 생성.
		// 현재 페이지에서 보여줄 마지막 글의 번호 설정.
	
		int lastCount = totalCount;
		// 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
		if (depositPage.getEndCount() < totalCount)
			lastCount = depositPage.getEndCount() + 1;
		orderlist = orderlist.subList(depositPage.getStartCount(), lastCount);
		
		mv.addObject("pagingHtml",pagingHtml);
		mv.addObject("orderlist",orderlist);
		mv.setViewName("/admin_trade/tradeDeposit.jsp");
		return mv;
	}
	
	@RequestMapping("insertNotice.nhn")
	public ModelAndView inserDeposit(int seq_num){
		ModelAndView mv = new ModelAndView();
		System.out.println("전달받은 seq_num = "+seq_num);
		
		sqlMap.update("order.updateState",seq_num); // seq_num 번호인 orderlist 입금완료 처리 
		int pro_num = (int)sqlMap.queryForObject("order.selectProNum",seq_num); // orderlist 에서 게시글 번호를 꺼내옴
		sqlMap.update("order.updateProboardlist",pro_num); // proboardlist의 sendpay상태를 0으로 만들어서 거래중 처리
		int mem_num = (int)sqlMap.queryForObject("order.selectMem_num",pro_num); // 판매회원번호를 가져옴 
		
		Map updateMap = new HashMap();
		updateMap.put("pro_num", pro_num);
		updateMap.put("mem_num", mem_num);
		sqlMap.update("order.updateProboard",updateMap); // 개인 proboard의 상태를 업데이트 거래중처리를위해
		
		
		orderlistDTO orderDTO = new orderlistDTO();
		orderDTO = (orderlistDTO)sqlMap.queryForObject("order.noticeOrderlist",seq_num); // 시퀀스기준으로 뽑아오는 orderlist정보
		
		
		Map map = new HashMap();
		map.put("num", orderDTO.getSell_memnum()); // notice_(번호) 를 넣어줌 (판매자번호)
		map.put("board_num", 0);
		map.put("pro_num",orderDTO.getSell_pronum()); // 상품번호 
		map.put("call_memnum",orderDTO.getBuy_memnum()); // 구매회원번호
		map.put("call_name",orderDTO.getBuy_name()); // 구매자
		map.put("categ","product");
		map.put("state", 1);
		
		sqlMap.insert("order.insertNotice",map); // notice 테이블에 값 삽입
		
		mv.setViewName("tradeDeposit.nhn");
		return mv;
	}
	
	@RequestMapping("NoticeUpdate.nhn")
	public ModelAndView NoticeUpdate(int mynum , int memnum){
		ModelAndView mv = new ModelAndView();
		
		Map map = new HashMap();
		map.put("memnum", memnum);
		map.put("mynum", mynum);
		sqlMap.update("order.updateNoticeMsg",map); // 읽은 메세지 알림 처리
		
		
		
		return mv;
	}
	@RequestMapping("NoticeUpdateFriend.nhn")
	public ModelAndView noticeUpdateFriend(int mynum, int memnum){
		
		ModelAndView mv = new ModelAndView();
		
		Map map = new HashMap();
		map.put("mynum", mynum);
		map.put("memnum", memnum);
		sqlMap.update("order.updateNoticeFriend",map); // 친구추가 메세지 확인 알람처리
		
		mv.setViewName("");
		
		return mv;
	}
	
	@RequestMapping("NoticeUpdateTeg.nhn")
	public ModelAndView noticeUpdateTeg(HttpServletRequest request , int mynum, int memnum){
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		int mem = (int)sqlMap.queryForObject("main.num",sessionId);
		
		Map map = new HashMap();
		map.put("mem", mem);
		map.put("mynum", mynum);
		map.put("memnum", memnum);
	
		sqlMap.update("order.updateNoticeTeg",map); // 알림 상태 0 으로변경 태그 
		
		return mv;
	}
	
	@RequestMapping("NoticeUpdatPost.nhn")
	public ModelAndView noticeUpdatePost( int mynum, int pro_num){
		ModelAndView mv = new ModelAndView();
		
		Map map = new HashMap();
		map.put("mynum", mynum);
		map.put("pro_num", pro_num);
		
		sqlMap.update("order.updateNoticePost",map); // 알림 상태 0 으로	변경 배송 
		
		return mv;
	}
	
	@RequestMapping("NoticeUpdatModifyR.nhn")
	public ModelAndView noticeUpdatModifyR( int mynum){
		ModelAndView mv = new ModelAndView();
		
		Map map = new HashMap();
		map.put("mynum", mynum);
		
		
		sqlMap.update("order.updateNoticeModifyR",map); // 알림 상태 0 으로	변경 배송 
		
		return mv;
	}
	
	@RequestMapping("NoticeUpdatModifyP.nhn")
	public ModelAndView noticeUpdatModifyP( int mynum){
		ModelAndView mv = new ModelAndView();
		
		Map map = new HashMap();
		map.put("mynum", mynum);
		
		
		sqlMap.update("order.updateNoticeModifyP",map); // 알림 상태 0 으로	변경 배송 
		
		return mv;
	}
	
	
	
	
	
	
}
