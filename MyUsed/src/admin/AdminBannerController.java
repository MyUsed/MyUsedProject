package admin;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import admin.pagingAction;
import member.ProfilePicDTO;

@Controller
public class AdminBannerController {
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private ProfilePicDTO boardproDTO = new ProfilePicDTO();
	private List<BannerApplyDTO> bannerlist = new ArrayList<BannerApplyDTO>();;
	private BannerApplyDTO applyDTO = new BannerApplyDTO();
	
	private int currentPage = 1;	//현재 페이지
	private int totalCount; 		// 총 게시물의 수
	private int blockCount = 5;	// 한 페이지의  게시물의 수
	private int blockPage = 5; 	// 한 화면에 보여줄 페이지 수
	private String pagingHtml; 	//페이징을 구현한 HTML
	private pagingAction page; 	// 페이징 클래스
	private deletePagingAction deletepage; 	// 페이징 클래스
	
	@RequestMapping("/adver.nhn")
	public ModelAndView adver(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		 HttpSession session = request.getSession();
		    String sessionId = (String) session.getAttribute("memId");
		    int session_num = (int)sqlMap.queryForObject("main.num",sessionId); // 회원번호 가져오기

		    Map picmap = new HashMap();
			picmap.put("mem_num", session_num);   
			proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // 프로필 사진을 가져옴
			

			// 광고 가져옴 
			BannerApplyDTO banner = new BannerApplyDTO();
			banner = (BannerApplyDTO)sqlMap.queryForObject("main.bannerSelect",null);
			
			
			
			
		mv.addObject("banner",banner);
		mv.addObject("proDTO",proDTO);
		mv.setViewName("/main/applyAdvertise.jsp");
		return mv;
	}
	
	// 신청된 베너 전체보기
	@RequestMapping("/applyBanner.nhn")
	public ModelAndView applybanner(String currentPage){
		ModelAndView mv = new ModelAndView();
		
		bannerlist = sqlMap.queryForList("admin.selectApply",null);
		
		totalCount = bannerlist.size();
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
		bannerlist = bannerlist.subList(page.getStartCount(), lastCount);
		
		mv.addObject("pagingHtml",pagingHtml);
		mv.addObject("currentPage",this.currentPage);
		mv.addObject("bannerlist",bannerlist);
		mv.setViewName("/admin_banner/applyBanner.jsp");
		return mv;
	}
	
	// 상세보기 
	@RequestMapping("/applyDetail.nhn")
	public ModelAndView applyDetail(int seq_num){
		ModelAndView mv = new ModelAndView();
		
		applyDTO = (BannerApplyDTO)sqlMap.queryForObject("admin.detailApply",seq_num);
		
		
		mv.addObject("applyDTO",applyDTO);
		mv.setViewName("/admin_banner/applyDetail.jsp");
		return mv;
	}
	
	@RequestMapping("/insertBanner.nhn")
	public ModelAndView insertbanner(){
		ModelAndView mv = new ModelAndView();
		
		bannerlist = sqlMap.queryForList("admin.selectApply",null);
		
		mv.addObject("bannerlist",bannerlist);
		mv.setViewName("/admin_banner/insertBanner.jsp");
		return mv;
	}
	
	@RequestMapping("/applyBannerSubmit.nhn")
	public ModelAndView applyBannersubmit(MultipartHttpServletRequest request , BannerApplyDTO applyDTO){
		ModelAndView mv = new ModelAndView();

		
		MultipartFile mf = request.getFile("image"); // 파일을 받는 MultipartFile 클래스  (원본)
		String orgName = mf.getOriginalFilename(); 
		File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // 업로드
		applyDTO.setImg(orgName);
		sqlMap.insert("admin.insertApply",applyDTO); // 신청값 bannerapply 테이블에 삽입
		
		try{
			mf.transferTo(copy);	// 업로드 
		}catch(Exception e){e.printStackTrace();}
		
		mv.addObject("i",1);
		mv.setViewName("/admin_banner/applyalert.jsp");
		return mv;
		
	}
	
	@RequestMapping("/bannerInsert.nhn")
	public ModelAndView insertBanner(String img,String url){
		ModelAndView mv = new ModelAndView();

		Map map = new HashMap();
		map.put("img", img);
		map.put("url",url);
		
		sqlMap.insert("admin.insertBanner",map); // 광고 삽입 
		
		mv.addObject("i",2);
		mv.setViewName("/admin_banner/applyalert.jsp");
		return mv;
	}
	
	@RequestMapping("/updateState.nhn")
	public ModelAndView updateState(int seq_num){
		ModelAndView mv = new ModelAndView();
		
		sqlMap.update("admin.updateState",seq_num); // 상태 업데이트 +1
		
		mv.setViewName("applyBanner.nhn");
		return mv;
	}
	
	@RequestMapping("/deleteBanner.nhn")
	public ModelAndView deleteBanner(String currentPage){
		ModelAndView mv = new ModelAndView();
		bannerlist = sqlMap.queryForList("admin.selectApply",null);
		
		totalCount = bannerlist.size();
		if(currentPage != null){
			this.currentPage = new Integer(currentPage);
		}
		deletepage = new deletePagingAction(this.currentPage, totalCount, blockCount, blockPage); // pagingAction 객체 생성.
		pagingHtml = deletepage.getPagingHtml().toString(); // 페이지 HTML 생성.
		// 현재 페이지에서 보여줄 마지막 글의 번호 설정.
	
		int lastCount = totalCount;
		// 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
		if (deletepage.getEndCount() < totalCount)
			lastCount = deletepage.getEndCount() + 1;
		bannerlist = bannerlist.subList(deletepage.getStartCount(), lastCount);
		
		mv.addObject("pagingHtml",pagingHtml);
		mv.addObject("currentPage",this.currentPage);
		mv.addObject("bannerlist",bannerlist);
		mv.setViewName("/admin_banner/deleteBanner.jsp");
		return mv;
	}
	@RequestMapping("/deleteApply.nhn")
	public ModelAndView deleteApply(int seq_num){
		ModelAndView mv = new ModelAndView();
		
		sqlMap.delete("admin.deleteApply",seq_num); // 신청삭제;
		mv.addObject("i",3);
		mv.setViewName("admin_banner/applyalert.jsp");
		return mv;
	}
	
	@RequestMapping("updateBanner.nhn")
	public ModelAndView updateBanner(){
		ModelAndView mv = new ModelAndView();
		
		applyDTO = (BannerApplyDTO)sqlMap.queryForObject("admin.bannerIng",null); // 현재 메인에 있는 광고정보
		
		mv.addObject("applyDTO",applyDTO);
		mv.setViewName("/admin_banner/updateBanner.jsp");
		return mv;
	}
	
	@RequestMapping("updateBannerSubmit.nhn")
	public ModelAndView updateBannerSubmit(MultipartHttpServletRequest request  , BannerApplyDTO applyDTO ){
		ModelAndView mv = new ModelAndView();
		
		MultipartFile mf = request.getFile("image"); // 파일을 받는 MultipartFile 클래스  (원본)
		String orgName = mf.getOriginalFilename(); 
		File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // 업로드
		applyDTO.setImg(orgName);
		
		Map map = new HashMap();
		map.put("img", applyDTO.getImg());
		map.put("url", applyDTO.getUrl());
		
		sqlMap.insert("admin.insertBanner",map); // 광고 삽입 
		
		try{
			mf.transferTo(copy);	// 파일 업로드 
		}catch(Exception e){e.printStackTrace();}
		
		mv.addObject("i",4);
		mv.setViewName("admin_banner/applyalert.jsp");
		
		return mv;
	}
	

	
	
	
	
	

}
