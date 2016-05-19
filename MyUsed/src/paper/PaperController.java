package paper;

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
public class PaperController {
	@Autowired
	private SqlMapClientTemplate SqlMapClientTemplate;

	@RequestMapping("paperMain.nhn")	// 쪽지 보여주는 메인
	public ModelAndView paperMain(int mynum, HttpServletRequest request){
		
		String pagecurrent = request.getParameter("currentPage");	// 현재페이지의 parameter값을 담는 변수
		int currentPage = 1;	// 현재페이지
		int totalCount = 0;		// 전체 게시글 수
		int blockCount = 10;	// 한 페이지 게시글 수
		int blockPage = 5;		// 5페이지까지 생성되면 6부터 다시생 성
		int lastCount = 0;		// 페이지 마다 끝 게시글
		String pagingHtml;
		
		if(pagecurrent != null){	// 현재페이지 parameter를 담은 변수가 null이 아니면
			currentPage = Integer.parseInt(pagecurrent);	// 현재페이지에 대입
		}
		else{	
			currentPage = 1;	// 현재페이지가 null이면 1
		}
		
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("mynum", mynum);	// 회원 고유 번호
		List list = SqlMapClientTemplate.queryForList("paper.all", map); // 쪽지테이블 내용 다가져오기

		totalCount = list.size();	// list의 사이즈만큼 totalCount에 대입
		pagingAction page = new pagingAction(currentPage, totalCount, blockCount, blockPage, mynum);
		pagingHtml = page.getPagingHtml().toString();	// 문자로 변환
		lastCount = totalCount;	
		
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;
		
		 list = list.subList(page.getStartCount(), lastCount);
		 
		
		int paperCount = (int)SqlMapClientTemplate.queryForObject("paper.paperCount", map);	// 글 읽음 여부. state값 가져오기
		mv.addObject("list", list);
		mv.addObject("mynum", mynum);
		mv.addObject("pagingHtml", pagingHtml);
		mv.addObject("paperCount", paperCount);
		mv.setViewName("/paper/paperMain.jsp");
		return mv;
	}
	
	@RequestMapping("paperForm.nhn")	// 쪽지 쓰는 폼
	public ModelAndView paperForm(int mynum, String name){
		ModelAndView mv = new ModelAndView();
		mv.addObject("mynum", mynum);
		mv.addObject("name", name);
		mv.setViewName("/paper/paperForm.jsp");
		return mv;
	}
	
	@RequestMapping("paperSend.nhn")	// 쪽지 보냈을 때
	public ModelAndView paperSend(PaperDTO dto, int mynum, String r_content, String r_name, HttpSession session){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		String sessionId = (String)session.getAttribute("memId");
		map.put("mynum", mynum);	// 쪽지 보낸 회원 고유 번호
		map.put("r_id", r_name);	// 쪽지 받을 회원 id
		int memNum = (int)SqlMapClientTemplate.queryForObject("paper.memberNum", map);	//DB에 insert될 회원 고유 번호 찾기
		map.put("memNum", memNum);	// 쪽지 받을 회원 고유 번호
		map.put("s_content", r_content);	// 받을 쪽지 내용
		map.put("s_name", sessionId);	// 보낸 사람 아이디
		SqlMapClientTemplate.insert("paper.send", map);	// 쪽지 받을 회원 DB에 insert
		
		mv.addObject("mynum", mynum);
		mv.setViewName("/paper/paperSend.jsp");
		return mv;
	}
	
	@RequestMapping("paperDelete.nhn")	// 전체 및 낱개 쪽지 삭제
	public ModelAndView paperDelete(int check[], int mynum){
		Map map = new HashMap();
		for (int i = 0; i < check.length; i++) {	//check된 개수 만큼 동작
			map.put("m_no", check[i]);	// 글번호(check[i])를  m_no로 map에 넣어줌
			map.put("mynum", mynum);
			SqlMapClientTemplate.delete("paper.delete", map);	// 쪽지 삭제
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("mynum", mynum);
		mv.setViewName("/paper/paperDelete.jsp");
		return mv;
	}
	
	@RequestMapping("paperView.nhn")	// 쪽지 내용 보기
	public ModelAndView paperView(PaperDTO dto, int m_no, HttpSession session){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		String sessionId = (String)session.getAttribute("memId");
		map.put("r_id", sessionId);	// sessionId
		
		int mynum = (int)SqlMapClientTemplate.queryForObject("paper.memberNum", map);	// 회원 고유 번호 가져오기
		map.put("mynum", mynum);	// 회원 고유 번호
		map.put("m_no", m_no);		// 쪽지 글 번호
		
		dto = (PaperDTO)SqlMapClientTemplate.queryForObject("paper.memAll", map);	// 쪽지 내용 1개 가져오기
		int stateCount = (int)SqlMapClientTemplate.queryForObject("paper.stateCount", map);	// 글 읽음 여부. state값 가져오기
		
		if(stateCount == 1){	// 글을 읽은상태(1)이면 0으로 바꿔줌
			SqlMapClientTemplate.update("paper.state", map);	// 글을 읽으면 state를 0으로 바꿔줌.
		}
		
		String memname = dto.getS_name();	// memberlist에서 이름을 꺼내기위해 사용할 변수
		String name = (String)SqlMapClientTemplate.queryForObject("paper.name", memname);	// memberlist에서 사용자 이름 가져오기
		
		mv.addObject("dto", dto);
		mv.addObject("mynum", mynum);
		mv.addObject("m_no", m_no);
		mv.addObject("name", name);
		mv.setViewName("/paper/paperView.jsp");
		return mv;
		
	}
	
	@RequestMapping("paperViewDelete.nhn")	// 뷰에서 쪽지 삭제
	public ModelAndView paperViewDelete(int mynum, int m_no){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("mynum", mynum);
		map.put("m_no", m_no);
		SqlMapClientTemplate.delete("paper.delete", map);
		mv.addObject("mynum", mynum);
		mv.setViewName("/paper/paperDelete.jsp");
		return mv;
	}
	
	@RequestMapping("paperFriendList.nhn")	// 친구목록
	public ModelAndView paperFriendList(int mynum){
		ModelAndView mv = new ModelAndView();
		Map map = new HashMap();
		map.put("mynum", mynum);
		List list = SqlMapClientTemplate.queryForList("paper.FriendId", map);
		mv.addObject("list", list);
		mv.setViewName("/paper/paperFriendList.jsp");
		return mv;
		
	}
}
