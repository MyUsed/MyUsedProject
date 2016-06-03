package admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import main.MainProboardDTO;
import main.MainboardDTO;
import paper.pagingAction;

@Controller
public class AdminBoardController {
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private ModelAndView mv = new ModelAndView();

	@RequestMapping("admin_boardMain.nhn")
	public String admin_boardMain(){
		return "/admin_board/admin_boardMain.jsp";
	}
	
	@RequestMapping("admin_boardSearch.nhn")
	public ModelAndView admin_boardSearch(String id_search, String radio, HttpServletRequest request){
		String pagecurrent = request.getParameter("currentPage");	// 현재페이지의 parameter값을 담는 변수
		int currentPage = 1;	// 현재페이지
		int totalCount = 0;		// 전체 게시글 수
		int blockCount = 10;	// 한 페이지 게시글 수
		int blockPage = 5;		// 5페이지까지 생성되면 6부터 다시생성
		int lastCount = 0;		// 페이지 마다 끝 게시글
		String pagingHtml;

		if(pagecurrent != null){	// 현재페이지 parameter를 담은 변수가 null이 아니면
			currentPage = Integer.parseInt(pagecurrent);	// 현재페이지에 대입
		}
		else{	
			currentPage = 1;	// 현재페이지가 null이면 1
		}
		String memid = (String)sqlMapClientTemplate.queryForObject("adminBoard.memid", id_search);	// 검색이름을 가지고 회원아이디 존재여부 확인
		if(memid != null) {	// 회원존재
			if(radio.equals("board")){	// board에서 검색할때
				int memnum = (int)sqlMapClientTemplate.queryForObject("adminBoard.memnum", memid);		// 존재하는 회원아이디를 가지고 회원번호 찾기
				List boardlist=sqlMapClientTemplate.queryForList("adminBoard.list", memnum);		// boardlist테이블에서 회원 게시물검색
				int boardcount=(int)sqlMapClientTemplate.queryForObject("adminBoard.listCount", memnum);	// 게시글수
				totalCount = boardlist.size();	// list의 사이즈만큼 totalCount에 대입
				BoardPagingAction page = new BoardPagingAction(currentPage, totalCount, blockCount, blockPage, id_search, radio);
				pagingHtml = page.getPagingHtml().toString();	// 문자로 변환
				lastCount = totalCount;	
				if (page.getEndCount() < totalCount){
					lastCount = page.getEndCount() + 1;
					boardlist = boardlist.subList(page.getStartCount(), lastCount);
				}
				mv.addObject("currentPage", currentPage);
				mv.addObject("pagingHtml", pagingHtml);
				mv.addObject("boardcount", boardcount);
				mv.addObject("memid", memid);
				mv.addObject("radio", radio);
				mv.addObject("boardlist", boardlist);
			}
			else{	// proboard일때
				int memnum = (int)sqlMapClientTemplate.queryForObject("adminBoard.memnum", memid);		// 존재하는 회원아이디를 가지고 회원번호 찾기
				List prolist=sqlMapClientTemplate.queryForList("adminBoard.prolist", memnum);	// proboardlist테이블에서 회원 게시물검색
				int procount=(int)sqlMapClientTemplate.queryForObject("adminBoard.prolistCount", memnum);	// 게시글수
				totalCount = prolist.size();	// list의 사이즈만큼 totalCount에 대입
				BoardPagingAction page = new BoardPagingAction(currentPage, totalCount, blockCount, blockPage, id_search, radio);
				pagingHtml = page.getPagingHtml().toString();	// 문자로 변환
				lastCount = totalCount;	
				if (page.getEndCount() < totalCount){
					lastCount = page.getEndCount() + 1;
					prolist = prolist.subList(page.getStartCount(), lastCount);
				}
				mv.addObject("currentPage", currentPage);
				mv.addObject("pagingHtml", pagingHtml);
				mv.addObject("procount", procount);
				mv.addObject("memid", memid);
				mv.addObject("radio", radio);
				mv.addObject("prolist", prolist);
			}
				mv.setViewName("/admin_board/admin_boardSearch.jsp");
		}
		else{
			mv.setViewName("/admin_board/admin_boardSearchFail.jsp");
		}
		return mv;
	}
	
	@RequestMapping("admin_boardView.nhn")
	public ModelAndView admin_boardView(int b_num, MainboardDTO bdto, int like){
		bdto = (MainboardDTO)sqlMapClientTemplate.queryForObject("adminBoard.all", b_num);		// 게시글번호를 가지고 게시글1개에 대한정보 모두가져오기
		int repleCount = (int)sqlMapClientTemplate.queryForObject("adminBoard.boardRepleCount", b_num);
		mv.addObject("like", like);
		mv.addObject("bdto", bdto);
		mv.addObject("repleCount", repleCount);
		mv.setViewName("/admin_board/admin_boardView.jsp");
		return mv;
	}
	
	@RequestMapping("admin_boardReple.nhn")
	public ModelAndView admin_boardReple(int num, AdminBoardRepleDTO rdto){
		List list = sqlMapClientTemplate.queryForList("adminBoard.boardReple", num);		// 게시글번호를 가지고 게시글에 대한 댓글모든정보 가져오기
		mv.addObject("list", list);
		mv.addObject("num", num);
		mv.setViewName("/admin_board/admin_boardReple.jsp");
		return mv;
	}
	
	@RequestMapping("admin_boardRepleCount.nhn")
	public ModelAndView admin_boardRepleCount(int num){
		int repleCount = (int)sqlMapClientTemplate.queryForObject("adminBoard.boardRepleCount", num);	//게시글번호를 가지고 댓글갯수 가져오기
		mv.addObject("repleCount", repleCount);
		mv.setViewName("/admin_board/admin_boardRepleCount.jsp");
		return mv;
	}
	
	@RequestMapping("admin_proboardView.nhn")
	public ModelAndView admin_proboardView(int pro_num, MainProboardDTO pdto, int like){
		pdto = (MainProboardDTO)sqlMapClientTemplate.queryForObject("adminBoard.proall", pro_num);
		int repleCount = (int)sqlMapClientTemplate.queryForObject("adminBoard.proRepleCount", pro_num);
		mv.addObject("like", like);
		mv.addObject("repleCount", repleCount); 
		mv.addObject("pdto", pdto);
		mv.setViewName("/admin_board/admin_proboardView.jsp");
		return mv;
	}
	
	@RequestMapping("admin_proboardReple.nhn")
	public ModelAndView admin_proboardReple(int num, AdminBoardRepleDTO rdto){
		List list = sqlMapClientTemplate.queryForList("adminBoard.proReple", num);		// 게시글번호를 가지고 게시글에 대한 댓글모든정보 가져오기
		mv.addObject("list", list);
		mv.addObject("num", num);
		mv.setViewName("/admin_board/admin_proboardReple.jsp");
		return mv;
	}
	
	@RequestMapping("admin_proRepleCount.nhn")
	public ModelAndView admin_proRepleCount(int num){
		int repleCount = (int)sqlMapClientTemplate.queryForObject("adminBoard.proRepleCount", num);	//게시글번호를 가지고 댓글갯수 가져오기
		mv.addObject("repleCount", repleCount);
		mv.setViewName("/admin_board/admin_proRepleCount.jsp");
		return mv;
	}
	
	@RequestMapping("admin_boardRepleDelete.nhn")
	public ModelAndView admin_boardRepleDelete(int num, int seq_num){
		Map map = new HashMap();
		map.put("num", num);
		map.put("seq_num", seq_num);
		sqlMapClientTemplate.delete("adminBoard.boardRepleDelete", map);
		mv.addObject("num", num);
		mv.setViewName("/admin_board/admin_boardRepleDelete.jsp");
		return mv;
	}
	
	@RequestMapping("admin_proRepleDelete.nhn")
	public ModelAndView admin_proRepleDelete(int num, int seq_num){
		Map map = new HashMap();
		map.put("num", num);
		map.put("seq_num", seq_num);
		sqlMapClientTemplate.delete("adminBoard.proRepleDelete", map);
		mv.addObject("num", num);
		mv.setViewName("/admin_board/admin_proRepleDelete.jsp");
		return mv;
	}
	
	@RequestMapping("admin_boardDelete.nhn")
	public ModelAndView admin_boardDelete(int num){
		sqlMapClientTemplate.delete("adminBoard.boardDelete", num);
		mv.setViewName("/admin_board/admin_boardDelete.jsp");
		return mv;
	}
	
	@RequestMapping("admin_proboardDelete.nhn")
	public ModelAndView admin_proboardDelete(int num){
		sqlMapClientTemplate.delete("adminBoard.proboardDelete", num);
		mv.setViewName("/admin_board/admin_boardDelete.jsp");
		return mv;
	}
}
