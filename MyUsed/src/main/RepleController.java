package main;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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

import friend.FriendDTO;
import member.ProfilePicDTO;

@Controller
public class RepleController {
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	private ProfilePicDTO boardproDTO = new ProfilePicDTO();
	private List<RepleDTO> replelist = new ArrayList<RepleDTO>();;	
	private List<MainpicDTO> piclist = new ArrayList<MainpicDTO>();;
	
	@RequestMapping("/reple.nhn")
	public ModelAndView reple(int num,HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		System.out.println(num);
		
		Timestamp reg = (Timestamp)sqlMap.queryForObject("reple.boardreg",num); // �Խñ� ��ϵ� �ð� ��������
		String name = (String)sqlMap.queryForObject("reple.boardname",num); // boardlist���� �۾��� �̸� ��������
		int mem_num = (int)sqlMap.queryForObject("reple.mem_num",num); // ��۴ٴ� ����� ȸ����ȣ ��������
		String content =(String)sqlMap.queryForObject("reple.content",num); // �Խñ��� ���� �������� 
		String board_pic = (String)sqlMap.queryForObject("reple.pic",num); // �Խñ��� ���� ��������
		
		replelist = sqlMap.queryForList("reple.select", num); // ��� �������� 
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy�� MM�� dd�� aa hh�� mm��"); // �ð��� �ѷ��ֱ����� ����
		String time = sdf.format(reg.getTime());
		
		// ������ ���� �������� �۾�
		
		
		String mem_pic = (String)sqlMap.queryForObject("reple.mem_pic",num); // ���λ����� �̸��� ��������
		
		Map remap = new HashMap();
		
		
		remap.put("mem_num", mem_num);
		remap.put("mem_pic", mem_pic);
		if(mem_pic != null){
		int pic_num = (int)sqlMap.queryForObject("reple.pic_num",remap); // ������ num�� ��������
		remap.put("pic_num", pic_num);
		}
		
		piclist = sqlMap.queryForList("reple.all_pic",remap);
		
		
	    HttpSession session = request.getSession();
	    String sessionId = (String) session.getAttribute("memId");
	    int session_num = (int)sqlMap.queryForObject("main.num",sessionId); // ȸ����ȣ ��������
	    
	    boardproDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", remap); // ������ ������ ������
	    
	    Map picmap = new HashMap();
		picmap.put("mem_num", session_num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // ������ ������ ������

		
		// ��� ������ ������
		
		int count = (int)sqlMap.queryForObject("reple.count",num);
		
		mv.addObject("count",count);
		mv.addObject("session_num",session_num);
		mv.addObject("boardproDTO",boardproDTO);
		mv.addObject("proDTO",proDTO);
		mv.addObject("piclist",piclist);
		mv.addObject("replelist",replelist);
		mv.addObject("name",name);
		mv.addObject("content",content);
		mv.addObject("num",num);
		mv.addObject("time",time);
		mv.addObject("mem_num",mem_num);
		mv.addObject("board_pic",board_pic);
		
		mv.setViewName("/main/reple.jsp");
		return mv;
	}
	
	@RequestMapping("/replesubmit.nhn")
	public ModelAndView replesubmit(HttpServletRequest request , String reple , int boardnum , String content){
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		int mem_num = (int)sqlMap.queryForObject("main.num",sessionId); // ����ۼ��� ȸ���� ��ȣ ��������
		String re_name = (String)sqlMap.queryForObject("main.name",sessionId); // ����ۼ��� ȸ���� �̸� 
		
		System.out.println("����ID = "+sessionId);
		System.out.println("��۳��� = "+reple);
		System.out.println("��� �ۼ���ȸ����ȣ = "+mem_num);
		System.out.println("��� �ۼ���ȸ���̸� = "+re_name);
		
		System.out.println("�Խñ۹�ȣ ="+boardnum);
		
		Map map = new HashMap();
		map.put("boardnum", boardnum); 
		map.put("mem_num", mem_num);
		map.put("content", reple);
		map.put("name", re_name);
		
		sqlMap.insert("reple.insert",map);   // ��� ���� 
		sqlMap.update("reple.update",boardnum); // ��ü boardlist�� reple �߰�;
		
		

		/** @�±� �޸� �� ã�Ƽ� notice ���̺� ���� */
		String repleArray[] = reple.split(" ");	// ��� ������ ������ �������� �ڸ���.
		
		for(int i = 0 ; i < repleArray.length ; i++){
			if(repleArray[i].indexOf("@") == 0){	// �ڸ� �迭�� ��� �� ù���ڰ� @�� ���۵Ǵ� ��Ҹ� ã�´�.
				String name = repleArray[i].substring(1, repleArray[i].length());	// @�� �ڸ���.
				
				/** ����� �ۼ��� ����� ģ�� ����ؼ� ��ġ�ϴ� �̸��� ã�� �ش� ������ DTO�� ���� */
				Map frimap = new HashMap();
				frimap.put("num", mem_num);		// ��� �ۼ��� ȸ���� num
				frimap.put("name", name);	// �±��Ϸ��� ģ���� �̸�
				
				FriendDTO tegFriDTO = new FriendDTO();
				tegFriDTO = (FriendDTO) sqlMap.queryForObject("friend.searchfriName", frimap);
				
				Map notice = new HashMap();
				notice.put("num", tegFriDTO.getMem_num());		// �±��Ϸ��� ģ���� �ѹ�
				notice.put("board_num", boardnum);				// �±׵� �� ��ȣ
				notice.put("call_memnum", mem_num);				// �±��� ��� ��ȣ
				notice.put("call_name", re_name);				// �±��� ��� �̸�
				notice.put("categ", "board");					// �˸� �з�(board)
				
				sqlMap.insert("friend.insertTegNotice", notice);	// ���� �˸� ���̺� insert�Ѵ�.
				
			}
		}
		
		
		
		
		mv.setViewName("reple.nhn?num="+boardnum);
		return mv;
	}
	
	@RequestMapping("proreplesubmit.nhn")
	public ModelAndView proreplesubmit(HttpServletRequest request , String reple , int proboardnum){
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		int mem_num = (int)sqlMap.queryForObject("main.num",sessionId); // ����ۼ��� ȸ���� ��ȣ ��������
		String re_name = (String)sqlMap.queryForObject("main.name",sessionId); // ����ۼ��� ȸ���� �̸� 
		

		System.out.println("����ID = "+sessionId);
		System.out.println("��۳��� = "+reple);
		System.out.println("��� �ۼ���ȸ����ȣ = "+mem_num);
		System.out.println("��� �ۼ���ȸ���̸� = "+re_name);
		
		Map promap = new HashMap();
		promap.put("proboardnum", proboardnum); 
		promap.put("mem_num", mem_num);
		promap.put("content", reple);
		promap.put("name", re_name);
		
		
		sqlMap.insert("reple.proinsert",promap);   // ��� ���� 
		sqlMap.update("reple.proupdate",proboardnum); // ��ü boardlist�� reple �߰�;
		
		
		
		
		mv.setViewName("ProductDetailView.nhn?num="+proboardnum);
		return mv;
	}
	
	
	


}
