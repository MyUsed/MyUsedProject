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
import main.MainboardDTO;
import member.MemberDTO;

@Controller
public class MyPageWriteController {

	@Autowired
	private SqlMapClientTemplate sqlMap;

	@RequestMapping("/Write.nhn")
	public String Write(MultipartHttpServletRequest request, MainboardDTO dto){
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);

		int num = memDTO.getNum();
		String name = memDTO.getName();

		String content = dto.getContent().replaceAll("\r\n", "<br>"); // textarea에서 띄어쓰기 처리

		Map map = new HashMap();
		map.put("num", num);
		map.put("content", content);
		map.put("name", name);

		// << num 값을받아 insert >>
		if (request.getFile("image1").isEmpty()) {
			sqlMap.insert("main.addContent", map);
			System.out.println("일반 게시글 등록성공");
			sqlMap.insert("main.insertboardlist", map);
			System.out.println("토탈 게시글 등록성공");

		} else

			for (int i = 1; i <= 8; i++) {

				MultipartFile mf = request.getFile("image" + i); // 파일을 받는
																	// MultipartFile
																	// 클래스 (원본)
				String orgName = mf.getOriginalFilename();
				map.put("mem_pic", orgName);
				if (i == 1) {

					sqlMap.insert("main.addContent", map);
					int board_num = (int) sqlMap.queryForObject("main.board_num", num);
					map.put("board_num", board_num);
					sqlMap.insert("main.insertboardlist", map);
				}
				if (!mf.isEmpty()) { // mf에 파일이 담겼는지 확인 한후 있으면 업로드 수행
					sqlMap.insert("main.addPic", map); // 개인 사진 db 삽입

					String url = "E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\";
					File copy = new File(url + orgName); // 업로드
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

		// 파일이 여러개 올라오면 만들어주는 댓글테이블 ( 상품 일반 모두 )

		int boardnums = (int) sqlMap.queryForObject("main.boardnum", null); // 접속한 아이디로 num 가져오기
		System.out.println("게시글번호" + boardnums);

		sqlMap.insert("create.boardreple", boardnums); // 게시글 댓글 테이블 생성
		System.out.println("게시글댓글 DB 생성");
		sqlMap.insert("create.boardreple_seq", boardnums);
		System.out.println("게시글댓글 시퀀스 생성");

		request.setAttribute("mem_num", memDTO.getNum());
		
		return "/mypage/write_pro.jsp";
	}
}
