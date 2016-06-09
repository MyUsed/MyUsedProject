package admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminNoticeController {
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private ModelAndView mv = new ModelAndView();
	
	@RequestMapping("admin_notice.nhn")
	public ModelAndView admin_notice(){
		List list = sqlMapClientTemplate.queryForList("adminNotice.all", null);
		mv.addObject("list", list);
		mv.setViewName("/admin_notice/adminNotice.jsp");
		return mv;
	}
	
	@RequestMapping("admin_noticeWrite.nhn")
	public ModelAndView admin_noticeWrite(){
		mv.setViewName("/admin_notice/adminNoticeWrite.jsp");
		return mv;
	}
	
	@RequestMapping("admin_noticeInsert.nhn")
	public ModelAndView admin_noticeInsert(String title, String content){
		Map map = new HashMap();
		map.put("title", title);
		map.put("content", content);
		sqlMapClientTemplate.insert("adminNotice.insert", map);
		mv.setViewName("admin_notice.nhn");
		return mv;
	}
	
	@RequestMapping("admin_noticeModifyMain.nhn")
	public ModelAndView admin_noticeModifyMain(){
		List list = sqlMapClientTemplate.queryForList("adminNotice.all", null);	// 공지사항 전체가져오기
		mv.addObject("list", list);
		mv.setViewName("/admin_notice/adminNoticeModifyMain.jsp");
		return mv;
	}
	
	@RequestMapping("admin_noticeModify.nhn")
	public ModelAndView admin_noticeModify(int seq_num, AdminNoticeDTO ndto){
		ndto = (AdminNoticeDTO)sqlMapClientTemplate.queryForObject("adminNotice.one", seq_num);	// 공지사항 한개 가져오기
		mv.addObject("ndto", ndto);
		mv.addObject("seq_num", seq_num);
		mv.setViewName("/admin_notice/adminNoticeModify.jsp");
		return mv;
	}
	
	@RequestMapping("admin_noticeUpdate.nhn")
	public ModelAndView admin_noticeUpdate(int seq_num, String content, String title){
		Map map = new HashMap();
		map.put("content", content);
		map.put("title", title);
		map.put("seq_num", seq_num);
		sqlMapClientTemplate.update("adminNotice.update", map);
		mv.setViewName("/admin_notice/adminNoticeUpdate.jsp");
		return mv;
	}
	
	@RequestMapping("admin_noticeDelete.nhn")
	public String admin_noticeDelete(int seq_num){
		sqlMapClientTemplate.delete("adminNotice.delete", seq_num);
		return "/admin_notice/adminNoticeDelete.jsp";
	}
}
