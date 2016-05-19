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
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		/** 세션아이디의 mem_num으로 이미지 업로드 */
		MultipartFile mf = request.getFile("profilepic"); // 파일을 받는 MultipartFile 클래스  (원본)
		String orgName = mf.getOriginalFilename();
		System.out.println(orgName);
		
		Map profileMap = new HashMap();
		profileMap.put("mem_num", memDTO.getNum());
		profileMap.put("profile_pic", orgName);
		
		sqlMapClientTemplate.insert("profile.insertProPic", profileMap);
		File copy = new File("C:\\Users\\user1\\Documents\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\profile\\"+ orgName); // 업로드
		//File copy = new File("D:\\kh\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\profile\\"+ orgName); // 업로드
		System.out.println("insert Profile Image");
		System.out.println(copy);
		try {
			mf.transferTo(copy);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		request.setAttribute("mem_num", mem_num);	//세션 아이디의 mem_num아님
		
		return "/member/MyUsedUploadPro.jsp";
	}

	
	@RequestMapping("/MyUsedCoverUploadPro.nhn")
	public String MyUsedCoverUploadPro(MultipartHttpServletRequest request, int mem_num){
		/** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		
		/** 세션아이디의 mem_num으로 이미지 업로드 */
		MultipartFile mf = request.getFile("coverpic"); // 파일을 받는 MultipartFile 클래스  (원본)
		String orgName = mf.getOriginalFilename();
		System.out.println(orgName);
		
		Map coverMap = new HashMap();
		coverMap.put("mem_num", memDTO.getNum());
		coverMap.put("cover_pic", orgName);
		
		sqlMapClientTemplate.insert("profile.insertCoverPic", coverMap);
		File copy = new File("C:\\Users\\user1\\Documents\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\cover\\"+ orgName); // 업로드
		//File copy = new File("D:\\kh\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\cover\\"+ orgName); // 업로드/(데탑)
		System.out.println("insert Cover Image");
		System.out.println(copy);
		try {
			mf.transferTo(copy);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		request.setAttribute("mem_num", mem_num);	//세션 아이디의 mem_num아님
		
		return "/member/MyUsedUploadPro.jsp";
	}
}
