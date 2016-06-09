package mypage;

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

import main.MainProboardDTO;
import member.MemberDTO;

@Controller
public class MyPageWriteProController {

	@Autowired
	private SqlMapClientTemplate sqlMap;

	@RequestMapping("/proWrite.nhn")
	public String proWrite(MultipartHttpServletRequest request, MainProboardDTO prodto){
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);

		String content = prodto.getContent().replaceAll("\r\n", "<br>"); // textarea에서 띄어쓰기 처리

		String SendPay = request.getParameter("sendPay"); // 배송료 포함인지 아닌지 받아옴
		request.setAttribute("SendPay", SendPay);

		String categ0 = prodto.getCateg0();
		String categ1 = prodto.getCateg1();
		String categ = categ0 + "/" + categ1;
		int price = prodto.getPrice();

		System.out.println(categ);

		Map promap = new HashMap();
		promap.put("num", memDTO.getNum());
		promap.put("name", memDTO.getName());
		promap.put("content", content);
		promap.put("categ", categ);
		promap.put("price", price);
		promap.put("sendpay", SendPay);

		if (request.getFile("pimage1").isEmpty()) { // 사진 선택을 하지 않으면
			sqlMap.insert("main.addProContent", promap); // 상품 일반 DB 등록
			System.out.println("insert상품일반 DB 성공");
			sqlMap.insert("main.insertproboardlist", promap); // 전체 상품 DB 등록
			System.out.println("insert상품전체 DB 성공");

		} else {
			sqlMap.insert("main.addProContent", promap); // 상품 일반 DB 등록
			System.out.println("insert상품일반 DB 성공");

			for (int i = 1; i <= 8; i++) {
				MultipartFile mf = request.getFile("pimage" + i); // 파일을 받는 MultipartFile 클래스 (원본)
				String orgName = mf.getOriginalFilename();
				promap.put("pro_pic", orgName);
				if (i == 1) {

					int proboard_num = (int) sqlMap.queryForObject("main.proboard_num", memDTO.getNum());
					promap.put("proboard_num", proboard_num);
					sqlMap.insert("main.insertproboardlist", promap); // 전체 상품  DB 등록
				}
				if (!mf.isEmpty()) {
					sqlMap.insert("main.addProPic", promap);
					String upload = "E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\";
					File copy = new File(upload + orgName); // 업로드
					System.out.println("업로드성공");

					System.out.println(orgName);
					System.out.println(copy);

					request.setAttribute("orgName" + i, orgName);
					request.setAttribute("copy", copy);

					try {
						mf.transferTo(copy); // 업로드
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

			}

		}

		int proboardnum = (int) sqlMap.queryForObject("main.proboardMax", null); // 가장 최근올린 게시글의 번호(방금 올린것)
		System.out.println("게시글번호" + proboardnum);

		sqlMap.insert("create.proboardreple", proboardnum); // 게시글 댓글 테이블 생성
		System.out.println("pro게시글댓글 DB 생성");
		sqlMap.insert("create.proboardreple_seq", proboardnum);
		System.out.println("pro게시글댓글 시퀀스 생성");
		

		request.setAttribute("mem_num", memDTO.getNum());
		
		return "/mypage/prowrite_pro.jsp";
	}
}
