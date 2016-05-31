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
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private ProfilePicDTO boardproDTO = new ProfilePicDTO();
	private List<BannerApplyDTO> bannerlist = new ArrayList<BannerApplyDTO>();;
	private BannerApplyDTO applyDTO = new BannerApplyDTO();
	
	private int currentPage = 1;	//���� ������
	private int totalCount; 		// �� �Խù��� ��
	private int blockCount = 5;	// �� ��������  �Խù��� ��
	private int blockPage = 5; 	// �� ȭ�鿡 ������ ������ ��
	private String pagingHtml; 	//����¡�� ������ HTML
	private pagingAction page; 	// ����¡ Ŭ����
	private deletePagingAction deletepage; 	// ����¡ Ŭ����
	
	@RequestMapping("/adver.nhn")
	public ModelAndView adver(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		 HttpSession session = request.getSession();
		    String sessionId = (String) session.getAttribute("memId");
		    int session_num = (int)sqlMap.queryForObject("main.num",sessionId); // ȸ����ȣ ��������

		    Map picmap = new HashMap();
			picmap.put("mem_num", session_num);   
			proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // ������ ������ ������
			

			// ���� ������ 
			BannerApplyDTO banner = new BannerApplyDTO();
			banner = (BannerApplyDTO)sqlMap.queryForObject("main.bannerSelect",null);
			
			
			
			
		mv.addObject("banner",banner);
		mv.addObject("proDTO",proDTO);
		mv.setViewName("/main/applyAdvertise.jsp");
		return mv;
	}
	
	// ��û�� ���� ��ü����
	@RequestMapping("/applyBanner.nhn")
	public ModelAndView applybanner(String currentPage){
		ModelAndView mv = new ModelAndView();
		
		bannerlist = sqlMap.queryForList("admin.selectApply",null);
		
		totalCount = bannerlist.size();
		if(currentPage != null){
			this.currentPage = new Integer(currentPage);
		}
		page = new pagingAction(this.currentPage, totalCount, blockCount, blockPage); // pagingAction ��ü ����.
		pagingHtml = page.getPagingHtml().toString(); // ������ HTML ����.
		// ���� ���������� ������ ������ ���� ��ȣ ����.
	
		int lastCount = totalCount;
		// ���� �������� ������ ���� ��ȣ�� ��ü�� ������ �� ��ȣ���� ������ lastCount�� +1 ��ȣ�� ����.
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;
		bannerlist = bannerlist.subList(page.getStartCount(), lastCount);
		
		mv.addObject("pagingHtml",pagingHtml);
		mv.addObject("currentPage",this.currentPage);
		mv.addObject("bannerlist",bannerlist);
		mv.setViewName("/admin_banner/applyBanner.jsp");
		return mv;
	}
	
	// �󼼺��� 
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

		
		MultipartFile mf = request.getFile("image"); // ������ �޴� MultipartFile Ŭ����  (����)
		String orgName = mf.getOriginalFilename(); 
		File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // ���ε�
		applyDTO.setImg(orgName);
		sqlMap.insert("admin.insertApply",applyDTO); // ��û�� bannerapply ���̺� ����
		
		try{
			mf.transferTo(copy);	// ���ε� 
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
		
		sqlMap.insert("admin.insertBanner",map); // ���� ���� 
		
		mv.addObject("i",2);
		mv.setViewName("/admin_banner/applyalert.jsp");
		return mv;
	}
	
	@RequestMapping("/updateState.nhn")
	public ModelAndView updateState(int seq_num){
		ModelAndView mv = new ModelAndView();
		
		sqlMap.update("admin.updateState",seq_num); // ���� ������Ʈ +1
		
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
		deletepage = new deletePagingAction(this.currentPage, totalCount, blockCount, blockPage); // pagingAction ��ü ����.
		pagingHtml = deletepage.getPagingHtml().toString(); // ������ HTML ����.
		// ���� ���������� ������ ������ ���� ��ȣ ����.
	
		int lastCount = totalCount;
		// ���� �������� ������ ���� ��ȣ�� ��ü�� ������ �� ��ȣ���� ������ lastCount�� +1 ��ȣ�� ����.
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
		
		sqlMap.delete("admin.deleteApply",seq_num); // ��û����;
		mv.addObject("i",3);
		mv.setViewName("admin_banner/applyalert.jsp");
		return mv;
	}
	
	@RequestMapping("updateBanner.nhn")
	public ModelAndView updateBanner(){
		ModelAndView mv = new ModelAndView();
		
		applyDTO = (BannerApplyDTO)sqlMap.queryForObject("admin.bannerIng",null); // ���� ���ο� �ִ� ��������
		
		mv.addObject("applyDTO",applyDTO);
		mv.setViewName("/admin_banner/updateBanner.jsp");
		return mv;
	}
	
	@RequestMapping("updateBannerSubmit.nhn")
	public ModelAndView updateBannerSubmit(MultipartHttpServletRequest request  , BannerApplyDTO applyDTO ){
		ModelAndView mv = new ModelAndView();
		
		MultipartFile mf = request.getFile("image"); // ������ �޴� MultipartFile Ŭ����  (����)
		String orgName = mf.getOriginalFilename(); 
		File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // ���ε�
		applyDTO.setImg(orgName);
		
		Map map = new HashMap();
		map.put("img", applyDTO.getImg());
		map.put("url", applyDTO.getUrl());
		
		sqlMap.insert("admin.insertBanner",map); // ���� ���� 
		
		try{
			mf.transferTo(copy);	// ���� ���ε� 
		}catch(Exception e){e.printStackTrace();}
		
		mv.addObject("i",4);
		mv.setViewName("admin_banner/applyalert.jsp");
		
		return mv;
	}
	

	
	
	
	
	

}
