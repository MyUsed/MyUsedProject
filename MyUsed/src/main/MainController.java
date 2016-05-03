package main;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {

	
	
	@RequestMapping("/MyUsed.nhn")
	public ModelAndView main(){
		ModelAndView mv = new ModelAndView();
		
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
	
	for(int i=1;i<=4;i++){
		
	MultipartFile mf = request.getFile("image"+i); // 파일을 받는 MultipartFile 클래스  (원본)
	String orgName = mf.getOriginalFilename(); 
	File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // 업로드
	System.out.println("업로드성공");
	
	System.out.println(orgName);
	System.out.println(copy);
	
	request.setAttribute("orgName", orgName);
	request.setAttribute("copy", copy);
	request.setAttribute("content", content);
	
	try{
		mf.transferTo(copy);	// 업로드 
	}catch(Exception e){
		e.printStackTrace();
	}
	
	}
	

		return "/main/test.jsp";
	}
	

}
