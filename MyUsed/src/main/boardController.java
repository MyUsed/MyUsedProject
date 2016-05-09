package main;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class boardController {
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	@RequestMapping("/mainTest.nhn")
	public String mainSubmit(MultipartHttpServletRequest request , MainboardDTO dto){
	
		request.setAttribute("sendPay", dto.getSendPay());
		request.setAttribute("price", dto.getPrice());
		request.setAttribute("categ", dto.getCateg());
		String content = dto.getContent().replaceAll("\r\n","<br>"); // textarea에서 띄어쓰기 처리 ; 
		request.setAttribute("content", content);	
		
		 // << 접속한 아이디 의 num 가져오기 >> 
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		System.out.println("세션ID = "+sessionId);
		int num = (int)sqlMap.queryForObject("main.num", sessionId);
		String name = (String)sqlMap.queryForObject("main.name", sessionId);
		System.out.println("접속자의 num = "+num);
		System.out.println("접속자의 name = "+name);
		
		
		
		Map map = new HashMap();
		map.put("num", num);
		map.put("content",dto.getContent());
		map.put("name", name);
		
		
		// <<  num 값을받아  insert >>
		if(request.getFile("image1").isEmpty()){
			sqlMap.insert("main.addContent", map);
			System.out.println("일반 게시글 등록성공");
			sqlMap.insert("main.addTotalContent", map);
			System.out.println("토탈 게시글 등록성공");
		}

	for(int i=1;i<=8;i++){

	MultipartFile mf = request.getFile("image"+i); // 파일을 받는 MultipartFile 클래스  (원본)
	if(!mf.isEmpty()){		// mf에 파일이 담겼는지 확인 한후 있으면 업로드 수행 
	String orgName = mf.getOriginalFilename(); 
	File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // 업로드
	System.out.println("업로드성공");
	
	System.out.println(orgName);
	System.out.println(copy);
	
	
	request.setAttribute("orgName"+i, orgName);
	request.setAttribute("copy", copy);
	
	
	try{
		mf.transferTo(copy);	// 업로드 
	}catch(Exception e){
		e.printStackTrace();
	}
	
	}

	}
	

		return "/main/test.jsp";
	}

}
