package main;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

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
	
	@RequestMapping("/MyUsedLogin.nhn")
	public ModelAndView login(){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/member/MyUsedLogin.jsp");
		return mv;
	}
	
	@RequestMapping("/mainTest.nhn")
	public String mainSubmit(MultipartHttpServletRequest request , String content){
	
	for(int i=1;i<=8;i++){

	MultipartFile mf = request.getFile("image"+i); // ������ �޴� MultipartFile Ŭ����  (����)
	if(!mf.isEmpty()){
	String orgName = mf.getOriginalFilename(); 
	File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // ���ε�
	System.out.println("���ε强��");
	
	System.out.println(orgName);
	System.out.println(copy);
	
	request.setAttribute("orgName", orgName);
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
