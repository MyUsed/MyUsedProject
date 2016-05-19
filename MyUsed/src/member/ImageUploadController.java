package member;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class ImageUploadController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	@RequestMapping("/MyUsedUploadPro.nhn")
	public String MyUsedUploadPro(MultipartHttpServletRequest request, int mem_num){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		/** ���Ǿ��̵��� mem_num���� �̹��� ���ε� */
		MultipartFile mf = request.getFile("profilepic"); // ������ �޴� MultipartFile Ŭ����  (����)
		String orgName = mf.getOriginalFilename();
		System.out.println(orgName);
		
		Map profileMap = new HashMap();
		profileMap.put("mem_num", memDTO.getNum());
		profileMap.put("profile_pic", orgName);
		
		sqlMapClientTemplate.insert("profile.insertProPic", profileMap);
		File copy = new File("C:\\Users\\user1\\Documents\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\profile\\"+ orgName); // ���ε�
		//File copy = new File("D:\\kh\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\profile\\"+ orgName); // ���ε�
		System.out.println("insert Profile Image");
		System.out.println(copy);
		try {
			mf.transferTo(copy);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		request.setAttribute("mem_num", mem_num);	//���� ���̵��� mem_num�ƴ�
		
		return "/member/MyUsedUploadPro.jsp";
	}

	
	@RequestMapping("/MyUsedCoverUploadPro.nhn")
	public String MyUsedCoverUploadPro(MultipartHttpServletRequest request, int mem_num){
		/** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		/** ���Ǿ��̵��� mem_num���� �̹��� ���ε� */
		MultipartFile mf = request.getFile("coverpic"); // ������ �޴� MultipartFile Ŭ����  (����)
		String orgName = mf.getOriginalFilename();
		System.out.println(orgName);
		
		Map coverMap = new HashMap();
		coverMap.put("mem_num", memDTO.getNum());
		coverMap.put("cover_pic", orgName);
		
		sqlMapClientTemplate.insert("profile.insertCoverPic", coverMap);
		File copy = new File("C:\\Users\\user1\\Documents\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\cover\\"+ orgName); // ���ε�
		//File copy = new File("D:\\kh\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\cover\\"+ orgName); // ���ε�/(��ž)
		System.out.println("insert Cover Image");
		System.out.println(copy);
		try {
			mf.transferTo(copy);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		request.setAttribute("mem_num", mem_num);	//���� ���̵��� mem_num�ƴ�
		
		return "/member/MyUsedUploadPro.jsp";
	}
}
