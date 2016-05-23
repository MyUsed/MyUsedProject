package main;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProBoardController {
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
		
	@RequestMapping("/proSubmit.nhn")
	public ModelAndView proboardSubmit(MultipartHttpServletRequest request , MainProboardDTO prodto ){
		
		
		
		ModelAndView mv = new ModelAndView();
		
		System.out.println("=========  probard실행  ========= ");
		
		String content = prodto.getContent().replaceAll("\r\n","<br>"); // textarea에서 띄어쓰기 처리 ;
		
		
		String SendPay = request.getParameter("sendPay"); // 배송료 포함인지 아닌지 받아옴 
		request.setAttribute("SendPay", SendPay);
		
		String categ0 = prodto.getCateg0();
		String categ1 = prodto.getCateg1();
		String categ = categ0 +"/"+ categ1;
		int price = prodto.getPrice();
		
		System.out.println(categ);
		
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		int num = (int)sqlMap.queryForObject("main.num", sessionId); // 접속한 아이디로 num 가져오기 
		String name = (String)sqlMap.queryForObject("main.name", sessionId); // 접속한 아이디로 이름 가져오기 
		
		

		Map promap = new HashMap();
		promap.put("num", num);
		promap.put("name", name);
		promap.put("content", content);
		promap.put("categ", categ);
		promap.put("price", price);
		
		
		if(request.getFile("pimage1").isEmpty()){ // 사진 선택을 하지 않으면 
		sqlMap.insert("main.addProContent", promap); // 상품 일반 DB 등록
		System.out.println("insert상품일반 DB 성공");
		sqlMap.insert("main.insertproboardlist", promap); // 전체 상품 DB 등록
		System.out.println("insert상품전체 DB 성공");
		
	

		
		}else{
		
		
		for(int i=1;i<=8;i++){
		MultipartFile mf = request.getFile("pimage"+i); // 파일을 받는 MultipartFile 클래스  (원본)
		String orgName = mf.getOriginalFilename();
		promap.put("pro_pic",orgName);
		if(i==1){


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
		

		int proboardnum = (int)sqlMap.queryForObject("main.proboardMax", null); // 접속한 아이디로 num 가져오기 
		System.out.println("게시글번호"+proboardnum);
		
		sqlMap.insert("create.proboardreple",proboardnum); // 게시글 댓글 테이블 생성 
		System.out.println("pro게시글댓글 DB 생성");
		sqlMap.insert("create.proboardreple_seq",proboardnum);
		System.out.println("pro게시글댓글 시퀀스 생성");

		mv.setViewName("/MyUsed.nhn");
		return mv;
		
	}

}
