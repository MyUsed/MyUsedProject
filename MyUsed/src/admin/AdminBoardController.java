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
		String pagecurrent = request.getParameter("currentPage");	// ������������ parameter���� ��� ����
		int currentPage = 1;	// ����������
		int totalCount = 0;		// ��ü �Խñ� ��
		int blockCount = 10;	// �� ������ �Խñ� ��
		int blockPage = 5;		// 5���������� �����Ǹ� 6���� �ٽû���
		int lastCount = 0;		// ������ ���� �� �Խñ�
		String pagingHtml;

		if(pagecurrent != null){	// ���������� parameter�� ���� ������ null�� �ƴϸ�
			currentPage = Integer.parseInt(pagecurrent);	// ������������ ����
		}
		else{	
			currentPage = 1;	// ������������ null�̸� 1
		}
		String memid = (String)sqlMapClientTemplate.queryForObject("adminBoard.memid", id_search);	// �˻��̸��� ������ ȸ�����̵� ���翩�� Ȯ��
		if(memid != null) {	// ȸ������
			if(radio.equals("board")){	// board���� �˻��Ҷ�
				int memnum = (int)sqlMapClientTemplate.queryForObject("adminBoard.memnum", memid);		// �����ϴ� ȸ�����̵� ������ ȸ����ȣ ã��
				List boardlist=sqlMapClientTemplate.queryForList("adminBoard.list", memnum);		// boardlist���̺��� ȸ�� �Խù��˻�
				int boardcount=(int)sqlMapClientTemplate.queryForObject("adminBoard.listCount", memnum);	// �Խñۼ�
				totalCount = boardlist.size();	// list�� �����ŭ totalCount�� ����
				BoardPagingAction page = new BoardPagingAction(currentPage, totalCount, blockCount, blockPage, id_search, radio);
				pagingHtml = page.getPagingHtml().toString();	// ���ڷ� ��ȯ
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
			else{	// proboard�϶�
				int memnum = (int)sqlMapClientTemplate.queryForObject("adminBoard.memnum", memid);		// �����ϴ� ȸ�����̵� ������ ȸ����ȣ ã��
				List prolist=sqlMapClientTemplate.queryForList("adminBoard.prolist", memnum);	// proboardlist���̺��� ȸ�� �Խù��˻�
				int procount=(int)sqlMapClientTemplate.queryForObject("adminBoard.prolistCount", memnum);	// �Խñۼ�
				totalCount = prolist.size();	// list�� �����ŭ totalCount�� ����
				BoardPagingAction page = new BoardPagingAction(currentPage, totalCount, blockCount, blockPage, id_search, radio);
				pagingHtml = page.getPagingHtml().toString();	// ���ڷ� ��ȯ
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
		bdto = (MainboardDTO)sqlMapClientTemplate.queryForObject("adminBoard.all", b_num);		// �Խñ۹�ȣ�� ������ �Խñ�1���� �������� ��ΰ�������
		int repleCount = (int)sqlMapClientTemplate.queryForObject("adminBoard.boardRepleCount", b_num);
		mv.addObject("like", like);
		mv.addObject("bdto", bdto);
		mv.addObject("repleCount", repleCount);
		mv.setViewName("/admin_board/admin_boardView.jsp");
		return mv;
	}
	
	@RequestMapping("admin_boardReple.nhn")
	public ModelAndView admin_boardReple(int num, AdminBoardRepleDTO rdto){
		List list = sqlMapClientTemplate.queryForList("adminBoard.boardReple", num);		// �Խñ۹�ȣ�� ������ �Խñۿ� ���� ��۸������ ��������
		mv.addObject("list", list);
		mv.addObject("num", num);
		mv.setViewName("/admin_board/admin_boardReple.jsp");
		return mv;
	}
	
	@RequestMapping("admin_boardRepleCount.nhn")
	public ModelAndView admin_boardRepleCount(int num){
		int repleCount = (int)sqlMapClientTemplate.queryForObject("adminBoard.boardRepleCount", num);	//�Խñ۹�ȣ�� ������ ��۰��� ��������
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
		List list = sqlMapClientTemplate.queryForList("adminBoard.proReple", num);		// �Խñ۹�ȣ�� ������ �Խñۿ� ���� ��۸������ ��������
		mv.addObject("list", list);
		mv.addObject("num", num);
		mv.setViewName("/admin_board/admin_proboardReple.jsp");
		return mv;
	}
	
	@RequestMapping("admin_proRepleCount.nhn")
	public ModelAndView admin_proRepleCount(int num){
		int repleCount = (int)sqlMapClientTemplate.queryForObject("adminBoard.proRepleCount", num);	//�Խñ۹�ȣ�� ������ ��۰��� ��������
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
