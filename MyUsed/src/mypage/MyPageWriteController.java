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
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMap.queryForObject("member.selectDTO", sessionId);

		int num = memDTO.getNum();
		String name = memDTO.getName();

		String content = dto.getContent().replaceAll("\r\n", "<br>"); // textarea���� ���� ó��

		Map map = new HashMap();
		map.put("num", num);
		map.put("content", content);
		map.put("name", name);

		// << num �����޾� insert >>
		if (request.getFile("image1").isEmpty()) {
			sqlMap.insert("main.addContent", map);
			System.out.println("�Ϲ� �Խñ� ��ϼ���");
			sqlMap.insert("main.insertboardlist", map);
			System.out.println("��Ż �Խñ� ��ϼ���");

		} else

			for (int i = 1; i <= 8; i++) {

				MultipartFile mf = request.getFile("image" + i); // ������ �޴�
																	// MultipartFile
																	// Ŭ���� (����)
				String orgName = mf.getOriginalFilename();
				map.put("mem_pic", orgName);
				if (i == 1) {

					sqlMap.insert("main.addContent", map);
					int board_num = (int) sqlMap.queryForObject("main.board_num", num);
					map.put("board_num", board_num);
					sqlMap.insert("main.insertboardlist", map);
				}
				if (!mf.isEmpty()) { // mf�� ������ ������ Ȯ�� ���� ������ ���ε� ����
					sqlMap.insert("main.addPic", map); // ���� ���� db ����

					String url = "E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\";
					File copy = new File(url + orgName); // ���ε�
					System.out.println("���ε强��");

					System.out.println(orgName);
					System.out.println(copy);

					request.setAttribute("orgName" + i, orgName);
					request.setAttribute("copy", copy);

					try {
						mf.transferTo(copy); // ���ε�
					} catch (Exception e) {
						e.printStackTrace();
					}

				}

			}

		// ������ ������ �ö���� ������ִ� ������̺� ( ��ǰ �Ϲ� ��� )

		int boardnums = (int) sqlMap.queryForObject("main.boardnum", null); // ������ ���̵�� num ��������
		System.out.println("�Խñ۹�ȣ" + boardnums);

		sqlMap.insert("create.boardreple", boardnums); // �Խñ� ��� ���̺� ����
		System.out.println("�Խñ۴�� DB ����");
		sqlMap.insert("create.boardreple_seq", boardnums);
		System.out.println("�Խñ۴�� ������ ����");

		request.setAttribute("mem_num", memDTO.getNum());
		
		return "/mypage/write_pro.jsp";
	}
}
