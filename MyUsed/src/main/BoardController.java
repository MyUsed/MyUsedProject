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
	public String mainSubmit(MultipartHttpServletRequest request , MainboardDTO dto ,MainProboardDTO prodto , String sendPay ,String deposit){
	
		
		System.out.println("--------- mainSubmit 실행 ---------");
		 // << 접속한 아이디 의 num 가져오기 >> 
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		System.out.println("세션ID = "+sessionId);
		int num = (int)sqlMap.queryForObject("main.num", sessionId); // 접속한 아이디로 num 가져오기 
		String name = (String)sqlMap.queryForObject("main.name", sessionId); // 접속한 아이디로 이름 가져오기 
		System.out.println("접속자의 num = "+num);
		System.out.println("접속자의 name = "+name);
		
		
		String Submit = request.getParameter("deposit");
		System.out.println("현재 submit 상태 = "+Submit);
		if(Submit.equals("update")){   // submit이 update일때 실행
		String content = dto.getContent().replaceAll("\r\n","<br>"); // textarea에서 띄어쓰기 처리 ; 
		Map map = new HashMap();
		map.put("num", num);
		map.put("content",content);
		map.put("name", name);
		
		
		request.setAttribute("view", "view");	// div1이 보이게
		request.setAttribute("view2", "none"); // div2가 안보이게 
		request.setAttribute("checked", "checked");

		
		// <<  num 값을받아  insert >>
		if(request.getFile("image1").isEmpty()){	
			sqlMap.insert("main.addContent", map);
			System.out.println("일반 게시글 등록성공");
			sqlMap.insert("main.insertboardlist", map);
			System.out.println("토탈 게시글 등록성공");	

			int boardnum = (int)sqlMap.queryForObject("main.boardnum", null); // 접속한 아이디로 num 가져오기 
			System.out.println("게시글번호"+boardnum);
			
			sqlMap.insert("create.boardreple",boardnum); // 게시글 댓글 테이블 생성 
			System.out.println("게시글댓글 DB 생성");
		}else
			
			
		
			
	for(int i=1;i<=8;i++){

	MultipartFile mf = request.getFile("image"+i); // 파일을 받는 MultipartFile 클래스  (원본)
	String orgName = mf.getOriginalFilename(); 
	map.put("mem_pic",orgName);
	if(i==1){
	
	sqlMap.insert("main.addContent", map);
	int board_num = (int)sqlMap.queryForObject("main.board_num", num);
	map.put("board_num", board_num);
	sqlMap.insert("main.insertboardlist", map);
	}
	if(!mf.isEmpty()){		// mf에 파일이 담겼는지 확인 한후 있으면 업로드 수행 
		sqlMap.insert("main.addPic", map); // 개인 사진 db 삽입
		
	File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // 업로드
	System.out.println("업로드성공");
	
	System.out.println(orgName);
	System.out.println(copy);
	System.out.println("성공성공성공성공성공성공성공성공");
	
	request.setAttribute("orgName"+i, orgName);
	request.setAttribute("copy", copy);
	
	
	try{
		mf.transferTo(copy);	// 업로드 
	}catch(Exception e){e.printStackTrace();}
	
	}

	}
		
		}else if(Submit.equals("product")){ // product 가 submit 될때 실행 ;;
			
			
			request.setAttribute("view", "none");  // div1 이 안보이게 
			request.setAttribute("view2", "view"); // div2 가 보이게 
			request.setAttribute("checked1", "checked");
			
			System.out.println("product 실행");
			String content = prodto.getContent().replaceAll("\r\n","<br>"); // textarea에서 띄어쓰기 처리 ;
			
			
			String SendPay = request.getParameter("sendPay"); // 배송료 포함인지 아닌지 받아옴 
			request.setAttribute("SendPay", SendPay);
			
			String categ0 = prodto.getCateg0();
			String categ1 = prodto.getCateg1();
			String categ = categ0 +"/"+ categ1;
			int price = prodto.getPrice();
			
			System.out.println(categ);
			
			Map promap = new HashMap();
			promap.put("num", num);
			promap.put("name", name);
			promap.put("content", content);
			promap.put("categ", categ);
			promap.put("price", price);
			
			
			if(request.getFile("pimage1").isEmpty()){ // 사진 선택을 하지 않으면 
			sqlMap.insert("main.addProContent", promap); // 상품 일반 DB 등록
			sqlMap.insert("main.insertproboardlist", promap); // 전체 상품 DB 등록
			}else{
			
			
			for(int i=1;i<=8;i++){
			MultipartFile mf = request.getFile("pimage"+i); // 파일을 받는 MultipartFile 클래스  (원본)
			String orgName = mf.getOriginalFilename();
			promap.put("pro_pic",orgName);
			if(i==1){
				sqlMap.insert("main.addProContent", promap); // 상품 일반 DB 등록
				int proboard_num = (int)sqlMap.queryForObject("main.proboard_num", num);
				promap.put("proboard_num", proboard_num);
				sqlMap.insert("main.insertproboardlist", promap); // 전체 상품 DB 등록
			}
			if(!mf.isEmpty()){
				sqlMap.insert("main.addProPic", promap);
				
				File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // 업로드
				System.out.println("업로드성공");
				
				System.out.println(orgName);
				System.out.println(copy);
				

				request.setAttribute("orgName"+i, orgName);
				request.setAttribute("copy", copy);
				

				try{
					mf.transferTo(copy);	// 업로드 
				}catch(Exception e){e.printStackTrace();}
			}
			
			
			}
			
			}
			
		}
		
		// 파일이 여러개 올라오면 만들어주는 댓글테이블 ( 상품 일반 모두 )
	
		int boardnums = (int)sqlMap.queryForObject("main.boardnum", null); // 접속한 아이디로 num 가져오기 
		System.out.println("게시글번호"+boardnums);
		
		sqlMap.insert("create.boardreple",boardnums); // 게시글 댓글 테이블 생성 
		System.out.println("게시글댓글 DB 생성");

		return "MyUsed.nhn";
	}

}
