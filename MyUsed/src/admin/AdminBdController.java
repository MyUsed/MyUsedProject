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
import board.FaqDTO;
import board.NoticeDTO;
import board.QnaDTO;
import board.ReportDTO;
import member.ProfilePicDTO;

@Controller
public class AdminBdController {
	//private List<AdminNoticeDTO> list = new ArrayList<AdminNoticeDTO>();;
	private List<AdminFaqDTO> list1 = new ArrayList<AdminFaqDTO>();;
	//private List<AdminReportDTO> list3 = new ArrayList<AdminReportDTO>();;
	private List<AdminQnaDTO> list2 = new ArrayList<AdminQnaDTO>();;
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	@RequestMapping("admin_faq.nhn")
	public ModelAndView admin_faq(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		
		list1=sqlMap.queryForList("faqBd.faq-select",null);
		int count1=(int)sqlMap.queryForObject("faqBd.faqCount", null);
		mv.addObject("list1", list1);
		mv.addObject("count1", count1);
		mv.setViewName("/admin_faq/admin_faqboard.jsp");
		return mv;
	}
	
	@RequestMapping("admin_qna.nhn")
	public ModelAndView admin_qna(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		list2=sqlMap.queryForList("qnaBd.select-All",null);
		int count2=(int)sqlMap.queryForObject("qnaBd.qnaCount", null);
		mv.addObject("list2", list2);
		mv.addObject("count2", count2);
		mv.setViewName("/admin_qna/admin_qnaboard.jsp");
		return mv;
	}
	

}
