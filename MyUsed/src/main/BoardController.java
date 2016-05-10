package main;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;



@Controller
public class BoardController {

	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
		
	
	
	@RequestMapping("/mainSubmit.nhn")
	public String mainSubmit(MultipartHttpServletRequest request , MainboardDTO dto){
	
		
		
		
		
		 // << 접속한 아이디 의 num 가져오기 >> 
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		System.out.println("세션ID = "+sessionId);
		int num = (int)sqlMap.queryForObject("main.num", sessionId); // 접속한 아이디로 num 가져오기 
		String name = (String)sqlMap.queryForObject("main.name", sessionId); // 접속한 아이디로 이름 가져오기 
		System.out.println("접속자의 num = "+num);
		System.out.println("접속자의 name = "+name);
		String content = dto.getContent().replaceAll("\r\n","<br>"); // textarea에서 띄어쓰기 처리 ; 
		
		
		
		
		Map map = new HashMap();
		map.put("num", num);
		map.put("content",content);
		map.put("name", name);
		
		
		
		// <<  num 값을받아  insert >>
		if(request.getFile("image1").isEmpty()){	
			sqlMap.insert("main.addContent", map);
			System.out.println("일반 게시글 등록성공");
			sqlMap.insert("main.addTotalContent", map);
			System.out.println("토탈 게시글 등록성공");	
		}
			//sqlMap.insert("main.addContent", map); // 내용 insert
			//sqlMap.insert("main.addTotalContent", map); // 토탈 insert	
			
			int board_num = (int)sqlMap.queryForObject("main.board_num", num); // 게시글 번호 가져오기
			map.put("board_num", board_num);
	
	for(int i=1;i<=8;i++){

	MultipartFile mf = request.getFile("image"+i); // 파일을 받는 MultipartFile 클래스  (원본)
	String orgName = mf.getOriginalFilename(); 
	if(i == 1){
		orgName = "M_"+mf.getOriginalFilename(); 
	}
		
	map.put("mem_pic",orgName);
	
	if(!mf.isEmpty()){		// mf에 파일이 담겼는지 확인 한후 있으면 업로드 수행 
		sqlMap.insert("main.addPic", map); // 개인 사진 db 삽입
		sqlMap.insert("main.addTotalPic", map); // 전체 사진 db 삽입
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
	

		return "MyUsed.nhn";
	}

}
