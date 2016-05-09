package main;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import member.FriendCategDTO;
import member.MemberDTO;

@Controller
public class MainController {

	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	
	@RequestMapping("/MyUsed.nhn")
	public ModelAndView main(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		
		
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		String name = (String) sqlMap.queryForObject("member.selectName", sessionId);
		request.setAttribute("name", name);
		
		mv.setViewName("/main/MyUsed.jsp");
		return mv;
	}	
	
	
	@RequestMapping("/MyUsedSearchMember.nhn")
	public ModelAndView MyUsedSearchMember(HttpServletRequest request, String member){
		ModelAndView mv = new ModelAndView();
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);
		
		System.out.println(memDTO.getName()+memDTO.getNum());
		
		/** ȸ���˻� -> ���������� ������ ��� �˻� �켱���� ���ϴ°� �����غ��� */
		System.out.println(member); //�˻��� �̸�
		List searchList = new ArrayList();
		searchList = sqlMap.queryForList("member.searchMember", member);
		
		FriendCategDTO fricagDTO = new FriendCategDTO();
		List friendCateg = new ArrayList();
		friendCateg = sqlMap.queryForList("friend.friendCateg", null);
		

		
		request.setAttribute("name", memDTO.getName());
		request.setAttribute("num", memDTO.getNum());
		request.setAttribute("member", member);
		request.setAttribute("searchList", searchList);
		request.setAttribute("friendCateg", friendCateg);
		
		mv.setViewName("/main/MyUsedSearchMember.jsp");
		return mv;
	}	
	
	@RequestMapping("/MyUsedLogin.nhn")
	public ModelAndView login(){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/member/MyUsedLogin.jsp");
		return mv;
	}
	
	@RequestMapping("/mainTest.nhn")
	public String mainSubmit(MultipartHttpServletRequest request , String content , String categ , String price , String sendPay){
	
	for(int i=1;i<=8;i++){

	MultipartFile mf = request.getFile("image"+i); // ������ �޴� MultipartFile Ŭ����  (����)
	if(!mf.isEmpty()){		// mf�� ������ ������ Ȯ�� ���� ������ ���ε� ���� 
	String orgName = mf.getOriginalFilename(); 
	File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // ���ε�
	System.out.println("���ε强��");
	
	System.out.println(orgName);
	System.out.println(copy);
	
	request.setAttribute("sendPay", sendPay);
	request.setAttribute("price", price);
	request.setAttribute("categ", categ);
	request.setAttribute("orgName"+i, orgName);
	request.setAttribute("copy", copy);
	request.setAttribute("content", content);
	
	try{
		mf.transferTo(copy);	// ���ε� 
	}catch(Exception e){
		e.printStackTrace();
	}
	
	}

	}
	

		return "/main/test.jsp";
	}
	

}
